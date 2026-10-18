# AGENTS.md

Sample project for the three-layer agent setup. Rules load every session, every tool — so this file stays short: build, test, never-do. Procedures live in skills.

## Build and test
- Tests (Python demo): `python3 -m unittest discover -s tests` (stdlib only — nothing to install)
- Tests (TypeScript demo): `node --test tests-ts/` (Node 22+ runs .ts directly — nothing to install)
- Evidence: `bash .agents/skills/review/scripts/collect-evidence.sh` (exit 0 required before review; override with `CONTRACT=`, `PROOF_CMD=`, `PACKET=` for the TS demo — see README)

## Code rules
- Python 3.10+, stdlib only. Type hints and a one-line docstring on public functions.

## Testing rules
- New behavior ships with tests. Bug fixes ship with a regression test.
- Never declare work done on a red suite.

## Git rules
- Small, focused commits. Never commit secrets, credentials, or `.env` files.

## Task procedures (skills)
- Match the task to a skill in `.agents/skills/<name>/SKILL.md` and follow it — do not improvise a different workflow.
- `implement`: change only what `references/contract.md` names.
- `review`: judge the diff, do not edit. Three checks: diff matches contract, script exited 0, every claim cites file/line/output.
- `pr-packet`: assemble from the evidence script's output. Do not invent claims.

## Review policy
- Every behavior change gets an isolated review before merge: the `code-reviewer` subagent (`.claude/agents/code-reviewer.md`, no write tools) or Copilot code review.
- The reviewer reports findings with file and line. It never edits code.
- The coding agent never approves its own diff.
- A person restates the packet in their own words before merge. One named owner, not a committee.

## Governance and security
- `GOVERNANCE.md` (roles, change control, audit trail, incidents) and `SECURITY.md` (secrets, dependencies, skill trust) are policy. Follow them.
- Guardrails are listed in `.agents/policy/guardrails.md` and enforced by `.githooks/pre-commit` — install with `git config core.hooksPath .githooks`.
- Significant decisions go in `docs/adr/`.

## What agents must never do
- Push, merge, or approve their own diff.
- Expand the task beyond what the contract names.
- Weaken or delete tests to make the suite green.
- Add dependencies the contract doesn't name.
