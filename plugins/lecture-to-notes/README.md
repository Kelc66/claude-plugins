# lecture-to-notes

A Claude skill for university courses. Give it a lecture (slides plus your own notes) and it:

1. explains the lecture in chat like a tutor: why before how, one running example, every symbol in plain words, decision flowcharts;
2. after you say "write it up", proposes a plan and waits for your OK;
3. writes exam notes: Theory by Lecture and Theory by Procedure;
4. for programming courses only: also a Command Reference, Prepared Scripts, and MATLAB or Python scripts with your lecture's examples built in. Courses without programming (history, law, biology, …) skip all of that.
5. updates one progress file per course, so the next chat knows what's done and how you like things explained.

In claude.ai the progress file is `claude/course-progress.md` in the course's Project. In Claude Code it is `notes/course-progress.md` in the course folder. The first run asks a few setup questions.

Install and usage instructions are in the [repository README](../../README.md).
