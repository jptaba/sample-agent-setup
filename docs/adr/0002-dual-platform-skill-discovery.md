# ADR 0002 — Dual-platform skill discovery

- Status: accepted
- Date: 2026-10-18

## Context
Claude Code discovers project skills in `.claude/skills/`; GitHub Copilot reads `.github/skills/`, `.claude/skills/`, or `.agents/skills/`. Keeping one canonical copy per skill avoids drift, but a single location leaves one platform blind. Committed symlinks would be the elegant answer, but the GitHub snapshot push tooling rejects symlinks outright (validation fails the whole snapshot).

## Decision
Skills live canonically in `.agents/skills/` (agent-agnostic home). `scripts/setup.sh` (idempotent) creates local symlinks: `.claude/skills/*` for Claude Code project discovery, plus root `skills/` and `agents/` so `claude --plugin-dir .` works. The generated links are gitignored — never committed. No `.github/skills/` copy: Copilot already reads `.agents/skills/`.

## Consequences
- Both platforms discover the same skill content with no duplication.
- Fresh clones run one command (`bash scripts/setup.sh`); `validate-skills.sh` fails the commit if existing links are broken.
