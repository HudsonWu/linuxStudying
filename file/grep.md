## grep

global search regular expression and print out the line

强大的文本搜索工具, 使用正则表达式搜索文本, 并把匹配的行打印出来

### 简单用法

```
1. 在多个文件中查找
grep "match_pattern" file_1 file_2 ...
2. 输出匹配之外的所有行
grep -v "match_pattern" file_name
3. 标记匹配颜色
grep "match_pattern" file_name --color=auto
4. 使用扩展正则表达式
grep -E "[1-9]+"
egrep "[1-9]+"
5. 只输出文件中匹配到的部分
echo this is a test line. | grep -o -E "[a-z]+\."
6. 统计文件或者文本中包含匹配字符串的行数
grep -c "text" file_name
7. 输出包含匹配字符串的行数
grep "text" -n file_name
cat file_name | grep "text" -n
grep "text" -n file_1 file_2
8. 搜索多个文件并查找匹配文本在哪些文件中
grep -l "text" file1 file2 file3 ...
9. 递归搜索文件
grep "text" . -r -n
10. 忽略匹配样式中的字符大小写, -i
11. 多个匹配
echo this is a text line | grep -e "is" -e "line" -o
echo aaa bbb ccc ddd eee | grep -f patfile -o  //在patfile文件中逐行写出需要匹配的字符
12. 静默输出, 一般用于条件测试
grep -q "test" filename
//不会输出任何信息, 如果命令运行成功返回0, 失败返回非0值
```

### 更多用法

```
1. 在grep搜索结果中包括或排除指定文件
//只在目录中所有的.php和.html文件中递归搜索字符"main()"
grep "main()" . -r --include *.{php,html}
//在搜索结果中排除所有README文件
grep "main()" . -r --exclude "README"
//搜索结果中排除filelist文件列表里的文件
grep "main()" . -r --exclude-from filelist

2. 打印出匹配文本之前或之后的行
//显示匹配某个结果之后的3行
seq 10 | grep "5" -A 3
//显示匹配某个结果之前的3行
seq 10 | grep "5" -B 3
//显示匹配某个结果的前3行和后3行
seq 10 | grep "5" -C 3
//如果匹配结果有多个, 会用‘--’作为各匹配结果之间的分隔符
echo -e "a\nb\nc\na\nb\nc" | grep a -A 1

3. 打印样式匹配所位于的字符或字节偏移
echo gun is not unix | grep -b -o "not"
> 7:not
//一行中字符串的字符偏移从该行第一个字符开始计算, 起始值是0
//选项-b和-o总是配合使用

4. 使用0值字节后缀的grep和xargs
//测试文件
echo "aaa" > file1
echo "bbb" > file2
echo "aaa" > file3

grep "aaa" file* -lZ | xargs -0 rm

//执行后会删除file1和file3
//-Z通常和-l结合使用
//grep输出用-Z选项来指定以0值字节作为文件名的终结符(\0)
//xargs -0读取输入并用0值字节终结符分隔文件名, 然后删除匹配文件
```
