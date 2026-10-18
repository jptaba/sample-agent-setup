# Governance

How this project stays safe without slowing down. Every control here is local, fast, and versioned — no services, no dashboards, no waiting.

## Roles
- **Owner:** @YOUR-GITHUB-USERNAME (replace in `.github/CODEOWNERS`). One named owner, not a committee.
- **Coding agent:** implements under contract. Never approves its own diff.
- **Reviewer:** judges the diff. No write tools by construction.
- **Human:** restates the packet in their own words before merge. Approving the agent's paragraph does not count.

## Change control
- `references/contract.md` is the spec of record. It names inputs, outputs, the proof command, and what a bad result looks like.
- The contract is the only file that changes when you switch projects. Everything else is generic.
- Evidence is bound to the exact contract version: `collect-evidence.sh` records the contract's SHA-256 in every packet and in the run ledger. A packet written against a different contract is stale — review fails.

## Audit trail (per change)
1. `references/contract.md` + its hash — what was asked, pinned.
2. `pr-packet.md` — what changed (`git diff --stat`), what ran + exit code, what couldn't be checked, verdict with file:line.
3. `.agents/runs/runs.jsonl` — append-only local ledger: timestamp, contract hash, proof command, exit code, commit.
4. Git history — the merge itself.

## Decisions
Significant choices (contract changes, new skills, new guardrails, new dependencies) are recorded as short Architecture Decision Records in `docs/adr/`. See `docs/adr/0001-record-architecture-decisions.md`.

## Incidents and rollback
- Revert the merge commit. The packet tells you exactly what changed and what was proven.
- Record what happened as an ADR so the guardrail gets added once, in code, instead of being remembered.

## Standards mapping
- **NIST AI RMF:** Govern → this file + named owner; Map → `contract.md` (context, inputs, failure modes); Measure → proof command + packet; Manage → incident/rollback + run ledger.
- **OWASP:** LLM06 Excessive Agency → least-privilege reviewer (no write tools), agents never hold credentials; LLM03/ASI04 Supply Chain → skills are reviewed like packages before install, dependencies need a contract update; LLM01 Prompt Injection → external content is data, never instructions (this is why the review skill requires every claim to cite a file, a line, or a command output).

## References
- NIST AI Risk Management Framework (AI RMF 1.0) — Govern, Map, Measure, Manage: https://docs.modulos.ai/frameworks/nist-ai-rmf
- OWASP Top 10 for LLM Applications (2025): https://lorikeetsecurity.com/blog/owasp-top-10-llm-2025-what-changed
- OWASP Top 10 for Agentic Applications: https://www.promptfoo.dev/docs/red-team/owasp-agentic-ai/
