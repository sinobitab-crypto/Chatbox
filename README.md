# College Chatbot Backend (Python + MySQL + Flask)

## How it works
Frontend → `POST /chat` → Flask looks up relevant rows in your MySQL
`college_info` table → sends the question + that info to the AI model →
saves the conversation → returns the answer to the frontend.

## 1. Set up MySQL
Make sure MySQL is installed and running, then load the schema:

```bash
mysql -u root -p < schema.sql
```

This creates the `college_chatbot` database with sample tables and a
few example rows so you can test right away. Edit `schema.sql` (or just
run INSERT statements later) to add your real college data — the more
rows you add to `college_info`, the more the bot can answer.

## 2. Install Python dependencies

```bash
pip install -r requirements.txt
```

## 3. Configure environment variables

```bash
cp .env.example .env
```

Then edit `.env` with your MySQL password and (optionally) an AI API key.
If you leave `AI_API_KEY` blank, `/chat` still works — it just returns
the raw matched database info instead of an AI-generated answer, so you
can test the DB wiring before touching AI at all.

## 4. Run the API

```bash
python app.py
```

It starts on `http://localhost:5000`. Test it:

```bash
curl -X POST http://localhost:5000/chat \
  -H "Content-Type: application/json" \
  -d '{"session_id": "test1", "message": "What are the hostel fees?"}'
```

## 5. Connect your frontend
From your JS frontend, call the API like this:

```javascript
const response = await fetch("http://localhost:5000/chat", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({
    session_id: "some-unique-id-per-user",  // e.g. store in localStorage
    message: userInputText
  })
});
const data = await response.json();
console.log(data.reply);
```

CORS is already enabled (`flask-cors`) so this works even if your
frontend runs on a different port (e.g. React dev server on :3000).

## Files
- `schema.sql` — MySQL tables + sample data
- `db.py` — connection pool + search/save functions
- `app.py` — the Flask API (`/chat`, `/history/<session_id>`, `/health`)
- `.env.example` — copy to `.env` and fill in your credentials

## Adding your real college data
Just insert more rows into `college_info`:

```sql
INSERT INTO college_info (category, question, answer, keywords)
VALUES ('Exams', 'When are semester exams?', 'End-semester exams are held in the last week of November and April.', 'exam,semester,schedule,date');
```

The `keywords` column is what the simple search matches against, so
include a few likely words students would type.

## Next steps if you want to go further
- Swap the keyword search in `db.py` for MySQL full-text search (`FULLTEXT` index) for better matching
- Add a `students`/`admin` login table if you need authentication
- Deploy: MySQL on something like PlanetScale/Railway, Flask on Render/Railway, frontend on Vercel/Netlify
