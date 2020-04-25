# 读取输入文件

在典型的awk程序中，awk从标准输入或awk命令行上指定名称的文件中读取所有输入。如果指定了输入文件，awk将按顺序读取它们，处理一个文件中的所有数据，然后再处理下一个文件，当前处理文件的名称可以从预定义变量`FILENAME`获取。

输入被读取的单位称为记录(records)，程序的规则每次处理一条记录(record)，默认情况下，一条记录是一行。每条记录会被自动分离成称为字段(fields)的块，这使得程序可以更方便地处理记录的各个部分。

awk将程序输入分为记录(records)和字段(fields)，它跟踪到目前位置从当前输入文件读取的记录数量，该值存储在`FNR`预定义变量中，该变量每次读取新文件时会重置为0，另一个预定义变量`NR`记录到目前位置从所有数据文件读取的记录总数。

通常，记录由换行字符分隔，可以通过内置变量`RS`赋值来控制记录被分隔的方式。如果`RS`是任何单个字符，则该字符用于分隔记录，否则，`RS`被视为正则表达式。(record separator)

## 记录分隔符，record separator

```sh
awk 'BEGIN { RS = "u" }
     { print $0 }' mail-list

awk '{ print $0 }' RS="u" mail-list
```

```sh
$ echo record 1 AAAA record 2 BBBB record 3 |
> gawk 'BEGIN { RS = "\n|( *[[:upper:]]+ *)" }
> 			   { print "Record =", $0, "and RT = [" RT "]" }'
Record = record 1 and RT = [ AAAA ]
Record = record 2 and RT = [ BBBB ]
Record = record 3 and RT = [
]
```

## 字段，fields

当awk读入一条记录后，记录会被自动解析或分隔成叫做字段的块，默认字段被空白(whitespace)分隔，awk中的空白表示一个或多个空格、制表符(tab)、换行符组成的任何字符串，其他语言认为是空白的其他字符(比如formfeed, vertical tab等)， 在awk中不认为是空白。

可以使用`$`加上字段编号引用记录中的字段，如`$1`代表第一个字段，`$127`代表第127个字段（与unix shell不同，字段号不限于单个数字）。`$0`表示整个记录，是个特殊情况。

`NF`是一个预定义变量，其值是当前记录中的字段数，每次读取一条记录时会自动更新`NF`值。无论有多少字段，记录中的最后一个字段都可以用`$NF`表示。
