# PR packet — generated 2026-10-18T22:47:41Z
Contract: references/contract-py.md (sha256: aeadbad5b330b2e5d98bbf046847d70312a1b2d0fd2ab0ec9f411894ebf72d85)

## What was asked (copied from the contract)
## Inputs
- `text`: str — any unicode string, possibly empty.

## Outputs
- `slugify(text) -> str`: lowercase ASCII slug, words joined by single hyphens, no leading/trailing hyphens.
  - `slugify("Hello World") == "hello-world"`
  - `slugify("Café au lait") == "cafe-au-lait"`
  - `slugify("") == ""`
- `word_count(text) -> int`: number of whitespace-separated tokens.
  - `word_count("hello world") == 2`
  - `word_count("") == 0`, `word_count("   ") == 0`

## Proof command
```bash
python3 -m unittest discover -s tests
```
Must exit 0.

## Done when
- Both functions match the outputs above on ASCII, unicode, and empty input.
- The full test suite is green.

## Bad result looks like

## What changed (git diff --stat)
```
 .agents/skills/review/scripts/collect-evidence.sh | 30 +++++++++++++++-
 .githooks/pre-commit                              |  6 +++-
 pr-packet.md                                      | 44 +++++++++++------------
 references/contract-java.md                       |  5 ++-
 references/contract-py.md                         |  5 ++-
 references/contract.md                            |  5 ++-
 6 files changed, 67 insertions(+), 28 deletions(-)
```

## What was run, and the exit code
```
$ python3 -m unittest discover -s tests
......
----------------------------------------------------------------------
Ran 6 tests in 0.001s

OK
exit code: 0
```

## What the reviewer could not check
- (fill in: anything the script and diff cannot show — e.g. production data, manual UX)

## Verdict
- READY FOR REVIEW — proof command passed. Reviewer: judge the diff against the contract; cite file and line per finding.
