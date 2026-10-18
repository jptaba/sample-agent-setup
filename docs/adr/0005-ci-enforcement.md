# ADR 0005 — CI enforces the agent workflow

- Status: accepted
- Date: 2026-10-18

## Context
Pre-commit hooks only protect developers who installed them. PRs from any client (including web edits and agent sessions without the hook) bypassed every guardrail.

## Decision
`.github/workflows/verify.yml` runs on every PR and every push to `main`: skill spec validation, contract validation, secret scan over all tracked files, all three proof commands, and `--verify` packet freshness per contract. Dependabot already covered `github-actions`, so the new workflow's actions stay updated.

## Consequences
- The workflow's checks are the same scripts the hooks and skills run locally — one implementation, three enforcement points.
- A red CI run blocks merge the same way a failed evidence script blocks review.
