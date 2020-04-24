# 正则表达式

+ 用斜线包裹的正则表达式称为正则表达式常量 (regexp constant)
+ 正则表达式中，`*`、`+`、`?`以及`{`、`}`操作符具有最高的优先级，其次是连接，最后是`|`

## 将正则表达式括在斜线(/)中，用作模式(pattern)

```sh
awk '/li/ { print $2 }' data
```

## 用于匹配表达式

`~`和`!~`操作符执行正则表达式比较，`exp ~ /regexp/`表示exp匹配regexp时为true，`exp !~ /regexp/`表示exp不匹配regexp时为true。

```sh
## 打印所有输入行第一个字段中有大写字母J的行
awk '$1 ~ /J/' data
awk '{ if ($1 ~ /J/) print }' data

## 打印所有输入行第一个字段中没有大写字母J的行
awk '$1 !~ /J/' data
```

## 匹配规则

正则表达式总是匹配最左边(leftmost)，然后最长的字符序列(longest)。

```sh
$ echo aaaabcd | awk '{ sub(/a+/, "<A>"); print }'
<A>bcd
```

## 字符类 (Character classes)

字符类是POSIX标准中引入的一个特性，一个字符类描述的是一种有特定属性的字符列表，实际字符可能因国家或字符集而不同。

```
[:alnum:]      alphanumeric, 字母数字字符
[:alpha:]      alphabetic, 字母字符
[:blank:]      空格和tab字符
[:cntrl:]      Control字符
[:digit:]      numeric, 数字字符
[:graph:]      既可打印也可见的字符 (空格可打印但不可见)
[:lower:]      小写字母
[:upper:]      大写字母
[:print:]      可打印字符 (不是控制字符的字符)
[:punct:]      punctuation, 标点符号字符 (不是字母、数字、控制字符或空格字符的字符)
[:space:]      空白字符 (包括空格、tab、newline、carriage return、formfeed以及vertical tab)
[:xdigit:]     十六进制数字
```

## gawk特定正则操作符

GNU软件在处理正则表达式时提供了许多附加的正则操作符，这些操作符特定于gawk，其他awk实现中不可用。

+ 单词(`word`)表示一个或多个字母、数字以及下划线(`_`)组成的字符序列

```
\s    匹配任何空白字符，可以看作[[:space:]]的缩写
\S    匹配任何非空白字符，可以看作[^[:space:]]的缩写
\w    匹配任何单词(word)形式的字符，可以看作[[:alnum:]_]的缩写
\W    匹配任何非单词形式的字符，可以看作[^[:alnum:]_]的缩写
\<    匹配空字符串，表示单词的开头
\>    匹配空字符串，表示单词的结尾
\y    匹配空字符串，表示单词边界，开头或结尾
\B    匹配组成单词字符之间的空字符串，和\y相反
\`    匹配空字符串，表示缓冲区字符串的开头，buffer(string)
\'    匹配空字符串，表示缓冲区字符串的结尾，buffer(string)
```

## 命令行选项

不同的命令行选项控制gawk在正则中对字符的解释：
+ No options, 默认情况下，gawk支持POSIX规范的正则、GNU正则操作符、Interval expressions
+ --posix, 仅支持POSIX规范的正则，不支持GNU正则操作符，Interval expressions不被允许
+ --traditional, 传统unix awk正则，不支持GNU正则操作符，Interval expressions不可用
  + 支持POSIX字符类，八进制和十六进制转义序列按字面意思解释
+ --re-interval, 如果有选项--traditional, 则允许正则中的Interval expressions

```
## 区间表达式，Interval Expressions
在传统unix awk正则中，对大括号(`{}`)表示的区间范围功能是不支持的，
在4.0版本中，作为POSIX标准的一部分添加了。
```

## 大小写

默认情况下字母的匹配大小写是敏感的，有几种方式可以实现忽略大小写：
```
# 最简单的方法
[Ww]

# 使用tolower()或toupper()转换
tolower($1) ~ /foo/ { .. }

# gawk, 配置IGNORECASE变量为非零值
x = "aB"
if (x ~ /ab/) ...  # this test will fail
IGNORECASE = 1
if (x ~ /ab/) ... # now it will succeed
```

## 使用技巧

```
# 字母数字字符
/[A-Za-z0-9]/
/[[:alnum:]]/  # 匹配你的字符集中的字母和数字字符

# 一些工具提供了[:ascii:]字符类，awk中没有这个字符类
# awk中可以使用十六进制实现
[\x00-\x7F]  # 匹配0到127之间的所有值，即ASCII字符集范围
[^\x00-\x7F]  # 匹配不在ASCII字符范围的字符
```
