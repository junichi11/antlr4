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
parser grammar EditorConfigParser;
options { tokenVocab=EditorConfigLexer; }

file
    : (rootPropertyStatement? section*)? EOF
    ;

section
    : sectionHeader propertyStatement*
    ;

sectionHeader
    : '[' SECTION_NAME ']'
    ;

rootPropertyStatement
    : 'root' '=' propertyValue
    ;

propertyStatement
    : propertyKey '=' propertyValue
    ;

propertyKey
    : PROPERTY_KEY_INDENT_STYLE
    | PROPERTY_KEY_INDENT_SIZE
    | PROPERTY_KEY_TAB_WIDTH
    | PROPERTY_KEY_END_OF_LINE
    | PROPERTY_KEY_CHARSET
    | PROPERTY_KEY_TRIM_TRAILING_WHITESPACE
    | PROPERTY_KEY_INSERT_FINAL_NEWLINE
    | PROPERTY_KEY_ROOT
    | PROPERTY_KEY_MAX_LINE_LENGTH
    | PROPERTY_KEY_UNKNOWN
    ;

propertyValue
    : PROPERTY_VALUE
    ;

