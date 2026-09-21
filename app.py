"""load_dotenv(override=True)
app.py - Flask backend for the HATIM college chatbot.

Endpoints:
    GET  /health
    GET  /db-test
    GET  /db-tables
    GET  /history/<session_id>
    POST /chat

POST /chat JSON:
    {
        "session_id": "browser-session-123",
        "message": "What courses does HATIM offer?"
    }

The backend searches the supplied HATIM MySQL database first.
If GROQ_API_KEY/AI_API_KEY is configured, the retrieved database context
is sent to the AI model. The AI is instructed not to invent information.
"""

import os
import requests
from flask import Flask, request, jsonify
from flask_cors import CORS
from dotenv import load_dotenv

# Load .env BEFORE importing db.py because db.py reads DB_* variables
# when it creates the connection pool.
load_dotenv(override=True)

import db


app = Flask(__name__)
CORS(app)


# ------------------------------------------------------------
# AI CONFIGURATION
# ------------------------------------------------------------

AI_API_KEY = (
    os.getenv("GROQ_API_KEY")
    or os.getenv("AI_API_KEY")
)

AI_API_URL = os.getenv(
    "AI_API_URL",
    "https://api.groq.com/openai/v1/chat/completions"
)

GROQ_MODEL = os.getenv(
    "GROQ_MODEL",
    "openai/gpt-oss-120b"
)


def build_context(rows):
    if not rows:
        return "No matching information was found in the HATIM database."

    parts = []

    for row in rows:
        source = row.get("source_url", "")
        table = row.get("table_name") or row.get("table", "")

        item = row["answer"]

        if table:
            item = f"Database table: {table}\n{item}"

        if source:
            item += f"\nSource: {source}"

        parts.append(item)

    return "\n\n".join(parts)


def fallback_answer(rows):
    """
    Database-only fallback when no AI API key is configured.
    This means the chatbot can still be tested without an API key.
    """
    if not rows:
        return "Please try agaian."

    # Return the strongest few database results.
    text = "\n\n".join(
        row["answer"]
        for row in rows[:3]
    )

    return text


def ask_ai(user_message, context_rows):
    """
    Generate an answer using ONLY retrieved HATIM database context.
    """
    context = build_context(context_rows)

    if not AI_API_KEY:
        return fallback_answer(context_rows)

    system_prompt = f"""
You are the HATIM college information assistant.

Use ONLY the HATIM database information supplied below.
Do not use outside knowledge.
Do not invent missing facts.

Rules:
1. If the database contains the answer, answer clearly and directly.
2. Preserve dates, numbers, fees, percentages, phone numbers and names exactly.
3. If information conflicts, do not silently choose one; say that the database
   contains conflicting information.
4. If the requested information is not present, say:
   "Please try again."
5. Do not claim that you visited the website.
6. Do not make up links.
7. Keep the answer concise unless the user asks for detailed information.
8. If the database context below contains a list of multiple items (e.g. every
   bus stop, every course, every fee), include ALL of them in your answer —
   do not shorten, sample, or drop any rows for brevity.
9. Whenever the answer involves multiple items that share the same fields
   (e.g. bus stops with fares, courses with durations, fees by department),
   format the answer as a markdown table with a header row — for example:
   | Stop | Monthly | Semester | One-way |
   |------|---------|----------|---------|
   | Theriat | ₹1750.00 | ₹8500.00 | ₹150.00 |
   Do NOT use a bullet or numbered list for this kind of data. Only use plain
   prose (no table) when the answer is a single fact or a short paragraph.
10. When greeted with "hello, hi, good (morning|afternoon|evening|night)" reply politely.
11. when asked about the previous principal, reply with "The previous Principal is Vuansanga Vanchhawng".
12. if user uses agressive words like the "f word", reply with "What did i do to deserve this???"

HATIM DATABASE CONTEXT:
{context}
"""

    payload = {
        "model": GROQ_MODEL,
        "messages": [
            {
                "role": "system",
                "content": system_prompt,
            },
            {
                "role": "user",
                "content": user_message,
            },
        ],
        "temperature": 0.1,
        "max_tokens": 2000,
    }

    try:
        response = requests.post(
            AI_API_URL,
            headers={
                "Authorization": f"Bearer {AI_API_KEY}",
                "Content-Type": "application/json",
            },
            json=payload,
            timeout=30,
        )

        if not response.ok:
            print(
                "AI API error:",
                response.status_code,
                response.text,
            )
            return fallback_answer(context_rows)

        data = response.json()

        choices = data.get("choices", [])
        if not choices:
            return fallback_answer(context_rows)

        message = choices[0].get("message", {})
        answer = message.get("content", "")

        if not answer:
            return fallback_answer(context_rows)

        return answer.strip()

    except requests.RequestException as exc:
        print("AI request error:", exc)
        return fallback_answer(context_rows)

    except (ValueError, KeyError, TypeError) as exc:
        print("AI response parsing error:", exc)
        return fallback_answer(context_rows)


