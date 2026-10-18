# Copilot instructions — sample-agent-setup

## Skills and agents
- Task skills live in `.agents/skills/` (`implement`, `review`, `pr-packet`) — Copilot reads them automatically. They follow the Agent Skills spec (`SKILL.md` + frontmatter).
- The isolated reviewer is the `reviewer` custom agent (`.github/agents/reviewer.agent.md`, read-only tools). It follows the `review` skill: judge the diff against the contract, verify the evidence packet, never edit code.

## Build and test
- Tests (TypeScript demo, primary): `node --test "tests-ts/**/*.test.ts"` (Node 22+ runs .ts directly, no install step).
- Tests (Python demo): `python3 -m unittest discover -s tests` (stdlib only).
- Tests (Java demo): `mvn -q -f java-demo/pom.xml test` (needs JDK 21+ and Maven).
- Evidence: `bash .agents/skills/review/scripts/collect-evidence.sh` — exit 0 is required before review. Override with `CONTRACT=`, `PROOF_CMD=`, `PACKET=` for the Python/Java demos (see README).

## Code review expectations
- Judge the diff against `references/contract.md`. The contract is the spec.
- Flag: changes beyond what the contract names, weakened or deleted tests, new dependencies, secrets in code.
- Every finding must cite a file and line.
