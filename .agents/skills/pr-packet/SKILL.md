---
name: pr-packet
description: Assembles the merge-evidence packet by running .agents/skills/review/scripts/collect-evidence.sh — proof output, diff stat, contract SHA-256, secret scan, run ledger. Use to produce the packet a reviewer judges. Never invents claims; every line comes from the script.
license: MIT
compatibility: Requires git, bash, sha256sum.
metadata:
  version: "2.0.0"
allowed-tools: Read Bash
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
