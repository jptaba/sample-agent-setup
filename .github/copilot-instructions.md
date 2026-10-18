# Copilot instructions — sample-agent-setup

## Build and test
- Tests: `python3 -m unittest discover -s tests` (stdlib only, no install step).
- Evidence: `bash .agents/skills/review/scripts/collect-evidence.sh` — exit 0 is required before review.

## Code review expectations
- Judge the diff against `references/contract.md`. The contract is the spec.
- Flag: changes beyond what the contract names, weakened or deleted tests, new dependencies, secrets in code.
- Every finding must cite a file and line.
