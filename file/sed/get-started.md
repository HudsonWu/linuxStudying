# 快速开始

```
# 从第一个匹配beginchars的行开始输出
# 直到第一个匹配endchars的行输出后结束
sed -n '/beginchars/, /endchars/p' myfile

# 输出第12到18行
sed -n '12,18p' myfile

# 输出一行的同时增加一个空白行
sed G myfile > newfile

# sed将多个文件视为一个长流（long stream）
# 多条命令以分号隔开
# 输出第一个文件的第一行，以及最后一个文件的最后一行
sed -n '1p ; $p' one.txt two.txt three.txt

# 先备份文件，文件名在源文件名后加.bak，然后修改源文件
sed -i.bak '...' myfile

# 输出行，直到有一行行首匹配foo，如果有匹配，则退出，退出状态码为42，
# 否则输出到最后，然后正常退出（退出状态码为0）
sed '/^foo/q42' input.txt > output.txt
```

## 替换命令 s

+ `s/regexp/replacement/flags`


### replacement

```
\L, 将replacement中的字符替换为小写直到\U或\E出现
\l, 替换下一个字符为小写
\U, 将replacement中的字符替换为大写直到\L或\E出现
\u, 替换下一个字符为大写
\E, 停止由\L或\U带来的大小写转换
```

### flags

```
g, 替换所有匹配，而不仅仅是第一个
number, 只替换指定数目的匹配
p, 打印替换后的结果
w filename, 写入文件
```

### 示例

```
# a-b- 替换为 axxB
s/\(b\?\)-/x\u\1/g

# a-b- 替换为 aXBx
s/\(b\?\)-/\u\1x/g

# a-b- 替换为aXBX
s/\(b\?\)-/\U\1x\E/g
```
