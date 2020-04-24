# awk编程

awk的基本功能是将文件或其他文本内容作为输入，根据特定模式(pattern)一行一行搜索，有一行匹配时就执行指定的操作(action)，然后继续下一行，直到文本内容结束位置。awk是数据驱动(data driven)的语言，关注怎么对数据进行处理，大多数其他语言是程序性的。

## awk程序的运行

直接在命令行执行：
```sh
awk 'program' input-file1 input-file2 ...
```

将程序写入文件，指定程序文件执行
```sh
awk -f program-file input-file1 input-file2 ...
```

awk脚本，如下示例，文件名为advice.awk：
```sh
#!/usr/bin/awk -f

BEGIN { print "Don't Panic!" }
```

## 语法规则

```
pattern { action }
pattern { action }
...
```
awk程序规则中，pattern或者action可以不必同时存在，但必须有一个，如果省略pattern，则action对每一个输入行都执行操作；如果省略action，默认操作是打印输出所有匹配行。

## 参考

+ [The GNU Awk User's Guide](https://www.gnu.org/software/gawk/manual/gawk.html)
