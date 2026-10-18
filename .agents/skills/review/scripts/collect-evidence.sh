#!/usr/bin/env bash
# collect-evidence.sh — assembles the PR packet from real outputs, never from memory.
#
# Usage:
#   bash .agents/skills/review/scripts/collect-evidence.sh [--verify]
#
# Env overrides:
#   PROOF_CMD  command that proves the contract (default: the TypeScript suite)
#   CONTRACT   contract file (default: references/contract.md)
#   PACKET     where to write the packet (default: pr-packet.md)
#
# Exit code: 0 only if the proof command passed.
#
# --verify: don't regenerate. Check the committed packet is fresh: its contract
# SHA-256 must match the contract file, and its verdict must agree with a fresh
# proof run. Exit 0 = fresh, 1 = stale.

set -uo pipefail

PROOF_CMD="${PROOF_CMD:-node --test \"tests-ts/**/*.test.ts\"}"
PACKET="${PACKET:-pr-packet.md}"
CONTRACT="${CONTRACT:-references/contract.md}"
CONTRACT_SHA="$(sha256sum "$CONTRACT" 2>/dev/null | cut -d' ' -f1)"
[ -z "$CONTRACT_SHA" ] && CONTRACT_SHA="(contract not found)"

if [ "${1:-}" = "--verify" ]; then
  [ -f "$PACKET" ] || { echo "verify: no packet at $PACKET — run without --verify first"; exit 1; }
  PKT_SHA="$(grep -m1 -oP '^Contract: \S+ \(sha256: \K[0-9a-f]+' "$PACKET" || true)"
  [ "$PKT_SHA" = "$CONTRACT_SHA" ] || {
    echo "verify: STALE — packet's contract sha ($PKT_SHA) != $CONTRACT ($CONTRACT_SHA). Regenerate the packet."
    exit 1
  }
  bash -c "$PROOF_CMD" >/dev/null 2>&1
  PROOF_EXIT=$?
  if [ "$PROOF_EXIT" -eq 0 ]; then
    grep -q "READY FOR REVIEW" "$PACKET" || {
      echo "verify: STALE — proof passes but packet is not READY FOR REVIEW. Regenerate."
      exit 1
    }
  else
    grep -q "NOT READY" "$PACKET" || {
      echo "verify: STALE — proof fails (exit $PROOF_EXIT) but packet is not NOT READY. Regenerate."
      exit 1
    }
  fi
  echo "verify: OK — $PACKET is fresh for $CONTRACT"
  exit 0
fi

echo "--- proof command ---"
echo "\$ $PROOF_CMD"
PROOF_OUTPUT="$(bash -c "$PROOF_CMD" 2>&1)"
PROOF_EXIT=$?
printf '%s\n' "$PROOF_OUTPUT" | tail -25
echo "--- exit code: $PROOF_EXIT ---"

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  DIFF_STAT="$(git diff --stat; git diff --cached --stat)"
else
  DIFF_STAT="(not a git work tree)"
fi
[ -z "$DIFF_STAT" ] && DIFF_STAT="(no changes vs HEAD)"

if [ -f "$CONTRACT" ]; then
  ASKED="$(sed -n '/^## Inputs/,/^## Bad result/p' "$CONTRACT")"
else
  ASKED="(contract not found at $CONTRACT)"
fi

{
  echo "# PR packet — generated $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "Contract: $CONTRACT (sha256: $CONTRACT_SHA)"
  echo
  echo "## What was asked (copied from the contract)"
  echo "$ASKED"
  echo
  echo "## What changed (git diff --stat)"
  echo '```'
  echo "$DIFF_STAT"
  echo '```'
  echo
  echo "## What was run, and the exit code"
  echo '```'
  echo "\$ $PROOF_CMD"
  echo "$PROOF_OUTPUT" | tail -20
  echo "exit code: $PROOF_EXIT"
  echo '```'
  echo
  echo "## What the reviewer could not check"
  echo "- (fill in: anything the script and diff cannot show — e.g. production data, manual UX)"
  echo
  echo "## Verdict"
  if [ "$PROOF_EXIT" -eq 0 ]; then
    echo "- READY FOR REVIEW — proof command passed. Reviewer: judge the diff against the contract; cite file and line per finding."
  else
    echo "- NOT READY — proof command failed (exit $PROOF_EXIT). Do not review; fix first."
  fi
} > "$PACKET"

# Append-only run ledger: timestamp, contract hash, proof command, exit code, commit.
LEDGER=".agents/runs/runs.jsonl"
mkdir -p "$(dirname "$LEDGER")"
HEAD_SHA="$(git rev-parse HEAD 2>/dev/null || echo uncommitted)"
SAFE_CMD="$(printf '%s' "$PROOF_CMD" | sed 's/\\/\\\\/g; s/"/\\"/g')"
printf '{"ts":"%s","contract":"%s","contract_sha":"%s","proof_cmd":"%s","proof_exit":%d,"head":"%s","packet":"%s"}\n' \
  "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$CONTRACT" "$CONTRACT_SHA" "$SAFE_CMD" "$PROOF_EXIT" "$HEAD_SHA" "$PACKET" >> "$LEDGER"

echo "wrote $PACKET (logged to $LEDGER)"
exit "$PROOF_EXIT"
