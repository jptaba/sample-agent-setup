# PR packet — generated 2026-10-18T12:47:09Z
Contract: references/contract.md (sha256: abb1d0392f2f833bfd10ec965da0e708cd4511b036530ec91c8bca3601e1c1dd)

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
`python3 -m unittest discover -s tests` — must exit 0.

## Done when
- Both functions match the outputs above on ASCII, unicode, and empty input.
- The full test suite is green.

## Bad result looks like

## What changed (git diff --stat)
```
 .agents/skills/review/SKILL.md                    |  2 +-
 .agents/skills/review/scripts/collect-evidence.sh |  2 +-
 .gitignore                                        |  1 +
 AGENTS.md                                         |  5 +++--
 README.md                                         | 17 +++++++++++++++++
 5 files changed, 23 insertions(+), 4 deletions(-)
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
