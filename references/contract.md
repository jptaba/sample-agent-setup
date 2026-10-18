# Contract — textutils (sample)

The only file that changes when you switch projects. Everything else in `.agents/skills/` is generic.

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
