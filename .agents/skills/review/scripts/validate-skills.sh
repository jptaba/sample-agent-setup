#!/usr/bin/env bash
# validate-skills: check every skill against the Agent Skills spec
# (https://agentskills.io/specification) plus this repo's own rules.
# Pure bash, no dependencies. Exit 0 = all pass, 1 = spec violation.
set -uo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
SKILLS_DIR="$REPO_ROOT/.agents/skills"
errors=0
warn()  { echo "validate-skills: WARN: $1" >&2; }
fail()  { echo "validate-skills: FAIL: $1" >&2; errors=$((errors + 1)); }

# Frontmatter value for a key (first occurrence, single-line values).
fm() { # $1=file $2=key
  sed -n "/^---$/,/^---$/p" "$1" | grep -m1 -oP "^$2:\s*\K.*" | sed 's/^["'"'"']//;s/["'"'"']$//' || true
}

for dir in "$SKILLS_DIR"/*/; do
  [ -d "$dir" ] || continue
  skill="$(basename "$dir")"
  f="$dir/SKILL.md"
  [ -f "$f" ] || { fail "$skill: missing SKILL.md"; continue; }

  name="$(fm "$f" name)"
  desc="$(fm "$f" description)"
  [ -n "$name" ] || { fail "$skill: frontmatter missing 'name'"; continue; }
  [ -n "$desc" ] || { fail "$skill: frontmatter missing 'description'"; continue; }
  [ "$name" = "$skill" ] || fail "$skill: name '$name' does not match directory"
  [[ "$name" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]] || fail "$skill: name '$name' violates [a-z0-9-], no leading/trailing/double hyphens"
  [ "${#name}" -le 64 ] || fail "$skill: name exceeds 64 chars"
  [ "${#desc}" -le 1024 ] || fail "$skill: description exceeds 1024 chars"

  compat="$(fm "$f" compatibility)"
  [ "${#compat}" -le 500 ] || fail "$skill: compatibility exceeds 500 chars"
  [ -n "$(fm "$f" license)" ] || warn "$skill: no 'license' field"
  sed -n "/^---$/,/^---$/p" "$f" | grep -q -m1 "^metadata:" \
    || warn "$skill: no 'metadata' map (consider a version)"

  body_lines="$(wc -l < "$f")"
  [ "$body_lines" -le 500 ] || warn "$skill: SKILL.md is $body_lines lines (spec suggests <= 500)"
done

# Platform discovery links, when present (created by scripts/setup.sh,
# gitignored), must resolve to real skills.
if [ -d "$REPO_ROOT/.claude/skills" ]; then
  for link in "$REPO_ROOT"/.claude/skills/*; do
    [ -L "$link" ] || continue
    target="$(readlink -f "$link" 2>/dev/null || true)"
    if [ -z "$target" ] || [ ! -f "$target/SKILL.md" ]; then
      fail ".claude/skills/$(basename "$link"): broken symlink"
    fi
  done
fi

if [ "$errors" -gt 0 ]; then
  echo "validate-skills: $errors violation(s)" >&2
  exit 1
fi
echo "validate-skills: OK"
