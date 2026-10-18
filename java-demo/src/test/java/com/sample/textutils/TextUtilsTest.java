package com.sample.textutils;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

/** Tests for references/contract-java.md. Run: mvn -f java-demo/pom.xml test */
class TextUtilsTest {

    @Test
    void slugifyBasic() {
        assertEquals("hello-world", TextUtils.slugify("Hello World"));
    }

    @Test
    void slugifyPunctuationAndCase() {
        assertEquals("hello-world", TextUtils.slugify("  Hello,   WORLD!  "));
    }

    @Test
    void slugifyUnicode() {
        assertEquals("cafe-au-lait", TextUtils.slugify("Café au lait"));
    }

    @Test
    void slugifyEmpty() {
        assertEquals("", TextUtils.slugify(""));
    }

    @Test
    void wordCountBasic() {
        assertEquals(2, TextUtils.wordCount("hello world"));
    }

    @Test
    void wordCountEmptyAndWhitespace() {
        assertEquals(0, TextUtils.wordCount(""));
        assertEquals(0, TextUtils.wordCount("   "));
    }
}
