# 一些有用概念介绍

## 换行

```sh
# 语句太长，换一行更具可读性
awk '/This regular expression is too long, so continue it\
 on the next line/ { print $1 }'

# 语句很短， 使用分号分隔符将多个语句放到一行
/12/ { print $0 } ; /21/ { print $0 }
```

## BEGIN, END

+ awk在读取任何输入之前执行与BEGIN相关的语句
+ 与END相关的语句在所有输入被读取后执行

## 注释(comments)

```sh
awk 'BEGIN { print "hello" } # let'"'"'s be cute'
```

```sh
# This program prints a nice, friendly message.  It helps
# keep novice users from being afraid of the computer.
BEGIN    { print "Don't Panic!" }
```
