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
/*
# EditorConfig is awesome: http://EditorConfig.org

# top-most EditorConfig file
root = true

# Unix-style newlines with a newline ending every file
[*]
end_of_line = lf
insert_final_newline = true

# Matches multiple files with brace expansion notation
# Set default charset
[*.{js,py}]
charset = utf-8

# 4 space indentation
[*.py]
indent_style = space
indent_size = 4

# Tab indentation (no size specified)
[*.js]
indent_style = tab

# Indentation override for all JS under lib directory
[lib/**.js]
indent_style = space
indent_size = 2

# Matches the exact files either package.json or .travis.yml
[{package.json,.travis.yml}]
indent_style = space
indent_size = 2
 */
lexer grammar EditorConfigLexer;

tokens {WS}

// properties
PROPERTY_KEY_ROOT
    : 'root'
    ;

PROPERTY_KEY_CHARSET
    : 'charset'
    ;

PROPERTY_KEY_END_OF_LINE
    : 'end_of_line'
    ;

PROPERTY_KEY_INDENT_SIZE
    : 'indent_size'
    ;
PROPERTY_KEY_INDENT_STYLE
    : 'indent_style'
    ;

PROPERTY_KEY_INSERT_FINAL_NEWLINE
    : 'insert_final_newline'
    ;

PROPERTY_KEY_MAX_LINE_LENGTH
    : 'max_line_length'
    ;

PROPERTY_KEY_TAB_WIDTH
    : 'tab_width'
    ;

PROPERTY_KEY_TRIM_TRAILING_WHITESPACE
    : 'trim_trailing_whitespace'
    ;

PROPERTY_KEY_UNKNOWN
    : TEXT
    ;

SECTION_LDELIMITER
    : '[' -> pushMode(SECTION_INNER_MODE)
    ;

SECTION_RDELIMITER
    : ']'
    ;

ASSIGNMENT
    : '=' -> pushMode(PROPERTY_VALUE_MODE)
    ;

WS
    : [ \t\r\n]+ -> channel(HIDDEN)
    ;

COMMENT
    : ('#' | ';') ~[\r\n]* -> channel(HIDDEN)
    ;

TEXT
    :  ~(' ' | '=' | '\t' | '\r' | '\n' | '#' | ';' | '[' | ']')+
    ;

// e.g. [*.py]
mode SECTION_INNER_MODE;
SECTION_NAME
    : ~[\[\]\r\n#]+ -> popMode
    ;

SECTION_EXIT
    : [\r\n] -> type(WS), channel(HIDDEN), popMode
    ;

mode PROPERTY_VALUE_MODE;
PROPERTY_VALUE_WS
    : WS -> type(WS), channel(HIDDEN)
    ;

PROPERTY_VALUE
    : TEXT -> popMode
    ;
