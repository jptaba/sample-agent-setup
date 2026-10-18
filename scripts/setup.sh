#!/usr/bin/env bash
# setup.sh — create local platform-discovery links for the canonical skills.
# Symlinks are generated, not committed: the GitHub snapshot push tooling
# rejects symlinks, so this script recreates them on every fresh clone.
# Idempotent — safe to re-run.
set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

link() { # $1 = target (relative to the link's directory), $2 = link path
  mkdir -p "$(dirname "$2")"
  ln -sfn "$1" "$2"
  echo "linked $2 -> $1"
}

# Claude Code project discovery.
for s in implement review pr-packet; do
  link "../../.agents/skills/$s" "$REPO_ROOT/.claude/skills/$s"
done

# Claude Code plugin discovery (for `claude --plugin-dir .`).
for s in implement review pr-packet; do
  link "../.agents/skills/$s" "$REPO_ROOT/skills/$s"
done
link "../.claude/agents/code-reviewer.md" "$REPO_ROOT/agents/code-reviewer.md"

echo "setup: OK"
