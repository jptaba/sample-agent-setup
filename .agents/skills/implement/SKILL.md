---
name: implement
description: Implements or fixes exactly what references/contract.md names, runs the contract's proof command, and generates the evidence packet. Use when building or changing the contracted feature. Do NOT use for code review or for approving a diff — that is the review skill's job.
license: MIT
compatibility: Requires git, bash, and the proof toolchain named in references/contract.md.
metadata:
  version: "2.0.0"
allowed-tools: Read Write Edit Bash Grep Glob
---

# Implement

1. Read `references/contract.md` first. It is the whole task. If the task names a non-default contract (e.g. `references/contract-py.md`), read that file instead and pass `CONTRACT=`, `PROOF_CMD=`, `PACKET=` to the evidence script (see README).
2. Change only what the contract names. Anything else is a separate contract.
3. Write the code and the tests together. A bug fix gets a regression test.
4. Run the proof command from the contract. It must exit 0.
5. Run `bash .agents/skills/review/scripts/collect-evidence.sh` to generate `pr-packet.md`.
6. Stop. Hand the diff and the packet to review. Do not approve your own diff.

Never: push, merge, weaken tests to go green, or add dependencies the contract doesn't name.
