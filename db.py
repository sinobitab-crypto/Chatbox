"""
Reliable HATIM chatbot database layer.

Uses the actual hatim_database selected by .env and searches:
1. The unified v_full_chatbot_knowledge view when available.
2. Every real knowledge table dynamically via information_schema.

The search is intentionally done mostly in Python after safely reading rows.
This avoids the SQL placeholder/column-name problems that caused the previous
versions to return no results.
"""

import os
import re
import mysql.connector
from mysql.connector import pooling

DB_CONFIG = {
    "host": os.getenv("DB_HOST", "localhost"),
    "port": int(os.getenv("DB_PORT", "3306")),
    "user": os.getenv("DB_USER", "root"),
    "password": os.getenv("DB_PASSWORD", ""),
    "database": os.getenv("DB_NAME", "hatim_database"),
    "charset": "utf8mb4",
    "use_unicode": True,
}

print(f"[HATIM DB] Loading database layer: {__file__}")
print(f"[HATIM DB] Target database: {DB_CONFIG['database']}")

pool = pooling.MySQLConnectionPool(
    pool_name="hatim_pool_reliable",
    pool_size=5,
    pool_reset_session=True,
    **DB_CONFIG,
)


def get_connection():
    return pool.get_connection()


def test_connection():
    conn = get_connection()
    cur = conn.cursor()
    try:
        cur.execute("SELECT DATABASE(), VERSION()")
        database, version = cur.fetchone()
        return {"database": database, "mysql_version": version}
    finally:
        cur.close()
        conn.close()


def ensure_chat_tables():
    conn = get_connection()
    cur = conn.cursor()
    try:
        cur.execute("""
            CREATE TABLE IF NOT EXISTS conversations (
                id INT AUTO_INCREMENT PRIMARY KEY,
                session_id VARCHAR(100) NOT NULL,
                started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                INDEX idx_conversations_session_id (session_id)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
        """)
        cur.execute("""
            CREATE TABLE IF NOT EXISTS messages (
                id INT AUTO_INCREMENT PRIMARY KEY,
                conversation_id INT NOT NULL,
                sender ENUM('user','bot') NOT NULL,
                message TEXT NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                INDEX idx_messages_conversation_id (conversation_id),
                CONSTRAINT fk_messages_conversation
                    FOREIGN KEY (conversation_id)
                    REFERENCES conversations(id)
                    ON DELETE CASCADE
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
        """)
        conn.commit()
    finally:
        cur.close()
        conn.close()


def get_database_tables():
    conn = get_connection()
    cur = conn.cursor()
    try:
        cur.execute("""
            SELECT table_name
            FROM information_schema.tables
            WHERE table_schema = DATABASE()
              AND table_type = 'BASE TABLE'
            ORDER BY table_name
        """)
        return [r[0] for r in cur.fetchall()]
    finally:
        cur.close()
        conn.close()


STOPWORDS = {
    "a", "an", "and", "are", "about", "am", "at", "be", "can", "could",
    "do", "does", "for", "from", "give", "how", "i", "in", "is", "it",
    "me", "of", "on", "or", "please", "tell", "the", "there", "this",
    "that", "to", "what", "when", "where", "which", "who", "with",
    "would", "you", "your", "college", "hatim", "information", "details",
    "much", "please", "my", "our", "we", "us", "was", "were", "are"
}

