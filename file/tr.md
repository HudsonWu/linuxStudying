# tr, 转换或删除字符

tr指令从标准输入设备读取数据, 经过字符串转译后, 将结果输出到标准输出设备

```
tr [-cdst] [--help] [--version] [第一字符集] [第二字符集]
tr [OPTION] ... SET1 [SET2]

-d, --delete: 删除所有属于第一字符集的字符
-s, --squeeze-repeats: 把连续重复的字符以单独一个字符表示
-t, --truncate-set1: 削减SET1指定范围, 使之与SET2设定长度相等
-c, --complement: 反选设定字符, 也就是符合SET1的部分不做处理, 不符合的部分才进行处理

SET1: 指定要转换或删除的原字符集
SET2: 指定要转换成的目标字符集
```

集合是可以自己制定的, 例如: 'ABD-}', 'bB.,', 'a-de-h', 'a-c0-9'都属于集合, 集合里可以使用'\n', '\t', 可以可以使用其他ASCII字符

字符集合的范围:
```
\NNN    八进制值的字符 NNN (1 to 3 为八进制值的字符)
\\    反斜杠
\a    Ctrl-G 铃声
\b    Ctrl-H 退格符
\f    Ctrl-L 走行换页
\n    Ctrl-J 新行
\r    Ctrl-M 回车
\t    Ctrl-I tab键
\v    Ctrl-X 水平制表符
CHAR1-CHAR2    字符范围从 CHAR1 到 CHAR2 的指定, 范围的指定以 ASCII 码的次序为基础,
               只能由小到大, 不能由大到小
[CHAR*]    这是 SET2 专用的设定, 功能是重复指定的字符到与 SET1 相同长度为止
[CHAR*REPEAT]    这也是 SET2 专用的设定, 功能是重复指定的字符到设定的 REPEAT 次数为止
                 (REPEAT 的数字采 8 进位制计算, 以 0 为开始)
[:alnum:]    所有字母字符与数字
[:alpha:]    所有字母字符
[:blank:]    所有水平空格
[:cntrl:]    所有控制字符
[:digit:]    所有数字
[:graph:]    所有可打印的字符(不包含空格符)
[:lower:]    所有小写字母
[:print:]    所有可打印的字符(包含空格符)
[:punct:]    所有标点字符
[:space:]    所有水平与垂直空格符
[:upper:]    所有大写字母
[:xdigit:]    所有 16 进位制的数字
[=CHAR=]    所有符合指定的字符(等号里的 CHAR, 代表你可自订的字符)
```

```console
//将字符从小写转换成大写
$ cat testfile | tr a-z A-Z
//或者
$ cat testfile | tr [:lower:] [:upper:]

//将制表符转换为空格
$ cat text | tr '\t' ' '

//删除字符
$ echo "hello 123 world 456" | tr -d '0-9'
hello world

//字符集补集, 从输入文本中将不在补集
$ echo aa.,a 1 b#$bb 2 c*/cc 3 ddd 4 | tr -d -c '0-9 \n'
1  2  3  4

//压缩重复字符
$ echo "thissss is      a text linnnnnnne." | tr -s ' sn'
this is a text line.

//巧妙使用tr做数字相加操作
$ echo 1 2 3 4 5 6 7 8 9 | xargs -n1 | echo $[ $(tr '\n' '+') 0 ]
45

//删除windows文件造成的'^M'字符
$ cat file | tr -s "\r" "\n" > new_file
//或者
$ cat file | tr -d "\r" > new_file
```
