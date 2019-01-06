# sort, sorts the contents of a text file, line by line

sort将文件的每一行作为一个单位, 相互比较, 比较原则是从首字符向后, 依次按ASCII码值进行比较, 最后将他们升序输出

默认排序规则:
1. 数字排在字母之前
2. 小写字母排在大写字母之前

## 语法

```
sort [options] [files]

-b, --ignore-leading-blanks    忽略每行前面开始处的空格字符
-d, --dictionary-order    排序时, 只考虑英文字母、数字及空格字符
-f, --ignore-case    排序时, 将小写字母视为大写字母
-c, --check, --check=diagnose-first    检查文件是否已排好序, 如果乱序, 则输出第一个乱序的行的相关信息, 最后返回1
-C, --check=quiet, --check=silent    检查文件是否已排好序, 如果乱序, 不输出内容, 仅返回1
-i, --ignore-nonprinting    排序时, 只考虑可打印字符
-o, --output=FILE    将排序结果输出到文件
-m, --merge    Merge already sorted files; do not sort
-M, --month-sort    将前面三个字母依照月份的缩写进行排序
-n, --numeric-sort    依照数值的大小进行排序
-r, --reverse    以相反的顺序排列
-u, --unique    输出行中去除重复行
-t, --field-separator=SEP    指定排序时所用的栏分隔字符
-k, --key=POS1[,POS2]    Start a key at POS1(origin 1), end it at POS2(default end of line)
```

-k选项的具体语法格式
```
[FStart[.CStart]][Modifier][,[FEnd[.CEnd]][Modifier]]

这个语法格式被其中的逗号分为两大部分, Start部分和End部分
如果不设定End部分, 那么就认为End被设定为行尾
Start部分由三部分组成, 其中的Modifier部分就是像n或r这样的选项
FStart表示使用的域, CStart表示在Fstart域中从第几个字符开始算"排序首字符"
CStart可以省略, 省略的话就表示从本域的开头部分开始
同理, 在End部分, 可以设定FEnd.CEnd, 
如果省略.CEnd, 则表示结尾到"域尾", 即本域的最后一个字符, 或者将CEnd设定为0(零)
```

## 命令实例

1. 准备素材
```console
$ cat facebook.txt
google 110 5000
baidu 100 5000
guge 50 3000
sohu 100 4500
```
facebook.txt文件有三个域, 第一个域是公司名称, 第二个域是公司人数, 第三个域是员工平均工资

2. 按公司的字母顺序排序, 即按第一个域进行排序
```console
$ sort -t' ' -k 1 facebook.txt
baidu 100 5000
google 110 5000
guge 50 3000
sohu 100 4500
```

3. 按公司人数排序
```console
$ sort -n -t' ' -k 2 facebook.txt
guge 50 3000
baidu 100 5000
sohu 100 4500
google 110 5000
```
人数相同时, 按照默认排序, 从第一个域进行升序排序, 因此baidu排在了sohu前面

4. 按公司人数排序, 人数相同时, 按照员工平均工资升序排序
```console
$ sort -n -t' ' -k 2 -k 3 facebook.txt
guge 50 3000
sohu 100 4500
baidu 100 5000
google 110 5000
```
设定域排序的优先级, 先以第2个域进行排序, 如果相同, 再以第3个域进行排序

5. 按照员工工资降序排序, 如果工资相同, 则按照公司人数升序排序
```console
$ sort -n -t' ' -k 3r -k 2 facebook.txt
baidu 100 5000
google 110 5000
sohu 100 4500
guge 50 3000

$ sort -t' ' -k 3nr -k 2n facebook.txt
baidu 100 5000
google 110 5000
sohu 100 4500
guge 50 3000
```

6. 从公司英文名称的第二个字母开始进行排序
```console
$ sort -t' ' -k 1.2 facebook.txt
baidu 100 5000
sohu 100 4500
google 110 5000
guge 50 3000
```
-k 1.2, 表示对第一个域的第二个字符开始到本域的最后一个字符为止的字符串进行排序

7. 只针对公司英文名称的第二个字母进行排序, 如果相同则按照员工工资进行降序排列
```console
$ sort -t' ' -k 1.2,1.2 -k 3,3nr facebook.txt
baidu 100 5000
google 110 5000
sohu 100 4500
guge 50 3000
```

8. 跨域排序测试
```console
$ sort -n -k 2.2,3.1 facebook.txt
guge 50 3000
baidu 100 5000
sohu 100 4500
google 110 5000
```
跨域的设定是个假象, sort只会比较第二个域的第二个字符到第二个域的最后一个字符, 不会把第三个域的开头字符纳入比较范围, 当发现00和00相同时, sort就会自动去比较第一个域

9. -k和-u联合使用
```console
$ sort -n -k 2 facebook.txt
guge 50 3000
baidu 100 5000
sohu 100 4500
google 110 5000

$ sort -n -k 2 -u facebook.txt
guge 50 3000
baidu 100 5000
google 110 5000

$ sort -k 1.1,1.1 -u facebook.txt
baidu 100 5000
google 110 5000
sohu 100 4500

$ sort -n -k 2 -k 3 -u facebook.txt
guge 50 3000
sohu 100 4500
baidu 100 5000
google 110 5000
```
-u只识别用-k设定的域, 发现相同, 就将后续相同的行都删除; 
设置了两层排序优先级的情况下, -u会权衡所有-k选项, 都相同的才会删除, 只要其中一级不同就不会删除


## References

+ [Linux sort command](https://www.computerhope.com/unix/usort.htm)
+ [sort命令详解](https://www.cnblogs.com/51linux/archive/2012/05/23/2515299.html)
