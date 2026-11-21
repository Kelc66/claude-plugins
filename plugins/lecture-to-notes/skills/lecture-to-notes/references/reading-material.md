# Reading slides and notes

## What usually arrives

- **Slides:** a PDF, uploaded or in the Project files. Sometimes PPTX.
- **The user's notes:** often a OneNote PDF export. That means slide images with short typed or handwritten comments beside them, which are often the professor's spoken remarks. Can also be scanned handwriting, photos or typed text.

## Slides (PDF)

- `pdftotext -layout slides.pdf -` usually gets only titles and bullet text. Formulas, plots and worked examples live in images, so you must **look at the pages**.
- Rasterize at low resolution and combine 4 pages per image to save views:
  ```bash
  pdftoppm -r 60 -png slides.pdf p
  montage p-*.png -tile 2x2 -geometry +4+4 sheet.png   # ImageMagick; makes sheet-0.png, sheet-1.png, ...
  ```
- Render key pages (worked examples, theorems, the derivation steps) on their own at higher resolution: `pdftoppm -r 110 -f 12 -l 12 -png slides.pdf key`.
- **PPTX:** convert with `soffice --headless --convert-to pdf`, or read the text with `python-pptx`. Still look at the slides that have figures.

## The user's notes

- `pdftotext -layout notes.pdf -` extracts the typed comments, usually the most valuable part.
- Also view the pages as montages: handwriting, arrows and circles don't come out as text.
- Collect:
  - the professor's explanations and analogies;
  - corrections to the slides ("this is wrong", "sign error");
  - exam hints ("same example at the exam", "you must know this");
  - the user's own confusion marks ("??"). Explain those parts extra carefully.

## Which lecture is it?

Take the lecture number from the **slide title page**, not from the file name. File names can lag behind (e.g. "Lecture 6 - 2025.pdf" may be Lecture 5 this year). Check it against the progress file's Lecture status. If it is still unclear, ask.

## When the tools aren't there

- **claude.ai:** the code sandbox normally has `pdftotext`, `pdftoppm` (poppler) and ImageMagick `montage`.
- **Claude Code on Windows/macOS:** check first (`where pdftoppm` / `command -v pdftoppm`). Fallbacks, in order:
  1. the file-reading tool, if it can read PDFs directly (Claude Code's Read takes a `pages` range, max 20 pages per call);
  2. Python with PyMuPDF (`fitz`) to render pages to PNG, and Pillow to tile them;
  3. `pypdf` for text only.
- Don't install software on the user's PC without asking.
