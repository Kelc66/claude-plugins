# Kelc66's Claude plugins

A small **plugin marketplace** for Claude: add it once, then browse and install any plugin in it.

| Plugin | What it does | claude.ai download |
| --- | --- | --- |
| [`lecture-to-notes`](plugins/lecture-to-notes) | Turns a university lecture (slides + your notes) into a tutor-style explanation, then exam notes (plus MATLAB/Python scripts for programming courses), and remembers your progress per course. Any subject. | [lecture-to-notes.zip](dist/lecture-to-notes.zip) |

---

## lecture-to-notes

### What it does

You give Claude a lecture: the slides plus your own notes (e.g. a OneNote PDF export with the professor's remarks). The skill then:

1. **explains** the lecture in chat like a good tutor: why before how, one running example, every symbol in plain words, decision flowcharts;
2. after you say "write it up", **proposes a plan** and waits for your OK;
3. **writes exam notes** into *Theory by Lecture* and *Theory by Procedure*;
4. **for programming courses only** (MATLAB or Python), also fills a *Command Reference* and *Prepared Scripts* doc, and makes scripts with a "YOU GIVE / YOU GET / HOW TO USE" header and the lecture examples built in;
5. **updates the course progress file**, so the next chat knows what's done, which procedure number is next, and how you like things explained.

**Works for any subject.** At setup the skill asks whether the course uses programming. For a history, law or biology course, it answers "none" and you only get the theory notes: no command reference, no scripts, no questions about script folders. For a control or data course, you get all four docs plus scripts.

**Example session** (a MATLAB course)

> **You:** *(uploads `Lecture 3.pdf` + `L3 notes.pdf`)* Use lecture-to-notes on lecture 3.
> **Claude:** Lecture 2 was explained but never written up. Want to do that after this? … Let's go through Lecture 3: stability, using the two-tank example all the way through. *(explanation, flowchart, conclusions, exam takeaways)*
> **You:** Is a system with eigenvalues −1 and 0 asymptotically stable?
> **Claude:** No. The eigenvalue 0 never dies out … *(short explanation)*
> **You:** OK, write it up.
> **Claude:** Plan: Theory by Lecture "Lecture 3 – Stability" (5 sections + exam takeaways); procedures 7–8; flowchart under 7; Command Reference "Stability commands (Lecture 3)"; scripts `L3_give_A_get_stability_verdict.m`, `L3_learn_lyapunov.m`. OK?
> **You:** Yes, but skip the learning script.
> **Claude:** *(writes the docs and the script)* Done: links … Script verified in Python, not run in MATLAB. Progress file updated (next procedure: 9).

### Install in claude.ai (web / desktop app)

1. Download [`dist/lecture-to-notes.zip`](dist/lecture-to-notes.zip). On GitHub, open the file and click **Download raw file**. Don't unzip it.
2. In claude.ai go to **Customize → Skills → "+" → Upload a skill**, and choose the zip.
3. Create a **Project for each course** (e.g. "Linear Control 2") and open your chats inside that Project.
4. In a chat in that Project, upload the slides + notes and say *"use lecture-to-notes on lecture 1"*.
5. The **first run asks up to 6 setup questions**: course name, programming (MATLAB/Python/none), script folder (only if you use scripts), which docs, style, exam format. Defaults are filled in, so you can just answer "ok". It then creates the docs and the progress file.

Tip: for best results, turn on the Claude Docs and desktop folder tools if your account has them. Without them the skill still works: it gives you the notes and scripts in chat.

### Install in Claude Code

In Claude Code:

```
/plugin marketplace add Kelc66/claude-plugins
/plugin install lecture-to-notes@kelc66-plugins
```

Or from a normal terminal:

```
claude plugin marketplace add Kelc66/claude-plugins
claude plugin install lecture-to-notes@kelc66-plugins
```

Then make **one folder per course**, open Claude Code in it, and ask it to go through a lecture. Claude Code has no claude.ai Projects or Claude Docs, so everything is stored as files in that folder:

```
My Course/
├── notes/course-progress.md      ← the progress file
├── notes/theory-by-lecture.md
├── notes/theory-by-procedure.md
├── notes/command-reference.md    ← programming courses only
├── notes/prepared-scripts.md     ← programming courses only
└── scripts/                      ← your .m or .py files (programming courses only)
```

In Claude Code the skill can also **run** your MATLAB/Python scripts, if they are installed on your PC.

### How the progress file works

**One Project = one course = one progress file.** The skill itself can't remember anything between chats, so it keeps everything in:

- **claude.ai:** `claude/course-progress.md` inside the course's Project
- **Claude Code:** `notes/course-progress.md` inside the course folder

It holds your settings, the doc links and ids, a **Lecture status** table (explained? written up? which procedures and scripts?), the next free procedure number, the list of scripts, your style rules, the running examples, course notation, open items and a log. Every chat reads it first and updates it at the end. It re-reads the file just before writing, so several chats running in parallel don't overwrite each other.

The template is in [`templates/course-progress.md`](plugins/lecture-to-notes/skills/lecture-to-notes/templates/course-progress.md).

**Migrating from an old `claude/notes-index.md`.** If your Project still has the old file from the course-specific version of this skill, the first run offers to convert it. Everything is carried over: settings, doc ids, procedures, scripts, style rules, examples, log. The Lecture status table is built from your log. The old file is kept, with its title changed to "SUPERSEDED".

### Customizing the style

You never need to edit the skill itself. Open your progress file and edit the **`## Style rules`** section, or just tell Claude in a chat, e.g. *"from now on, shorter explanations and no emoji"*. It saves that to the progress file. The progress file always wins over the skill's defaults ([`references/style.md`](plugins/lecture-to-notes/skills/lecture-to-notes/references/style.md)).

---

## For maintainers

### Repo layout

```
.claude-plugin/marketplace.json        ← the catalog: lists every plugin
plugins/<plugin>/.claude-plugin/plugin.json
plugins/<plugin>/skills/<skill>/SKILL.md (+ references/, templates/)
dist/<skill>.zip                       ← claude.ai upload files (built, committed)
scripts/build-zip.ps1                  ← rebuilds dist/
```

### Updating a plugin

1. Edit the skill files.
2. Bump `version` in `plugins/<plugin>/.claude-plugin/plugin.json` (e.g. `1.0.0` → `1.1.0`). Claude Code users only get the update when the version changes.
3. Rebuild the zips:
   ```powershell
   powershell -ExecutionPolicy Bypass -File scripts\build-zip.ps1
   ```
4. Validate: `claude plugin validate .`
5. Commit and push. Users update with `/plugin marketplace update kelc66-plugins`. On claude.ai, they upload the new zip again.

### Adding a new plugin

1. Create `plugins/<new-plugin>/.claude-plugin/plugin.json` and its `skills/`, `commands/`, `agents/`, etc.
2. Add an entry to `plugins` in `.claude-plugin/marketplace.json` with `"source": "./plugins/<new-plugin>"`, a `category` and `tags`. A plugin can also live in its own repo: use `"source": {"source": "github", "repo": "Kelc66/<repo>"}`.
3. Run the build script, validate, commit and push.

## License

[MIT](LICENSE)
