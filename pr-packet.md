# PR packet — generated 2026-10-18T22:36:11Z
Contract: references/contract.md (sha256: 8b79cb6f7eb11b9bf1df51e2dd7d2878c0904563f5c51f7aea2c16eb1bdcd180)

## What was asked (copied from the contract)
## Inputs
- `text`: string — any unicode string, possibly empty.

## Outputs
- `slugify(text): string`: lowercase ASCII slug, words joined by single hyphens, no leading/trailing hyphens.
  - `slugify("Hello World") === "hello-world"`
  - `slugify("Café au lait") === "cafe-au-lait"`
  - `slugify("") === ""`
- `wordCount(text): number`: number of whitespace-separated tokens.
  - `wordCount("hello world") === 2`
  - `wordCount("") === 0`, `wordCount("   ") === 0`

## Proof command
`node --test "tests-ts/**/*.test.ts"` — must exit 0. (Node 22+ runs the TypeScript directly; no build step, no dependencies. The explicit glob is used because `node --test <dir>` doesn't discover `.ts` files on its own.)

## Done when
- Both functions match the outputs above on ASCII, unicode, and empty input.
- The full test suite is green.

## Bad result looks like

## What changed (git diff --stat)
```
 .agents/skills/implement/SKILL.md                 |  7 ++++++-
 .agents/skills/pr-packet/SKILL.md                 |  7 ++++++-
 .agents/skills/review/SKILL.md                    | 11 ++++++++---
 .agents/skills/review/scripts/collect-evidence.sh |  5 +++--
 .agents/skills/review/scripts/scan-secrets.sh     |  2 +-
 .claude/agents/code-reviewer.md                   |  1 +
 .githooks/pre-commit                              | 12 +++++++++---
 .github/copilot-instructions.md                   | 10 ++++++++--
 AGENTS.md                                         |  5 +++--
 README.md                                         |  8 ++++++++
 10 files changed, 53 insertions(+), 15 deletions(-)
```

## What was run, and the exit code
```
$ node --test "tests-ts/**/*.test.ts"
▶ slugify
  ✔ basic (13.904691ms)
  ✔ punctuation and case (0.327472ms)
  ✔ unicode (0.363807ms)
  ✔ empty (0.258088ms)
✔ slugify (17.009092ms)
▶ wordCount
  ✔ basic (0.501553ms)
  ✔ empty and whitespace (0.269455ms)
✔ wordCount (1.172771ms)
ℹ tests 6
ℹ suites 2
ℹ pass 6
ℹ fail 0
ℹ cancelled 0
ℹ skipped 0
ℹ todo 0
ℹ duration_ms 312.285425
exit code: 0
```

## What the reviewer could not check
- (fill in: anything the script and diff cannot show — e.g. production data, manual UX)

## Verdict
- READY FOR REVIEW — proof command passed. Reviewer: judge the diff against the contract; cite file and line per finding.
