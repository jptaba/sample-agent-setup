# ADR 0003 — Platform-native reviewer agents

- Status: accepted
- Date: 2026-10-18

## Context
The design calls for an isolated, read-only reviewer in its own context — the coding agent never approves its own diff. The generic procedure lives in the `review` skill, but each platform needs its own isolated execution vehicle, wired with least-privilege tools.

## Decision
- Claude Code: `.claude/agents/code-reviewer.md` keeps `tools: Read, Grep, Glob, Bash` + `disallowedTools: Write, Edit`, and now preloads the procedure with `skills: review` (subagents don't inherit skills from the parent session).
- GitHub Copilot: `.github/agents/reviewer.agent.md` with `tools: ["read", "search"]` — the same review procedure, the same hard rules, no write access by construction.
- Both agents' bodies stay thin: identity + procedure pointer + hard rules. The skill holds the expertise (no monolithic definitions).

## Consequences
- Review isolation is enforced by tool allowlists on both platforms, not by convention alone.
- Skill and agent stay in sync by reference; updating the skill updates both reviewers.
