---
name: implement
description: Implement exactly what references/contract.md names — inputs, outputs, proof command. Use when building or fixing under contract.
---

# Implement

1. Read `references/contract.md` first. It is the whole task.
2. Change only what the contract names. Anything else is a separate contract.
3. Write the code and the tests together. A bug fix gets a regression test.
4. Run the proof command from the contract. It must exit 0.
5. Run `bash .agents/skills/review/scripts/collect-evidence.sh` to generate `pr-packet.md`.
6. Stop. Hand the diff and the packet to review. Do not approve your own diff.

Never: push, merge, weaken tests to go green, or add dependencies the contract doesn't name.
