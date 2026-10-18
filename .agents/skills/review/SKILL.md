---
name: review
description: Read-only code review against references/contract.md. Verifies the diff matches the contract, the evidence packet (proof exit 0, contract SHA-256, clean secret scan), and returns an APPROVE / REQUEST CHANGES verdict with file-and-line citations. Use after implementation, before merge. Never edits code and never approves its own diff.
license: MIT
compatibility: Requires git, bash, sha256sum.
metadata:
  version: "2.0.0"
allowed-tools: Read Grep Glob Bash
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
4. Read the diff (`git diff`, `git diff --cached`). Stay on the changed files.
5. Check readability, duplication, error handling, and secrets.

## Output

- Verdict: APPROVE or REQUEST CHANGES, with file and line per finding.
- What you could not check, stated explicitly.

## Hard rules

- Read-only. No edits, no commits, no pushes, no "quick fixes".
- Never approve on "looks fine". If you cannot see the diff or the proof output, report BLOCKED.
