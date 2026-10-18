---
applyTo: "**/*.py"
---

# Python review rules
- Stdlib only; no new third-party imports without a contract update.
- Public functions need type hints and a one-line docstring.
- New behavior needs a test; bug fixes need a regression test.
