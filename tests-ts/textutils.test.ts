/** Tests for references/contract-ts.md. Run: node --test tests-ts/ */

import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { slugify, wordCount } from "../src-ts/textutils.ts";

describe("slugify", () => {
  it("basic", () => assert.equal(slugify("Hello World"), "hello-world"));
  it("punctuation and case", () =>
    assert.equal(slugify("  Hello,   WORLD!  "), "hello-world"));
  it("unicode", () => assert.equal(slugify("Café au lait"), "cafe-au-lait"));
  it("empty", () => assert.equal(slugify(""), ""));
});

describe("wordCount", () => {
  it("basic", () => assert.equal(wordCount("hello world"), 2));
  it("empty and whitespace", () => {
    assert.equal(wordCount(""), 0);
    assert.equal(wordCount("   "), 0);
  });
});
