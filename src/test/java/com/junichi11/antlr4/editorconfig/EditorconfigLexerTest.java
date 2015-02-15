/*
 * The MIT License
 *
 * Copyright 2015 junichi11.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package com.junichi11.antlr4.editorconfig;

import editorconfig.EditorConfigLexer;
import java.util.HashMap;
import java.util.Map;
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Token;
import static org.antlr.v4.runtime.Token.EOF;
import org.hamcrest.core.Is;
import org.junit.Assert;
import org.junit.Test;

/**
 *
 * @author junichi11
 */
public class EditorconfigLexerTest {

    @Test
    public void textProperties() {
        HashMap<String, Integer> tests = new HashMap<>();
        tests.put("", (Integer) EditorConfigLexer.EOF);
        tests.put("end_of_line", (Integer) EditorConfigLexer.PROPERTY_KEY_END_OF_LINE);
        tests.put("root", (Integer) EditorConfigLexer.PROPERTY_KEY_ROOT);
        tests.put("indent_style", (Integer) EditorConfigLexer.PROPERTY_KEY_INDENT_STYLE);
        tests.put("indent_size", (Integer) EditorConfigLexer.PROPERTY_KEY_INDENT_SIZE);
        tests.put("tab_width", (Integer) EditorConfigLexer.PROPERTY_KEY_TAB_WIDTH);
        tests.put("charset", (Integer) EditorConfigLexer.PROPERTY_KEY_CHARSET);
        tests.put("trim_trailing_whitespace", (Integer) EditorConfigLexer.PROPERTY_KEY_TRIM_TRAILING_WHITESPACE);
        tests.put("insert_final_newline", (Integer) EditorConfigLexer.PROPERTY_KEY_INSERT_FINAL_NEWLINE);
        tests.put("max_line_length", (Integer) EditorConfigLexer.PROPERTY_KEY_MAX_LINE_LENGTH);
        tests.put("unknown", (Integer) EditorConfigLexer.PROPERTY_KEY_UNKNOWN);
        test(tests);
    }

    private Integer tokenize(String source) {
        EditorConfigLexer lexer = new EditorConfigLexer(new ANTLRInputStream(source));
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        // first token
        Token token = tokens.LT(1);
        Assert.assertThat(tokens.LT(2).getType(), Is.is(EOF));
        return token == null ? null : token.getType();
    }

    private void test(Map<String, Integer> tests) {
        for (Map.Entry<String, Integer> entrySet : tests.entrySet()) {
            String source = entrySet.getKey();
            Integer expected = entrySet.getValue();
            Assert.assertEquals(expected, tokenize(source));
        }
    }

}
