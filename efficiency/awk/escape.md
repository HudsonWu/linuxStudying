# 转义序列 (Escape Sequences)

以反斜线(`\`)开头的字符序列称为转义序列，有些字符不能按字面意思包含在字符常量或正则表达式常量中，还有一些不可打印字符，都需要转义。

```
\\      反斜线
\a      警告(alert)字符，Ctrl-g，ASCII code 7 (BEL)
\b      Backspace, Ctrl-h, ASCII code 8 (BS)
\f      Formfeed, Ctrl-l, ASCII code 12 (FF)
\n      Newline, Ctrl-j, ASCII code 10 (LF)
\r      Carriage return, Ctrl-m, ASCII code 13 (CR)
\t      Horizontal TAB, Ctrl-i, ASCII code 9 (HT)
\v      Vertical TAB, Ctrl-k, ASCII code 11 (VT)
\nnn    八进制值，如\033表示ASCII ESC
\xhh... 十六进制值
```
