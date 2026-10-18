"""Tiny text utilities. Sample feature for the agent-setup demo."""

import re
import unicodedata


def slugify(text: str) -> str:
    """Return a URL-safe slug: lowercase, words joined by single hyphens."""
    normalized = unicodedata.normalize("NFKD", text)
    ascii_only = normalized.encode("ascii", "ignore").decode("ascii")
    return re.sub(r"[^a-z0-9]+", "-", ascii_only.lower()).strip("-")


def word_count(text: str) -> int:
    """Return the number of whitespace-separated tokens in text."""
    return len(text.split())
