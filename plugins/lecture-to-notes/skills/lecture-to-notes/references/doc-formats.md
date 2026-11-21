# Notes doc formats

Up to four doc types. The progress file lists which ones this course uses. Courses without programming (script language `none`) have no Command Reference, no Prepared Scripts and no "In <language>" part in procedures. **Before writing, read the outline of each doc and the previous lecture's section in full, and copy its exact format.** The user may have tweaked it, and their version wins over this file.

## Theory by Lecture

```
## Lecture N – <title>
The main idea: <one paragraph; the key sentence in **bold**>

### 1. <concept>
**Why it's useful:** <one or two sentences>
<explanation, plain words, the running example>
<formulas in display math>
> **Conclusion:** <one line>

### 2. <concept>
...

### All conclusions of Lecture N
- ...

### Exam takeaways
- ...
See procedures <n>–<m> in Theory by Procedure.
```

## Theory by Procedure

```
## <n>. <title> (Lecture N)
**Goal:** <what you end up with>
**Why:** <when and why you need this>

### By hand
1. <step>
   1. <sub-step>
2. ...

**Example (<running example name>):** <worked numbers>

**Things to know:**
- <traps, conditions, edge cases>

### In <language>          (only if a script language is set)
<code block: matlab or python>
- `command(args)`: what it does, what each output is
- ...
Script: `<file name>`
```

The decision flowchart for a procedure goes under that procedure, after *By hand*.

## Command Reference

The doc is named after the language ("MATLAB Reference", "Python Reference").

```
## <topic> (Lecture N)
<one line: what these commands are for>

| Command | What it does | Example | Watch out |
| --- | --- | --- | --- |
```

## Prepared Scripts

```
## Lecture N scripts
Saved in `<Script folder on PC>`. <one line on why the scripts are split this way>

### <file name>
**Use when:** <situation>
**Edit:** <what to change for your own problem> · Toolboxes/packages: <list or none>

| Section | What it does |
| --- | --- |

Expected: <what the worked example prints>

Status: <verified in MATLAB/Python | not run in MATLAB – logic checked in Python>
```

## Rules for all docs

- **Never put `|` inside a table cell.** Write `abs(x)`, ‖x‖ or "norm of x" instead.
- Matrices in display math as `bmatrix`, with the size in the text: "A (2 × 2)".
- Conclusions on their own line: `> **Conclusion:** …`. No emoji in docs.
- Only write the lecture of this chat.

## Claude Docs (claude.ai)

- Load the docs skill and call `guide` with `topic.index` and `topic.editing` before the first docs call.
- Refs are the **body node ids** from the progress file's Documents table, with `container` = the doc id.
- Insert at the end of the tab (`{"kind":"root"}`, side `end`) or at the right spot when the order matters.
- Plant one `pending` block per planned section first. Then replace each pending block with its content, **one section per call**.
- Formulas go in ```latex blocks (bare TeX).
- Replacing a whole existing block needs `ifHash` from the latest read plus `ifRev`.
- Diagrams: call `guide` with `topic.diagram` first (widget + embed).
- Links for the final reply come from the docs tool acks or the progress file.

## Markdown files (Claude Code / no Docs tools)

- Files: `notes/theory-by-lecture.md`, `notes/theory-by-procedure.md`, `notes/command-reference.md`, `notes/prepared-scripts.md`.
- Append at the end, or insert at the right spot when the order matters. Never rewrite other lectures' sections.
- Formulas as `$$ … $$` display math, so they render in VS Code, GitHub and Obsidian. Flowcharts as ```mermaid blocks.
