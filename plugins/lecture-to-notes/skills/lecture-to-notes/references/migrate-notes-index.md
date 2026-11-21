# Migrating an old `notes-index.md`

Older versions of this workflow kept course memory in `claude/notes-index.md`. Convert it into `claude/course-progress.md` (locally: `notes/notes-index.md` → `notes/course-progress.md`) **without losing anything**.

## 1. Offer it

In one line: "I found your old `notes-index.md`. Shall I convert it into `course-progress.md`? Nothing is lost and the old file stays." Wait for a yes. If the user declines, use `notes-index.md` read-only for this session and don't write any progress file.

## 2. Read everything

Read the whole old file. Also read the Project's file list, since the course name is often only in the Project name.

## 3. Map old → new

| Old content | New place |
| --- | --- |
| Course / project name | Settings → Course |
| PC folder for scripts | Settings → Script folder on PC |
| Script language (MATLAB if it only mentions .m files / MATLAB) | Settings → Script language |
| Doc table (names, links, doc ids, body node ids) | Documents. Copy the ids **exactly** and keep the doc names as they are (don't rename "MATLAB Reference"). |
| Procedure list + next free number | Numbering → Procedure list + Next free procedure number |
| Scripts on the PC | Scripts table. Kind: template / learning / exam, guessed from the name (`_learn_` = learning). |
| Style rules / preferences | Style rules, **verbatim**. Don't replace them with the defaults. |
| Running examples | Running examples |
| Notation, traps | Notation |
| Open items / TODOs | Open items |
| Progress log | Log, verbatim, oldest first |
| Anything that fits nowhere | a final `## Other (migrated)` section, verbatim |

Settings that didn't exist before get these values:
- Storage: claude.ai Project + Claude Docs
- Slides source: uploads per chat
- Exam format: unknown, or whatever the old file says

## 4. Build the Lecture status table from the log

One row per lecture mentioned anywhere (log, procedure list, scripts table):
- **Explained:** ✓ if the log says it was explained or written up.
- **Docs written:** ✓ if the log says the docs were written. "partial" if only some were.
- **Procedures:** the numbers belonging to that lecture.
- **Scripts:** the file names belonging to that lecture.
- **Open questions:** related open items, or `-`.

If something is unclear, write `?` rather than guessing ✓.

## 5. Write, verify, retire the old file

1. Write `course-progress.md` (full file).
2. Re-read it and check the counts against the old file: number of docs, procedures, scripts and log lines. Fix any mismatch.
3. Old file: change only its first heading to `# SUPERSEDED by course-progress.md – kept for reference`. Keep the rest unchanged and write it back. **Never delete it.**
4. Tell the user in 2–3 lines what was converted (the counts), and mention any `?` cells or the `Other (migrated)` section. Then continue with the lecture.
