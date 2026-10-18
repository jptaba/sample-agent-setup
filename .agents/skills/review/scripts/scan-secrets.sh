#!/usr/bin/env bash
# scan-secrets.sh — dependency-free secret-pattern scan. Exit 1 on any hit.
# Usage: scan-secrets.sh --staged | <paths...>
set -uo pipefail

if [ "${1:-}" = "--staged" ]; then
  mapfile -t FILES < <(git diff --cached --name-only --diff-filter=ACM)
else
  FILES=("$@")
fi

# Specific token/key patterns (docs excluded — prose trips these).
PATTERN='AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{36}|github_pat_[A-Za-z0-9_]{22,}|gho_[A-Za-z0-9]{36}|xox[baprs]-[A-Za-z0-9-]{10,}|AIza[0-9A-Za-z_-]{35}|sk-(live|test)-[A-Za-z0-9]{16,}|BEGIN (RSA |EC |OPENSSH |DSA )?PRIVATE KEY'
# Long quoted token-ish strings (24+ chars of base64/hex-like text in quotes)
LONG="[\"'][A-Za-z0-9_./+=|-]{24}[\"']"

fail=0
for f in "${FILES[@]}"; do
  [ -f "$f" ] || continue
  case "$f" in *.md|*.toml) continue;; esac
  if grep -qEn "$PATTERN" "$f" 2>/dev/null; then
    echo "secret pattern hit: $f"
    grep -nE "$PATTERN" "$f" | head -5
    fail=1
  elif grep -qE "$LONG" "$f" 2>/dev/null; then
    echo "long quoted token-like string: $f"
    grep -nE "$LONG" "$f" | head -5
    fail=1
  fi
done

if [ "$fail" -eq 1 ]; then
  echo "scan-secrets: FAIL"
  exit 1
fi
echo "scan-secrets: clean"
