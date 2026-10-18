# ADR 0001 — Record architecture decisions

- Status: accepted
- Date: 2026-10-18

## Context
Agent-driven changes move fast and leave little rationale behind. The PR packet captures *what* was proven, not *why* a direction was chosen.

## Decision
Significant decisions (contract changes, new skills, new guardrails, new dependencies) are recorded as short ADRs in `docs/adr/`, numbered sequentially: `NNNN-short-title.md`.

## Format
Status / Date / Context / Decision / Consequences. Five headings, one page max.

## Consequences
- Rationale survives beyond the chat session that produced it.
- Reviewers can check a diff against the decision that authorized it.
