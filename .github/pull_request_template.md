## What changed
<!-- One line: the contract item this implements. -->

## Evidence
- [ ] PR packet attached (`pr-packet.md`, or the per-contract packet) and says READY FOR REVIEW
- [ ] Contract SHA-256 in the packet matches `references/contract*.md`
- [ ] Reviewer verdict: <!-- APPROVE / REQUEST CHANGES, with link or paste -->

## Human gate
<!-- Restate the packet in your own words. Approving the agent's paragraph does not count. -->

## Checklist
- [ ] Proof command exits 0 (`bash .agents/skills/review/scripts/collect-evidence.sh`)
- [ ] Packet is fresh (`--verify` passes for the touched contract)
- [ ] Secret scan clean, skill validation passes
- [ ] No dependencies added beyond what the contract names
- [ ] Significant decisions recorded in `docs/adr/`
