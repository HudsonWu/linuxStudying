# cut, 字符截取命令

cut, extract(cut out) selected fields of each line of a file, cut可以对file或stdin或pipe的每行抽取处希望抽取的部分

如果不指定file参数, cut命令将读取标准输入, 必须指定-b, -c, -f标志之一

```
cut [OPTION]... [FILE]...

-b, --bytes=LIST    以字节为单位进行分割, 这些字节位置将忽略多字节字符边界, 除非也指定了-n标志
-c, --characters=LIST    以字符为单位进行分割
-d, --delimiter=DELIM    自定义分隔符, 默认为制表符
-f, --fields=LIST    与-d一起使用, 指定显示哪个区域
    -f1    显示第一个字段
    -f 1,3    显示第一个和第三个字段
    -f 1-3    显示第一个到第三个字段
-n, 取消分割多字节字符, 仅和-b标志一起使用
```

cut命令的不足: 如果文件里面的某些域是由若干个空格来间隔的, 使用cut就有点麻烦, 因为cut只擅长处理"以一个字符间隔"的文本内容

## 命令实例

1. 准备素材
```console
$ cat test.txt
No Name Mark Percent
01 tom 59 91
02 jack 71 87
03 alex 58 98

$ cat test2.txt
No;Name;Mark;Percent
01;tom;69;91
02;jack;71;87
03;alex;68;98

$ cat test3.txt
abcdefghijklmnopqrstuvwxyz
abcdefghijklmnopqrstuvwxyz
abcdefghijklmnopqrstuvwxyz
abcdefghijklmnopqrstuvwxyz
abcdefghijklmnopqrstuvwxyz
```

2. 提取指定字段
```console
$ cut -f 1 test.txt
No
01
02
03

$ cut -f2,3 test.txt
Name Mark
tom 69
jack 71
alex 68
```

3. --complement 选项提取指定字段之外的列
```console
$ cut -f2 --complement test.txt
No Mark Percent
01 69 91
02 71 87
03 68 98
```

4. 指定字段分隔符
```console
$ cut -f2 -d";" test2.txt
Name
tom
jack
alex
```

5. 打印第1到第3个字符
```console
$ cut -c1-3 test3.txt
abc
abc
abc
abc
abc
```

6. 打印前两个字符
```console
$ cut -c-2 test3.txt
ab
ab
ab
ab
ab
```

7. 打印从第5个字符开始到结尾
```console
$ cut -c5- test3.txt
efghijklmnopqrstuvwxyz
efghijklmnopqrstuvwxyz
efghijklmnopqrstuvwxyz
efghijklmnopqrstuvwxyz
efghijklmnopqrstuvwxyz
```

8. 显示文件的第1个到第8个字节
```console
$ cut -b 1-8 test3.txt
abcdefgh
abcdefgh
abcdefgh
abcdefgh
abcdefgh
```

9. 打印第3, 第4, 第5和第8个字节
```console
$ cut -b 3-5,8 test3.txt
cdeh
cdeh
cdeh
cdeh
cdeh
```