ALIASES = {
    "institution": "college institution about hatim",
    "source_pages": "website pages source website information",
    "departments": "departments subjects faculty academic departments hod head of department departmental head chairperson",
    "courses": "courses course programmes programs degrees study",
    "add_on_courses": "add on courses certificate computer english research methodology",
    "skill_courses": "skill courses training",
    "fees": "fees fee tuition cost costs charges payment amount",
    "admission_criteria": "admission admissions eligibility requirements qualification apply application",
    "bus_fares": "bus buses transport transportation fare fares charges cost monthly semester one way route",
    "facilities": "facilities facility campus amenities infrastructure",
    "staff": "staff faculty teachers lecturers principal vice principal librarian employees hod head of department",
    "committees": "committees committee cells governance",
    "committee_members": "committee members governance people",
    "library_categories": "library categories resources question bank lecture videos research papers project syllabus",
    "library_departments": "library departments computer science commerce social work english philosophy psychology history education",
    "library_resources": "library books resources syllabus question bank videos research papers projects",
    "notices_news": "news notice notices announcements events",
    "alumni": "alumni former students graduates association",
    "academic_calendar_items": "academic calendar semester dates examinations holidays events",
    "awards_results": "awards results achievements recognition",
    "institutional_information": "vision mission values objectives institutional information",
    "milestones": "history historical milestones establishment timeline",
    "prospectus_pages": "prospectus brochure pages admission fees courses facilities hostel campus",
    "website_inventory": "website web page online information",
    "cafeteria": "cafeteria menus",
    "menu": "cafeteria menus",
}


def _norm(text):
    text = str(text or "").lower()
    text = re.sub(r"[_\-/]+", " ", text)
    text = re.sub(r"[^a-z0-9]+", " ", text)
    return " ".join(text.split())


def _words(text):
    raw = _norm(text).split()
    result = []
    for w in raw:
        if len(w) < 2 or w in STOPWORDS:
            continue
        result.append(w)
        if w.endswith("ies") and len(w) > 4:
            result.append(w[:-3] + "y")
        elif w.endswith("s") and len(w) > 3:
            result.append(w[:-1])
    # semantic expansions
    original = set(result)
    if "bus" in original or "buses" in original:
        result += ["bus", "fare", "fares", "transport"]
    if "fare" in original or "fares" in original:
        result += ["bus", "transport"]
    if "hostel" in original or "hostels" in original:
        result += ["hostel", "hostels", "residence", "residential"]
    if "principal" in original:
        result += ["principal", "staff", "administrative"]
    if "hod" in original or ("head" in original and "department" in original):
        result += ["hod", "head", "department", "staff", "chairperson"]
    if "teacher" in original or "teachers" in original or "faculty" in original:
        result += ["staff", "teacher", "faculty"]
    if "fee" in original or "fees" in original:
        result += ["fee", "fees", "cost", "amount", "charges"]
    if "course" in original or "courses" in original:
        result += ["course", "courses", "programme", "program"]
    if "admission" in original or "admissions" in original:
        result += ["admission", "eligibility", "requirement", "apply"]
    if "library" in original:
        result += ["library", "resource", "resources", "books", "syllabus"]

    seen = set()
    return [x for x in result if not (x in seen or seen.add(x))]


def _table_score(table, query_words):
    text = f"{table.replace('_', ' ')} {ALIASES.get(table, '')}".lower()
    score = 0
    for w in query_words:
        if w in text:
            score += 12
        if w in table.replace("_", " ").lower():
            score += 20

    if {"bus", "fare"} & set(query_words) and table == "bus_fares":
        score += 150
    if "principal" in query_words and table in {"staff", "source_pages", "prospectus_pages"}:
        score += 80
    if "hod" in query_words and table in {
        "staff", "departments", "committees", "committee_members",
        "source_pages", "prospectus_pages",
    }:
        score += 80
    if {"hostel", "residence"} & set(query_words) and table in {
        "prospectus_pages", "source_pages", "fees", "facilities"
    }:
        score += 60
    return score


def _columns(cur, table):
    cur.execute("""
        SELECT column_name
        FROM information_schema.columns
        WHERE table_schema = DATABASE()
          AND table_name = %s
        ORDER BY ordinal_position
    """, (table,))
    rows = cur.fetchall()
    result = []
    for r in rows:
        # Some MySQL/MariaDB versions return the dict key as
        # 'column_name', others as 'COLUMN_NAME'. Handle both safely
        # instead of assuming one case.
        if "column_name" in r:
            result.append(r["column_name"])
        elif "COLUMN_NAME" in r:
            result.append(r["COLUMN_NAME"])
        else:
            # Fallback: just take whatever single value is present.
            result.append(next(iter(r.values())))
    return result


