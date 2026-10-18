# Guardrails

Each guardrail: what it stops, where it's enforced, what it costs. All of them run locally — nothing here phones home or slows the loop.

| Guardrail | Effect | Enforced by | Cost |
|---|---|---|---|
| Commit directly to `main`/`master` | Block | `.githooks/pre-commit` | <100 ms |
| Secret patterns in staged files | Block | `scan-secrets.sh` via pre-commit | <500 ms |
| Files larger than 1 MB | Block | `.githooks/pre-commit` | <100 ms |
| Proof command fails | Block review | `collect-evidence.sh` exit code | test time |
| Packet written against a stale contract | Fail review | contract SHA-256 check in `review` skill | instant |
| Unverifiable claim in packet | Fail review | "cite file/line/output" rule | instant |
| Reviewer edits code | Impossible by construction | `disallowedTools: Write, Edit` | zero |
| Coding agent approves own diff | Forbidden by policy | human gate in `AGENTS.md` | zero |
| New dependency | Block | review checklist + contract update required | instant |
| Unreviewed third-party skill | Warn | `SECURITY.md` — review skills like packages | one-time |

## Install the hooks

`git config core.hooksPath .githooks` — local git config, not pushed. Re-run after every clone.

## Speed budget

Pre-commit: well under a second. Evidence script: test-suite time plus milliseconds. No services, no queues, no dashboards.
