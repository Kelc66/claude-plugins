---
name: lecture-to-notes
description: Turn a university lecture (slides plus the student's own notes) into a tutor-style explanation in chat, then, after the user confirms a plan, into exam notes (Theory by Lecture, Theory by Procedure, and for programming courses also Command Reference, Prepared Scripts and MATLAB or Python scripts). Works for any subject. Each course keeps one progress file (claude/course-progress.md in the course's claude.ai Project, or notes/course-progress.md in a local folder) with settings, doc ids, numbering, style rules and a lecture status table. Use when the user names this skill, asks to go through, explain or write up lecture N of a course, wants to set up a course for lecture notes, or wants to migrate an old notes-index.md. Do not use for general homework questions, coding unrelated to a lecture, or documents that are not course notes.
---

# Lecture → explanation → exam notes + scripts

Five phases. Phases 1–2 are conversation only. Nothing goes into the notes docs, script files or the user's PC until the user confirms the plan in phase 3. The only exception is the bookkeeping in the progress file (phase 5).

## 0. Load the course progress file (every run, first)

The skill remembers nothing between chats. All course memory lives in **one progress file per course**.

**Detect the environment from the tools you have** (details: `references/no-docs-fallback.md`):
- **claude.ai with a Project attached** (Projects tool: `project_read` / `project_write`): progress file `claude/course-progress.md` in the Project. Notes go in Claude Docs and scripts go through the desktop folder bridge.
- **No Projects tool** (e.g. Claude Code): progress file `notes/course-progress.md` in the current folder. Notes are markdown files in `notes/` and scripts go in `scripts/`.

Then:
1. **Progress file found** → read all of it. It is the source of truth for settings, doc ids, numbering, scripts, style rules, running examples and notation. **Where the progress file and this skill disagree, the progress file wins**, because it holds the user's own decisions. Glance at the *Lecture status* table and mention gaps in one line (e.g. "Lecture 13 was explained but never written up. Do that now?"). Then go to phase 1.
2. **Not found, but `claude/notes-index.md` (or `notes/notes-index.md`) exists** → offer to migrate it. Follow `references/migrate-notes-index.md`, then continue.
3. **Neither found** → first-time setup. Follow `references/setup-new-course.md`, then continue.
4. **claude.ai with no Project attached** → say in one line that this skill needs a Project (one per course) to remember progress, and offer the in-chat explanation (phase 2) only. Write nothing. Never guess doc ids or create stray docs.

One chat = one lecture. The user may run several chats in parallel, so only write content for this chat's lecture.

**Not every course is a programming course.** If *Script language* is `none` (e.g. history, law, biology, languages), there is no Command Reference, no Prepared Scripts and no scripts. Skip them everywhere: in the plan, in writing and in the final reply. Only use the docs listed in the *Documents* table. If the user later wants scripts, set the language, create the two missing docs (`references/setup-new-course.md` → step 3) and add them to the progress file.

## 1. Read the material

Inputs: the lecture slides and the user's own notes (handwritten, typed or a OneNote export). Extraction methods: `references/reading-material.md`.
- Confirm the lecture number from the slide title, not the file name. If it is unclear, ask.
- Collect the professor's explanations and analogies, corrections to the slides ("this is wrong"), and anything marked as exam-relevant.

## 2. Explain in chat (no writes)

Follow the *Style rules* in the progress file (defaults: `references/style.md`) and `references/explaining.md`. In short:
- Open with one sentence on what you are about to do. Then go in slide order: one clean, linear derivation with one running example. Say WHY before HOW, and explain every symbol in plain words.
- Weave the user's notes into the explanation. Flag exam-relevant items and fill in what the slides leave blank.
- Draw a dummy-proof decision flowchart whenever the lecture contains a decision procedure.
- Keep answers to follow-ups short. Answer a yes/no question in the first line.

## 3. Plan and confirm

When the user asks to write it up, post a short plan and **wait for confirmation**. Only include the docs listed in the progress file.
1. **Theory by Lecture:** `## Lecture N – <title>`, its numbered `###` sections, and "Exam takeaways".
2. **Theory by Procedure** (if used): the new procedures, numbered from *Next free procedure number*, each `<n>. <title> (Lecture N)`. If the lecture has no step-by-step methods, say "no new procedures".
3. **Diagrams:** which flowcharts go into the docs, and under which procedure.
4. **Command Reference** (only if a script language is set): the title of the new table.
5. **Scripts** (only if a script language is set): for each one, the file name, its kind (template / learning / exam) and one line on what it does. Use separate scripts when the methods differ.
6. Anything that might belong to another lecture: ask.

Apply the user's additions or removals, then go to phase 4. Don't touch other docs (e.g. exam cheat sheets) unless asked.

## 4. Write

- **Docs:** `references/doc-formats.md`. Before writing, read each doc's outline and the previous lecture's section, and copy their format exactly.
- **Scripts** (skip if the language is `none`): `references/scripts-matlab.md` or `references/scripts-python.md`. Verify the expected numbers, and say honestly what was run and what was not.
- **A tool is missing** (no Claude Docs, no folder bridge): `references/no-docs-fallback.md`. Never claim to have written a doc or file that wasn't written.
- If the user adds a request mid-work, fold it in right away and say where it went.

## 5. Wrap up

1. **Update the progress file.** Template: `templates/course-progress.md`.
   - Re-read the file right before writing, because another chat may have changed it.
   - Merge your changes into that latest version and write the FULL file. Never drop rows or lines written by others.
   - Update: the *Lecture status* row, *Numbering* (next free procedure number + procedure list), *Scripts*, *Running examples*, *Notation*, *Open items*, any new style preference the user expressed, and one *Log* line `YYYY-MM-DD: Lecture N – <what was done>`.
   - Also update the file after an explanation-only session (mark *Explained*), so gaps show up next time. Mention it in one line.
2. **Final reply, short:** what went where (doc links or file paths), the scripts, what was verified and what was not, and one natural next step. Don't recap the steps.
