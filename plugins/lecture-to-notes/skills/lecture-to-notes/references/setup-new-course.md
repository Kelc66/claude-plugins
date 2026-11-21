# First-time setup for a new course

Use this when there is no progress file and no old `notes-index.md`. The goal is to be set up in ONE question message and ONE confirmation message.

## 1. Pre-fill what you can

Before asking, look at what is already there:
- the Project name and description, and the Project files (course name, code and university are often in them);
- any uploaded slides (course name and lecture number from the title page);
- the environment (`references/no-docs-fallback.md`), which decides where notes and scripts go.

## 2. Ask: one message, at most ~6 questions, defaults filled in

Use this shape. Put your pre-filled guesses in place of the defaults. The user should be able to reply "ok" to accept everything.

> Let's set up **<course guess>** (one time only). Reply "ok" to accept, or tell me what to change:
> 1. **Course:** <name> (<code>), <university>. University is optional.
> 2. **Slides:** you upload them in each chat *(default)*, or they're in the Project files.
> 3. **Programming:** does this course use MATLAB, Python, or no programming at all? *(default: <your guess>)*. If you use scripts, where should they go on your PC? *(default: sent in chat only; you save them yourself)*
> 4. **Notes docs:** <the list for that answer, see below>. Drop any you don't want.
> 5. **Style:** my default tutoring style: plain-words explanations, WHY before HOW, one running example per lecture, every symbol explained, highlighted conclusions, decision flowcharts. Keep it, or tell me what to change.
> 6. **Exam** (optional): written or oral, allowed aids, typical question types, if you know them.

Rules:
- **Guess the programming answer from the course.** Control, signals, numerical methods, statistics or data courses → MATLAB or Python, based on what the slides show. Non-programming courses (history, law, economics without coding, languages, biology, philosophy, most humanities) → `none`.
- **The doc list depends on that answer:**
  - MATLAB / Python → Theory by Lecture, Theory by Procedure, <Language> Reference, Prepared Scripts (all four).
  - `none` → **only Theory by Lecture**, plus Theory by Procedure if the course has step-by-step methods (calculations, proofs, lab or analysis methods). Don't offer Command Reference or Prepared Scripts at all, and don't ask about a script folder.
- For a non-programming course, also drop the script bullets from the style summary in question 5.
- In Claude Code, question 3's folder defaults to `scripts/` in the current folder.
- In Claude Code with the Claude Docs tools available, add one choice: "notes as Claude Docs, or as markdown files in `notes/`?" *(default: markdown files)*.

## 3. Create the notes (headings only)

Doc titles: `<Course short name> – Theory by Lecture`, `– Theory by Procedure`, `– MATLAB Reference` / `– Python Reference` (the "Command Reference" doc, named after the language), `– Prepared Scripts`.

**Claude Docs (claude.ai):**
- Load the docs skill (or call `guide` with `topic.index`) before the first docs call.
- Create each chosen doc with only its title as H1 and one line saying what it holds:
  - *Theory by Lecture:* "Concepts in lecture order: why each one matters, the key formulas, and exam takeaways."
  - *Theory by Procedure:* "Numbered step-by-step procedures (by hand + in <language>), in the order they were taught."
  - *Reference:* "<language> commands used in this course, grouped by topic."
  - *Prepared Scripts:* "The scripts saved on my PC: what each one needs, what it gives, and how to use it."
- Read each new doc's outline and record its **link, doc id and body node id**. The body node id is the ref used for later inserts.

**Markdown (Claude Code or no Docs tools):** create only the chosen files out of `notes/theory-by-lecture.md`, `notes/theory-by-procedure.md`, `notes/command-reference.md` and `notes/prepared-scripts.md`, with the same H1 titles and purpose lines. In the Documents table, put the relative path in the *Link* column and `-` in both id columns.

## 4. Write the progress file

Copy `templates/course-progress.md` and fill it in:
- *Settings* from the answers (Storage, Script language, Script folder, Slides source, Exam format).
- *Documents*: one row per created doc.
- *Lecture status*: empty table. *Next free procedure number*: 1.
- *Style rules*: copy the bullets from `references/style.md` (without the Matrices and Scripts parts if they don't fit the course), then apply the user's changes.
- Script language `none`: write `Script folder on PC: -` and leave the *Scripts* table empty.
- *Log*: `YYYY-MM-DD: course set up (<docs created>, scripts: <language>)`.

Write it with `project_write` (`claude/course-progress.md`) or as `notes/course-progress.md`.

## 5. Confirm in one short message

List the doc links (or file paths) and where scripts will go. Point out that the user can change any setting or style rule by asking, or by editing the progress file. If lecture material is already in the chat, go straight on to phase 1. Otherwise ask for the first lecture's slides + notes.
