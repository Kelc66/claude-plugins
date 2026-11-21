# Environments and fallbacks

Find out which environment you're in by checking **which tools actually exist**. Don't assume. **Never claim to have written a doc or file that wasn't written.**

## What to look for

| Capability | Tools that prove it | If missing |
| --- | --- | --- |
| Project memory | `project_read`, `project_write` (claude.ai Projects) | local file `notes/course-progress.md` if you can write files; otherwise no memory (see below) |
| Notes docs | Claude Docs tools (`batch`, `update`, `read`, `guide`, …) | markdown files in `notes/` |
| Scripts to the PC | `get_device_info`, `device_request_folder_access`, `device_commit_files` | attach with `SendUserFile`, or paste in chat; in Claude Code write files directly |
| Local files | file read/write tools and a shell (Claude Code) | n/a |
| Flowcharts | Visualizer | text tree in chat, ```mermaid in markdown notes |

## The three common setups

**1. claude.ai, Project attached (the main case)**
- Progress file: `claude/course-progress.md` via `project_read` / `project_write`.
- Notes in Claude Docs, with ids taken from the progress file.
- Scripts via the folder bridge, or attached in chat.

**2. claude.ai, no Project attached**
- Say in one line that the skill needs a Project (one per course) to remember progress.
- Offer phase 2 (explain in chat) only. Write nothing: no docs, no progress file.

**3. Claude Code (terminal / IDE / desktop)**
- Everything lives in the **current folder**, which should be one folder per course:
  ```
  <course folder>/
  ├── notes/
  │   ├── course-progress.md
  │   ├── theory-by-lecture.md
  │   ├── theory-by-procedure.md
  │   ├── command-reference.md
  │   └── prepared-scripts.md
  └── scripts/            ← or the Script folder from Settings
  ```
- If the current folder already looks like something else (a code repo, your home folder), ask once whether this is the right course folder before creating `notes/`.
- Same formats and same workflow as in claude.ai. Re-read the progress file before writing it there too, because the user may run parallel sessions.
- If the Claude Docs tools *are* available (connector), ask once at setup whether notes go to Claude Docs or markdown. Record the answer under *Settings → Storage*.
- MATLAB / Python may really be installed here: try to run the scripts (`scripts-matlab.md` / `scripts-python.md` → Verify).

## A tool fails mid-run

- Finish what you can and report exactly what was written and what wasn't. Give the content of the failed part in chat, so nothing is lost.
- Add an *Open items* line in the progress file (e.g. `- [ ] Lecture 7: Prepared Scripts section not written (docs tool error)`).
- Don't retry the same failing call in a loop.
