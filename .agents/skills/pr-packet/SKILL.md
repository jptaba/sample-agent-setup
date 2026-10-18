---
name: pr-packet
description: Assemble the PR packet from the evidence script's output. Use to produce merge evidence. Never invent claims.
---

# PR packet

1. Run `bash .agents/skills/review/scripts/collect-evidence.sh`. It writes `pr-packet.md`.
2. The packet's five sections come from the script's output only:
   - What was asked — copied from the contract
   - What changed — from `git diff --stat`
   - What was run, and the exit code
   - What the reviewer could not check
   - Verdict: approve or request changes, with file and line
3. Do not invent claims. Do not restate from memory. If the script failed, the packet says NOT READY and you stop.

A person restates the packet in their own words before merge. Approving the agent's paragraph does not count.