# ------------------------------------------------------------
# CHAT
# ------------------------------------------------------------
import re

SMALL_TALK = [
    (r"^(hi+|hello+|hey+|hii+|good (morning|afternoon|evening)|namaste|greetings)\b",
     "Hello! I'm IVY, the HATIM college assistant. Ask me about courses, fees, "
     "admissions, faculty, the academic calendar or notices."),
    (r"^(thanks|thank you|thx|ty|thank u)\b",
     "You're welcome! Let me know if you need anything else about HATIM."),
    (r"^(bye|goodbye|see you|see ya|good night)\b",
     "Goodbye! Feel free to come back if you have more questions about HATIM."),
    (r"^(who are you|what are you|what is your name|your name)\b",
     "I'm IVY, an assistant that answers questions using the HATIM college database."),
    (r"^(help|what can you do|what can i ask|how does this work)\b",
     "I can answer questions about HATIM's courses, fees, admission criteria, bus fares, "
     "faculty, facilities, library, academic calendar and notices. Just ask!"),
    (r"^(how are you|how r u|how are u)\b",
     "I'm doing well, thanks! How can I help you with HATIM today?"),
]


def small_talk_reply(message):
    text = message.lower().strip(" !.?,")
    for pattern, reply in SMALL_TALK:
        if re.match(pattern, text):
            return reply
    return None;

@app.route("/chat", methods=["POST"])
def chat():
    try:
        body = request.get_json(silent=True) or {}

        session_id = str(
            body.get("session_id") or "anonymous"
        ).strip()

        user_message = str(
            body.get("message") or ""
        ).strip()

        if not user_message:
            return jsonify({
                "error": "message is required"
            }), 400

        if len(user_message) > 5000:
            return jsonify({
                "error": "message is too long"
            }), 400

        conversation_id = db.get_or_create_conversation(
            session_id
        )

        db.save_message(
            conversation_id,
            "user",
            user_message,
        )

        context_rows = db.search_college_info(
            user_message,
            limit=30,
        )
        print(f"[CHAT] Search results: {len(context_rows)}")
        if context_rows:
            print(
                "[CHAT] Top source:",
                context_rows[0].get("table_name")
                or context_rows[0].get("table")
            )

        ai_reply = ask_ai(
            user_message,
            context_rows,
        )

        db.save_message(
            conversation_id,
            "bot",
            ai_reply,
        )

        return jsonify({
            "reply": ai_reply,
            "sources": context_rows,
        })

    except Exception as exc:
        import traceback
        print("CHAT ERROR:", repr(exc))
        traceback.print_exc()

        return jsonify({
            "error": "The chatbot could not process the request.",
            "details": str(exc),
        }), 500


# ------------------------------------------------------------
# HISTORY
# ------------------------------------------------------------

@app.route("/history/<session_id>", methods=["GET"])
def history(session_id):
    try:
        return jsonify(
            db.get_history(session_id)
        )
    except Exception as exc:
        print("HISTORY ERROR:", repr(exc))
        return jsonify({
            "error": "Could not load chat history.",
            "details": str(exc),
        }), 500


# ------------------------------------------------------------
# HEALTH / DATABASE TEST
# ------------------------------------------------------------

@app.route("/health", methods=["GET"])
def health():
    return jsonify({
        "status": "ok",
        "service": "HATIM chatbot",
    })


@app.route("/db-test", methods=["GET"])
def db_test():
    try:
        info = db.test_connection()

        return jsonify({
            "status": "connected",
            **info,
        })

    except Exception as exc:
        print("DATABASE ERROR:", repr(exc))

        return jsonify({
            "status": "error",
            "error": str(exc),
        }), 500


@app.route("/db-tables", methods=["GET"])
def db_tables():
    try:
        tables = db.get_database_tables()

        return jsonify({
            "database": os.getenv(
                "DB_NAME",
                "schema_hatim"
            ),
            "tables": tables,
        })

    except Exception as exc:
        return jsonify({
            "status": "error",
            "error": str(exc),
        }), 500


# ------------------------------------------------------------
# START SERVER
# ------------------------------------------------------------

if __name__ == "__main__":
    app.run(
        host="127.0.0.1",
        port=int(os.getenv("PORT", "5000")),
        debug=True,
    )
