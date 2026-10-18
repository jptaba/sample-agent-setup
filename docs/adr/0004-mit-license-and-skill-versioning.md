# ADR 0004 — MIT license and skill versioning

- Status: accepted
- Date: 2026-10-18

## Context
The repo is meant to be copied into future projects. Without a license, reuse terms are ambiguous; without versions, consumers can't tell whether their copy of a skill is current.

## Decision
- License the repo (including all skills) under MIT (`LICENSE` at root); each `SKILL.md` carries `license: MIT` in frontmatter per the Agent Skills spec.
- Each skill carries `metadata: { version: "2.0.0" }` — the spec's portable way to version (no top-level `version` field exists). Bump on behavior changes, not on typo fixes.

## Consequences
- Future projects can adopt the framework with clear reuse terms.
- `validate-skills.sh` warns when a skill lacks license or version metadata.
