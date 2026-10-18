# sample-agent-setup

A working sample of the three-layer agent setup:

1. **Project rules** — `AGENTS.md` (always loaded: build, test, never-do)
2. **Task procedures** — `.agents/skills/` (`implement`, `review`, `pr-packet`; each a folder with `SKILL.md`; the agent sees only name + description until the task matches)
3. **Isolated reviewer** — `.claude/agents/code-reviewer.md` (Read, Grep, Glob, read-only Bash; Write/Edit denied) plus Copilot review rules in `.github/`

The pointed sample project is **TypeScript** (`references/contract.md`): the demo feature is two tiny text functions (`src-ts/textutils.ts`) with tests (`tests-ts/`). Python and Java demos ride along to show the contract is per feature.

## Try the loop

```bash
node --test "tests-ts/**/*.test.ts"
bash .agents/skills/review/scripts/collect-evidence.sh   # writes pr-packet.md, exits 0 only if tests pass
```

## Three demos, three contracts

TypeScript is the primary demo and the default contract. The other two override it:

```bash
# TypeScript demo (default contract)
bash .agents/skills/review/scripts/collect-evidence.sh

# Python demo (override the contract, proof command, and packet)
CONTRACT=references/contract-py.md PROOF_CMD="python3 -m unittest discover -s tests" PACKET=pr-packet-py.md \
  bash .agents/skills/review/scripts/collect-evidence.sh

# Java demo
CONTRACT=references/contract-java.md PROOF_CMD="mvn -q -f java-demo/pom.xml test" PACKET=pr-packet-java.md \
  bash .agents/skills/review/scripts/collect-evidence.sh
```

Each run stamps its contract's SHA-256 into its packet and its own line in
`.agents/runs/runs.jsonl`, so the two evidence trails never mix.

## Use it on your platform

Skills live canonically in `.agents/skills/` — one copy, no drift.

- **Claude Code**: run `bash scripts/setup.sh` to link the skills into `.claude/skills/` for project discovery. The isolated reviewer is `.claude/agents/code-reviewer.md` (read-only tools, preloads the `review` skill). After setup, the repo also works as a plugin: `claude --plugin-dir .` (manifest in `.claude-plugin/plugin.json`).
- **GitHub Copilot**: skills are read from `.agents/skills/` automatically — no setup needed. The isolated reviewer is the `.github/agents/reviewer.agent.md` custom agent (read-only `read` + `search` tools).
- The discovery links are generated, not committed (the GitHub snapshot push rejects symlinks) — `scripts/setup.sh` recreates them and they're gitignored. Never edit through a link target; edit the canonical skill.

## Make it yours

1. Replace `references/contract.md` with your project's contract: inputs, outputs, the command that proves them, what a bad result looks like.
2. Point the proof command at your suite: `PROOF_CMD="pytest -q" bash .agents/skills/review/scripts/collect-evidence.sh`
3. Keep the skills generic — specializing means a new contract, a new evidence script, maybe one extra skill. Never a new coding agent.

## Governance, guardrails, observability, security
- `GOVERNANCE.md` — owner, human gate, change control (contract SHA-256 binds every packet), audit trail, ADRs, incident/rollback. Maps to NIST AI RMF (Govern/Map/Measure/Manage) and the OWASP LLM + Agentic top 10s.
- `SECURITY.md` — no secrets in repo, dependency policy, skills as a trust boundary, least privilege, prompt-injection stance.
- `.agents/policy/guardrails.md` — every guardrail, where it's enforced, what it costs. All local, all sub-second.
- Observability: every evidence run appends to `.agents/runs/runs.jsonl` (timestamp, contract hash, proof command, exit code, commit). The packet carries the contract hash, so any claim traces back to the exact contract version.
- Install the git hooks: `git config core.hooksPath .githooks`
