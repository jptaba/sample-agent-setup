package com.sample.textutils;

import java.text.Normalizer;

/** Tiny text utilities (Java demo). Mirrors the Python and TypeScript contracts. */
public final class TextUtils {

    private TextUtils() {}

    /**
     * Returns a URL-safe slug: lowercase, words joined by single hyphens.
     */
    public static String slugify(String text) {
        String ascii = Normalizer.normalize(text, Normalizer.Form.NFKD)
                .replaceAll("[^\\x00-\\x7F]", "");
        return ascii.toLowerCase()
                .replaceAll("[^a-z0-9]+", "-")
                .replaceAll("^-+|-+$", "");
    }

    /**
     * Returns the number of whitespace-separated tokens in text.
     */
    public static int wordCount(String text) {
        String trimmed = text.trim();
        return trimmed.isEmpty() ? 0 : trimmed.split("\\s+").length;
    }
}
