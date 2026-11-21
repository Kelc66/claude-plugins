# Python scripts

Same ideas as the MATLAB conventions (`scripts-matlab.md`), in Python form.

## Naming

- Template scripts: `L<lecture>_give_<inputs>_get_<outputs>.py`, e.g. `L5_give_A_B_get_ctrb_rank.py`
- Learning scripts: `L<n>_learn_<topic>.py`. Exam scripts: `Q<n>_exam_<topic>.py`.
- ≤ 63 characters. Letters, digits and `_` only, and the name starts with a letter, so the file can also be imported.

## Layout

```python
"""L5_give_A_B_get_ctrb_rank.py

YOU GIVE  : A (n x n), B (n x m) of your state-space system
YOU GET   : controllability matrix Co, its rank, and the verdict
HOW TO USE: set EXAMPLE = 0 and type your A, B in the "your own system" block,
            or EXAMPLE = 1..2 to replay the lecture examples. Run: python L5_give_A_B_get_ctrb_rank.py
NEEDS     : numpy (pip install numpy)
Lecture 5 – Controllability. Status: verified with Python 3.x.
"""
import numpy as np

EXAMPLE = 1  # 0 = your own system, 1.. = worked examples below


def get_system(example):
    """Return (A, B) for the chosen example."""
    if example == 0:                       # ---- your own system ----
        A = np.array([[0.0]])              # n x n
        B = np.array([[0.0]])              # n x m
    elif example == 1:                     # Lecture 5, slide 12: two tanks
        A = np.array([[-1, 0], [1, -2]], dtype=float)
        B = np.array([[1], [0]], dtype=float)   # expected: rank 2 -> controllable
    elif example == 2:                     # Lecture 5, slide 18
        A = np.array([[-1, 0], [0, -2]], dtype=float)
        B = np.array([[1], [0]], dtype=float)   # expected: rank 1 -> NOT controllable
    else:
        raise ValueError("unknown EXAMPLE")
    return A, B


def ctrb(A, B):
    """Controllability matrix [B, AB, ..., A^(n-1)B], size n x (n*m)."""
    n = A.shape[0]                         # shape[0] = number of rows = number of states
    blocks = [np.linalg.matrix_power(A, k) @ B for k in range(n)]   # @ = matrix product
    return np.hstack(blocks)               # put the blocks side by side


def main():
    A, B = get_system(EXAMPLE)
    Co = ctrb(A, B)
    tol = 1e-9 * np.linalg.norm(Co)        # tiny singular values count as zero
    r = np.linalg.matrix_rank(Co, tol=tol)
    n = A.shape[0]
    print(f"rank(Co) = {r} of {n}")
    print("Controllable." if r == n else "NOT controllable.")


if __name__ == "__main__":
    main()
```

## Rules

- **Generic and simple:** an `EXAMPLE` switch, with your own system in case 0 and the lecture examples as cases 1.., each with its **expected result in a comment**.
- Module docstring header: `YOU GIVE / YOU GET / HOW TO USE / NEEDS`, plus the lecture + status line.
- Use numpy / scipy (`scipy.linalg`, `scipy.signal`) / matplotlib. Use `python-control` (`import control`) only when it saves real work, and list it under NEEDS with its pip name.
- **Comment every call:** what it does, its arguments and its outputs (shapes!). Point out 0-based indexing where it differs from the slides' 1-based notation.
- **Tolerances** for numeric checks: `np.allclose`, `matrix_rank(M, tol=...)`. Never `==` on floats.
- Code at module level only under `if __name__ == "__main__":`, so the helpers can be imported.
- Plots: `plt.show()` at the end, with axis labels and units.

## Verify

Python is normally available in both claude.ai and Claude Code. **Run every example** (`python -I <file>.py`) and compare with the expected comments. If a package is missing and can't be installed, say "not run" honestly.

## Deliver

Same as MATLAB (`scripts-matlab.md` → Deliver).
