# MATLAB scripts

## Naming

The naming rules are in the progress file's *Numbering* section. The defaults:
- Template scripts: `L<lecture>_give_<inputs>_get_<outputs>.m`, e.g. `L5_give_A_B_get_ctrb_rank.m`
- Learning scripts: `L<n>_learn_<topic>.m`
- Exam scripts: `Q<n>_exam_<topic>.m`
- **≤ 63 characters** (the MATLAB limit). Letters, digits and `_` only, and the name starts with a letter. The name says what you give and what you get.

## Layout

```matlab
%% L5_give_A_B_get_ctrb_rank.m
% YOU GIVE  : A (n x n), B (n x m) of your state-space system
% YOU GET   : controllability matrix Co, its rank, and the verdict
% HOW TO USE: set example = 0 and type your A, B in "case 0";
%             or example = 1..2 to replay the lecture examples.
%             Run with F5, or section by section with Ctrl+Enter.
% NEEDS     : Control System Toolbox (ctrb)
% Lecture 5 – Controllability. Status: not run in MATLAB (logic checked in Python).

clear; clc;
example = 1;          % 0 = your own system, 1.. = worked examples below

%% INPUT
switch example
    case 0            % ---- your own system ----
        A = [];       % n x n
        B = [];       % n x m
    case 1            % Lecture 5, slide 12: two tanks
        A = [-1 0; 1 -2];
        B = [1; 0];   % expected: rank(Co) = 2 -> controllable
    case 2            % Lecture 5, slide 18: uncontrollable example
        A = [-1 0; 0 -2];
        B = [1; 0];   % expected: rank(Co) = 1 -> NOT controllable
end

%% COMPUTE
Co  = ctrb(A, B);                 % Co = [B, A*B, ..., A^(n-1)*B], size n x (n*m)
tol = 1e-9 * norm(Co);            % tolerance: tiny singular values count as zero
r   = rank(Co, tol);              % rank = number of independent columns
n   = size(A, 1);                 % size(A,1) = number of rows = number of states

%% RESULT
fprintf('rank(Co) = %d of %d\n', r, n);
if r == n
    disp('Controllable: every state can be steered.');
else
    disp('NOT controllable.');
end

%% LOCAL FUNCTIONS (must be at the end of the file, R2016b+)
```

## Rules

- **Generic and simple.** Only the `case 0` block needs editing for a new problem. Lecture examples are separate cases, each with its **expected result in a comment**.
- **Header:** `YOU GIVE / YOU GET / HOW TO USE / NEEDS`, and the lecture + status line. The first line is `%% <filename>.m`.
- **Comment every command:** what it does, its arguments and its outputs (sizes!). Point out 1-based indexing and `end` where they matter.
- **Numeric checks use tolerances:** `rank(M, tol)`, `abs(a - b) < tol`, never `==` on floats.
- Helpers go in local functions at the end of the file.
- Use separate scripts when the methods differ (e.g. LTI eigenvalue test vs LTV transition matrix).
- Name the toolboxes used. Prefer base MATLAB when it is just as simple.

## Verify

- **MATLAB available** (Claude Code on the user's PC; check `where matlab` / `command -v matlab`): run `matlab -batch "run('<file>.m')"` for each example and compare with the expected comments. Status: "verified in MATLAB <version>".
- **No MATLAB** (claude.ai sandbox, or not installed): mirror the core logic in Python (numpy/scipy, run with `python3 -I`), check every expected number and fix what fails. Status: "**not run in MATLAB** – logic checked in Python". Say this in the docs and in the reply.

## Deliver

- **claude.ai:** write to `/mnt/user-data/outputs/`, then:
  1. `get_device_info`;
  2. if the script folder isn't connected, `device_request_folder_access` for the *Script folder on PC*;
  3. `device_commit_files` with `force: true`;
  4. `SendUserFile` (display `attach`) so the user also has the file in chat.
- **Claude Code:** write straight into the *Script folder on PC*, or `scripts/` if none is set.
- **"chat only" or no bridge:** attach or paste the file, and tell the user where to save it.
