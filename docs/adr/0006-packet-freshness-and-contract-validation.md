# ADR 0006 — Packet freshness and contract validation

- Status: accepted
- Date: 2026-10-18

## Context
Two silent failure modes: (1) a contract edited after its packet was generated — the packet's SHA no longer matches, but nothing flagged it; (2) a contract missing the sections the workflow depends on (`## Proof command`, `## Bad result`), which the evidence script parses.

## Decision
- `collect-evidence.sh --verify`: checks the committed packet's contract SHA against the contract file and re-runs the proof command, confirming the verdict still agrees. Stale packets fail loudly.
- `validate-contracts.sh`: every `references/contract*.md` (except the template) must contain `## Inputs`, `## Outputs`, `## Proof command` (with a fenced command block), and `## Bad result`. Wired into pre-commit and CI.

## Consequences
- "Regenerate the packet" becomes a mechanical step with a mechanical check, not reviewer diligence.
- Contract edits are caught at commit time, not at review time.
