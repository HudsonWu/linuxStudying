# paste, 将多个文件的内容合并

粘贴两个不同来源的数据时, 首先需将其分类, 并确保两个文件行数相同. paste将按行将不同文件行信息放在一行, 默认情况下, paste连接时, 用空格或tab键分隔新行中不同文本, 除非指定-d选项, 它将成为域分隔符

```
paste -d -s - file1 file2

-d, 指定不同于空格或tab键的域分隔符, 例如用 @ 分隔域, 使用 -d @
-s, 将每个文件合并成行而不是按行粘贴
-, 使用标准输入, 例如ls -l | paste -, 意即只在一列上显示输出
```

## 使用实例

```console
$ cat pas1
ID897
ID666
ID982
$ cat pas2
P.Jones
S.Round
L.Clip
$ paste pas1 pas2
ID897   P.Jones
ID666   S.Round
ID982   L.Clip
$ paste pas2 pas1
P.Jones ID897
S.Round ID666
L.Clip  ID982
$ paste -d: pas1 pas2
ID897:P.Jones
ID666:S.Round
ID982:L.Clip
$ paste -s pas1 pas2
ID897   ID666   ID982
P.Jones S.Round L.Clip
```

paste命令有一个很有用的选项 `-`, 意即对每一个`-`, 从标准输入中读入一次数据, 使用空格做域分隔符
```console
$ ls /usr | paste -d" " - - - - - -
bin etc games include java lib
lib64 libexec local sbin share src
tmp  
$ ls /usr | paste -d" " -
bin
etc
games
include
java
lib
lib64
libexec
local
sbin
share
src
tmp
```
