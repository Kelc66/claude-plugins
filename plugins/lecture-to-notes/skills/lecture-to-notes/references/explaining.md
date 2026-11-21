# Phase 2: explaining the lecture in chat

The user's *Style rules* in the progress file come first. The defaults are in `style.md`. This file covers how to structure the explanation.

## Shape of the explanation

1. **One opening sentence** on what you are about to do ("Let's go through Lecture 5: controllability, using the two-tank example all the way through.").
2. **Slide order**, as **one linear derivation**. Each step builds on the previous one, without jumping ahead or going back.
3. **One running example** for the whole lecture. Pick the lecture's main example (or the one the notes say is exam-relevant) and reuse it in every step. Note its key numbers. They go into *Running examples* in the progress file at wrap-up.
4. For every new concept: **why it's useful → a concrete physical analogy if it's abstract → the formula → the running example's numbers.**
5. **Every symbol, subscript and Greek letter** in plain words the first time it appears ("Φ(t, t₀), the state-transition matrix: it moves the state from time t₀ to time t").
6. **Weave in the user's notes.** The professor's remarks go where they belong in the story. Don't add a separate "what your notes add" list.
7. **Flag exam-relevant items** where they appear (⚠️ **Exam:** …).
8. **Fill in what the slides leave blank**, e.g. a derivation stopped halfway or a "show that…" left to the reader.
9. Every key conclusion goes on its own line: `> 🔑 **Conclusion:** …`.
10. Finish with **All conclusions of Lecture N** (a short list) and **Exam takeaways**.

## Matrices

In chat, use Unicode-bracket matrices in code blocks, with sizes:

```
A = ⎡ 0   1 ⎤     (2 × 2)
    ⎣ −2  −3 ⎦
```

Use compact inline `[0 1; −2 −3]` only when the user asks for a short answer.

## Decision flowcharts

Whenever the lecture contains a **decision procedure** (classify a system, choose a method, check conditions step by step), draw a "dummy-proof" flowchart.

- **claude.ai with the Visualizer:** load its `diagram` module first. Proven layout:
  - HTML, one column per case (e.g. LTI vs LTV);
  - question boxes top to bottom with yes/no branches;
  - verdicts as coloured pills with a legend: red = bad/unstable, amber = partial, green = good (use the `--bg-danger` / `--bg-warning` / `--bg-success` variables);
  - a short line linking related cases.
- **No Visualizer (e.g. Claude Code):** in chat, draw an indented text tree in a code block:
  ```
  Is the system LTI?
  ├─ yes → all eigenvalues Re(λ) < 0?
  │        ├─ yes → 🟢 asymptotically stable
  │        └─ no  → any Re(λ) > 0? → 🔴 unstable / else 🟡 check Jordan blocks
  └─ no (LTV) → use Φ(t, t₀) …
  ```
  In markdown notes files, use a ```mermaid flowchart.
- For "which combinations can happen" questions, use a **table with one concrete example per row**, not an arrow diagram.

## Follow-up questions

- Short and focused. A yes/no question gets its answer in the **first line**, then the reason.
- "I don't get it" → re-explain in plain words with an analogy, **not** with more formulas.
- Answering questions is still phase 2: don't write anything to the docs.
