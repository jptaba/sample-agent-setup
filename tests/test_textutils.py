"""Tests for the sample contract in references/contract.md."""

import unittest

from src.textutils import slugify, word_count


class TestSlugify(unittest.TestCase):
    def test_basic(self):
        self.assertEqual(slugify("Hello World"), "hello-world")

    def test_punctuation_and_case(self):
        self.assertEqual(slugify("  Hello,   WORLD!  "), "hello-world")

    def test_unicode(self):
        self.assertEqual(slugify("Café au lait"), "cafe-au-lait")

    def test_empty(self):
        self.assertEqual(slugify(""), "")


class TestWordCount(unittest.TestCase):
    def test_basic(self):
        self.assertEqual(word_count("hello world"), 2)

    def test_empty_and_whitespace(self):
        self.assertEqual(word_count(""), 0)
        self.assertEqual(word_count("   "), 0)


if __name__ == "__main__":
    unittest.main()