def _stringify_row(row):
    parts = []
    for key, value in row.items():
        if value is None or str(value).strip() == "":
            continue
        if key.lower() in {"id", "source_id", "institution_id", "course_id",
                           "department_id", "fee_id", "criterion_id"}:
            continue
        parts.append(f"{key.replace('_', ' ').title()}: {value}")
    return "\n".join(parts)


def _row_score(table, row, query_words):
    # Score every visible field plus table metadata.
    row_text = " ".join(
        f"{k} {v}" for k, v in row.items() if v is not None
    )
    normalized = _norm(
        f"{table.replace('_', ' ')} {ALIASES.get(table, '')} {row_text}"
    )

    score = _table_score(table, query_words)
    for word in query_words:
        if word in normalized:
            score += 5
            # Exact field value/name match is stronger.
            for key, value in row.items():
                field = _norm(f"{key} {value}")
                if word in field:
                    score += 3

    # Strong combination for bus fare rows: once bus_fares is selected,
    # every fare row is relevant even though "bus" and "fare" are not stored
    # inside each row.
    if table == "bus_fares" and (
        ("bus" in query_words) or ("fare" in query_words)
    ):
        score += 100

    return score


def _format_result(table, row, source_url=""):
    # Special formatting for bus fares so all fare fields are visible.
    if table == "bus_fares":
        point = row.get("bus_point") or row.get("point") or "Unknown point"
        monthly = row.get("monthly", row.get("monthly_fare", ""))
        semester = row.get("per_semester", row.get("semester_fare", ""))
        one_way = row.get("one_way", row.get("one_way_fare", ""))
        answer = (
            f"Bus fare for {point}: "
            f"₹{monthly}/month, "
            f"₹{semester}/semester, "
            f"₹{one_way} one-way."
        )
    else:
        label = ALIASES.get(table, table.replace("_", " ").title())
        body = _stringify_row(row)
        answer = f"{table.replace('_', ' ').title()}:\n{body}"

    if not source_url:
        for key in ("source_url", "url", "website", "resource_url", "link"):
            if row.get(key):
                source_url = str(row[key])
                break

    return {
        "question": "",
        "answer": answer,
        "source_url": source_url or "",
        "table": table,
        "table_name": table,
    }


def _search_view(cur, query_words, limit):
    """
    Search the SQL view that was deliberately included in the HATIM SQL.
    It contains full website/prospectus text and structured content.
    """
    try:
        cur.execute("""
            SELECT source_kind, record_id, title, source_url, content
            FROM v_full_chatbot_knowledge
        """)
        rows = cur.fetchall()
    except mysql.connector.Error:
        return []

    results = []
    for row in rows:
        combined = _norm(
            f"{row.get('source_kind','')} {row.get('title','')} "
            f"{row.get('content','')}"
        )
        score = 0
        for word in query_words:
            if word in combined:
                score += 7
                if word in _norm(row.get("title", "")):
                    score += 12

        if score:
            results.append((
                score,
                {
                    "question": "",
                    "answer": (
                        f"{row.get('title') or row.get('source_kind') or 'HATIM'}:\n"
                        f"{row.get('content') or ''}"
                    ),
                    "source_url": row.get("source_url") or "",
                    "table": row.get("source_kind") or "v_full_chatbot_knowledge",
                    "table_name": row.get("source_kind") or "v_full_chatbot_knowledge",
                }
            ))

    results.sort(key=lambda x: x[0], reverse=True)
    return results[:limit]


