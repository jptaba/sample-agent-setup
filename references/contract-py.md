# Contract — textutils (Python sample)

One of three per-feature contracts in this repo (`contract.md` is the primary
TypeScript one, `contract-java.md` the Java one). Point the evidence script at
this file to prove the Python demo:

```bash
CONTRACT=references/contract-py.md PROOF_CMD="python3 -m unittest discover -s tests" \
  PACKET=pr-packet-py.md \
  bash .agents/skills/review/scripts/collect-evidence.sh
```

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
- `slugify("Hello World")` returns anything other than `"hello-world"`.
- Empty input raises instead of returning `""` / `0`.
- Proof command exits non-zero.
- Behavior added that this contract does not name.
