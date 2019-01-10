# xargs, 读取输入数据重新格式化后输出

xargs命令是给其他命令传递参数的一个过滤器, 也是组合多个命令的一个工具, 它擅长将标准输入数据转换成命令行参数, xargs能够处理管道或者stdin并将其转换成特定命令的命令参数, xargs也可以将单行或多行文本输入转换为其他格式, 例如多行变单行, 单行变多行

xargs的默认命令式echo, 空格是默认定界符, 这意味着通过管道传递给xargs的输入将会包含换行和空白, 不过通过xargs的处理, 换行和空白将被空格取代, xargs是构建单行命令的重要组件之一

## 语法

xargs一般是和管道一起使用
```
somecommand | xargs -item command
```

参数:
```
-0, 将\0, 即NULL字符作为定界符
-a file, 从文件中读入作为stdin
-e flag, 有时可能会是E, flag必须是一个以空格分隔的标志
         当xargs分析到含有flag这个标志的时候就停止
-p, 每次执行一个argument时询问一次用户
-n num, 参数分组, 表示命令在执行时一次用的argument的个数, 默认是用所有的
-t, 表示先打印命令, 然后再执行
-i replace-str, 或者-I replace-str, 参数替换 
                指定一个替换字符串, 默认为{}, 这个字符串在xargs扩展时会被替换掉
                当-I与xargs结合使用, 每一个参数命令都会被执行一次
-r no-run-if-empty, 当xargs的输入为空的时候则停止xargs, 不用再去执行了
-s num, 命令行的最大字符数, 指的是xargs后面那个命令的最大命令行字符数
-L num, 从标准输入一次读取num行给command命令
-d delim, 分隔符, 默认的xargs分隔符是回车, argument的分隔符是空格, 
          这里修改的是xargs的分隔符
-x, exit的意思, 主要配合-s使用
-P, 修改最大的进程数, 默认是1, 为0时as many as it can
```

## 实例

```console
$ cat test.txt

a b c d e f g
h i j k l m n
o p q
r s t
u v w x y z
$ cat test.txt | xargs
a b c d e f g h i j k l m n o p q r s t u v w x y z
$ cat test.txt | xargs -n3
a b c
d e f
g h i
j k l
m n o
p q r
s t u
v w x
y z
```

```console
$ echo "nameXnameXnameXname" | xargs -dX -n2
name name
name name
```

```
cat arg.txt | xargs -I {} ./sk.sh -p {} -l

//将所有的.js结尾的文件, 加上.backup后缀
ls *.js | xargs -t -I '{}' mv {} {}.backup

//将所有的.py文件移动到Python目录
find . -name '*.py' | xargs -I {} mv {} ./Python

//将7天前的日志备份到指定目录
find . -mtime +7 | xargs -I '{}' mv {} /tmp/otc-svr-logs/

//-print0, 告诉find命令, 在输出文件名后, 跟上NULL字符, 而不是换行符
//-0， 告诉xargs, 以NULL作为参数分隔符
find . -type f -name "*.log" -print0 | xargs -0 rm -f

//统计一个源代码目录中所有php文件数量
find . -type f -name "*.php" -print0 | xargs -0 wc -l

//查找所有jpg文件, 然后压缩它们
find . -type f -name "*.jpg" -print | xargs tar -czvf images.tar.gz

//下载文件中的所有链接
cat url-list.txt | xargs wget -c
```