def search_college_info(query, limit=10):
    """
    Search HATIM naturally across the unified knowledge view and ALL
    structured tables. No SQL table name is required from the user.
    """
    query_words = _words(query)
    print(f"[HATIM SEARCH] Query: {query!r} | words: {query_words}")
    if not query_words:
        return []

    conn = get_connection()
    cur = conn.cursor(dictionary=True)

    try:
        results = []

        # 1) Full source/prospectus/website knowledge.
        results.extend(_search_view(cur, query_words, limit * 2))

        # 2) Structured tables. We read rows safely and rank them in Python.
        # This deliberately avoids the dynamic CONCAT/placeholder SQL that
        # caused the earlier search versions to silently return no rows.
        tables = get_database_tables()

        for table in tables:
            if table in {"conversations", "messages", "data_import_summary"}:
                continue

            tscore = _table_score(table, query_words)

            # Only inspect tables that are semantically related to the query,
            # except that a generic source table is useful for broad questions.
            if tscore <= 0 and table not in {
                "source_pages", "prospectus_pages", "website_inventory"
            }:
                continue

            try:
                cols = _columns(cur, table)
                if not cols:
                    continue

                # Cap rows so a large table cannot make chat slow.
                cur.execute(
                    f"SELECT * FROM `{table.replace('`','``')}` LIMIT 2000"
                )
                rows = cur.fetchall()

                for row in rows:
                    score = _row_score(table, row, query_words)
                    if score <= 0:
                        continue

                    source = ""
                    for k in ("source_url", "url", "resource_url", "website"):
                        if row.get(k):
                            source = str(row[k])
                            break

                    results.append((
                        score,
                        _format_result(table, row, source)
                    ))
            except mysql.connector.Error as exc:
                print(f"[SEARCH TABLE SKIPPED] {table}: {exc}")
                continue

        # 3) Rank + deduplicate.
        results.sort(key=lambda x: x[0], reverse=True)

        # If most/all of the top matches come from a single table (e.g. every
        # row of bus_fares matching a "bus fare" query), that table is the
        # whole answer — don't cut it off at the generic `limit`. Only cap
        # results when they're a mixed bag from several tables.
        effective_limit = limit
        MAX_DOMINANT_ROWS = 60  # safety cap so one huge table can't blow up the prompt

        if results:
            top_table = results[0][1].get("table_name")
            dominant_count = sum(
                1 for _, r in results if r.get("table_name") == top_table
            )
            if dominant_count > limit:
                effective_limit = min(dominant_count, MAX_DOMINANT_ROWS)

        final = []
        seen = set()

        for score, result in results:
            key = result["answer"].strip().lower()
            if key in seen:
                continue
            seen.add(key)
            result["relevance"] = score
            final.append(result)

            if len(final) >= effective_limit:
                break

        print(f"[HATIM SEARCH] Results returned: {len(final)}")
        if final:
            print("[HATIM SEARCH] Top table:", final[0].get("table_name"))
        return final

    finally:
        cur.close()
        conn.close()


def get_or_create_conversation(session_id):
    conn = get_connection()
    cur = conn.cursor(dictionary=True)
    try:
        cur.execute("""
            SELECT id FROM conversations
            WHERE session_id = %s
            ORDER BY id DESC LIMIT 1
        """, (session_id,))
        row = cur.fetchone()
        if row:
            return row["id"]

        cur.execute(
            "INSERT INTO conversations (session_id) VALUES (%s)",
            (session_id,)
        )
        conn.commit()
        return cur.lastrowid
    finally:
        cur.close()
        conn.close()


def save_message(conversation_id, sender, message):
    if sender not in ("user", "bot"):
        raise ValueError("sender must be 'user' or 'bot'")

    conn = get_connection()
    cur = conn.cursor()
    try:
        cur.execute("""
            INSERT INTO messages (conversation_id, sender, message)
            VALUES (%s, %s, %s)
        """, (conversation_id, sender, message))
        conn.commit()
    finally:
        cur.close()
        conn.close()


def get_history(session_id):
    conn = get_connection()
    cur = conn.cursor(dictionary=True)
    try:
        cur.execute("""
            SELECT m.sender, m.message, m.created_at
            FROM messages m
            INNER JOIN conversations c ON c.id = m.conversation_id
            WHERE c.session_id = %s
            ORDER BY m.id ASC
        """, (session_id,))
        return cur.fetchall()
    finally:
        cur.close()
        conn.close()


ensure_chat_tables()
