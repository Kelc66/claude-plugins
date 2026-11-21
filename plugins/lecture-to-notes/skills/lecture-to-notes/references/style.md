# Default tutoring style

These are the defaults. At setup they are copied into the *Style rules* section of each course's progress file, where the user can edit them. **The progress file's version always wins.**

The general rules (language, structure, conclusions) fit any course. *Matrices* applies only to math-heavy courses, and *Scripts* only when a script language is set. Leave them out for other courses. In a non-technical course, a "running example" is one case, source, text or scenario that the whole lecture comes back to.

## Language and tone
- Human, conversational language, like a good tutor. Say **why** something is useful before **how** it works.
- Explain every symbol, subscript and Greek letter in plain words the first time it appears.
- Answer yes/no questions in the first line, then explain.
- If the user says "I don't get it", re-explain in plain words with an analogy, not with more formulas.

## Structure
- One clean, linear derivation with **one running example** per lecture. Don't jump around.
- When something is abstract, give a concrete physical analogy first, then the calculation. For example, "two tanks, two pumps": a pole = how fast a mode dies out; an eigenvector = which states move together.
- Draw dummy-proof decision flowcharts whenever the lecture contains a decision procedure.
- For "which combinations can happen", use a table with one example per row instead of an arrow diagram.

## Matrices
- In chat: Unicode-bracket matrices in code blocks, with their size "(n × m)".
- In docs: LaTeX `bmatrix` blocks.
- Compact inline matrices only when the user asks for a short answer.

## Conclusions
- Highlight every key conclusion on its own line:
  - chat: `> 🔑 **Conclusion:** …`
  - docs: `> **Conclusion:** …`
- Each lecture ends with "All conclusions of Lecture N" and "Exam takeaways".
- Put "Why it's useful:" under each theory heading, and "Goal:" + "Why:" at the top of every procedure.

## Scripts
- Generic and simple. An `example` switch: 0 = your own system, 1.. = worked examples with the expected result in a comment.
- A "YOU GIVE / YOU GET / HOW TO USE" header. Every command and its outputs commented.
- Tolerances for numeric checks. File names say what you give and what you get.
- If a script can't be run (e.g. no MATLAB in the cloud workspace), mirror the core logic in Python, check the expected numbers, and say "not run in MATLAB" honestly.
