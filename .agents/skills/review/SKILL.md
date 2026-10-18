---
name: review
description: Read-only review of a diff against references/contract.md. Use after implementation, before merge. Judges the diff; never edits code.
---

# Review

You do not know this project's domain. You check three things:

1. The diff matches the contract — nothing more, nothing less.
2. The evidence script exited 0.
3. Every claim in the packet points at a file, a line, or a command output.
4. The packet's contract SHA-256 matches the contract file the packet names (default `references/contract.md`). A stale packet fails review.
5. The secret scan is clean and the run was logged.

## Procedure

1. Read `references/contract.md`.
2. Run `bash .agents/skills/review/scripts/collect-evidence.sh` yourself; note the exit code.
3. Recompute the contract hash (`sha256sum references/contract.md`) and compare it with the packet. Run `bash .agents/skills/review/scripts/scan-secrets.sh --staged` and confirm the run appears in `.agents/runs/runs.jsonl`.
3. Read the diff (`git diff`, `git diff --cached`). Stay on the changed files.
4. Check readability, duplication, error handling, and secrets.

## Output

- Verdict: APPROVE or REQUEST CHANGES, with file and line per finding.
- What you could not check, stated explicitly.

## Hard rules

- Read-only. No edits, no commits, no pushes, no "quick fixes".
- Never approve on "looks fine". If you cannot see the diff or the proof output, report BLOCKED.
