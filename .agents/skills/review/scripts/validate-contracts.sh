#!/usr/bin/env bash
# validate-contracts: every contract must have the sections the workflow needs.
# Pure bash, no dependencies. Exit 0 = all pass, 1 = violation.
set -uo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
REF_DIR="$REPO_ROOT/references"
errors=0
fail() { echo "validate-contracts: FAIL: $1" >&2; errors=$((errors + 1)); }

# Required sections (prefix match — "## Bad result looks like" counts).
required=("## Inputs" "## Outputs" "## Proof command" "## Bad result")

for c in "$REF_DIR"/contract*.md; do
  [ -f "$c" ] || continue
  case "$(basename "$c")" in contract.template.md) continue;; esac
  name="$(basename "$c")"
  for section in "${required[@]}"; do
    grep -q -m1 "^$section" "$c" || fail "$name: missing section '$section'"
  done
  # Proof command section must contain a fenced code block.
  awk '/^## Proof command/{found=1} found && /^```/{ticks++} END{exit !(found && ticks>=2)}' "$c" \
    || fail "$name: '## Proof command' has no fenced command block"
done

if [ "$errors" -gt 0 ]; then
  echo "validate-contracts: $errors violation(s)" >&2
  exit 1
fi
echo "validate-contracts: OK"
