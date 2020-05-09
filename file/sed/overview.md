# sed, stream editor, 流编辑器

+ [gnu.org manual](https://www.gnu.org/software/sed/manual/sed.html)

用程序的方式来编辑文本，基本上就是使用正则模式匹配。

## 语法

```
sed [-hnV] [-e<script>] [-f<script文件>] [文本文件]

参数说明:
-e <script>或--expression=<script>, 以选项中指定的script来处理输入的文本文件
-f <script文件>或--file=<script文件>, 以选项中指定的script文件来处理输入的文本文件
-h或--help, 显示帮助
-n或--quiet或--slient, 仅显示script处理后的结果
-V或--version, 显示版本信息

动作说明:
1. 新增, a
sed -e 4a\newline testfile  //在testfile文件第四行后添加一行, 内容为newline
nl /etc/passwd | sed '2a drink tea'  //在第二行后添加一行，内容为drink tea
nl /etc/passwd | sed '2a Drink tea or ......\
drink beer ?'  //在第二行后增加两行(每一行后使用\来进行新行的添加)
2. 取代, c
nl /etc/passwd | sed '2,5c No 2-5 number'  //将第2-5行内容取代成No 2-5 number
3. 删除, d
nl /etc/passwd | sed '2,5d'  //将/etc/passwd的内容加行号列出, 并将2~5行删除
nl /etc/passwd | sed '/root/d'  //删除/etc/passwd所有包含root的行, 其他行输出
4. 插入, i
nl /etc/passwd | sed '2i drink tea'  //在第二行前插入一行, 内容为drink tea
5. 打印, p
nl /etc/passwd | sed -n '5,7p'  //仅列出5-7行
nl /etc/passwd | sed '/root/p'  //搜索有root关键字的行(除了输出所有行, 还会输出匹配行)
nl /etc/passwd | sed -n '/root/p'  //只打印包含模板的行
6. 取代, s
nl /etc/passwd | sed -n '/root/{s/bash/blueshell/;p;q}'
//找到root对应的行, 执行花括号的一组命令, 每个命令之间用分号分隔, 最后的q是退出
```

## Usage

```
1. 用s命令替换
sed "s/my/Hao Chen's/g" pets.txt
s表示替换命令, /my表示匹配my, /Hao Chen's表示把匹配替换成Hao Chen's, /g表示替换所有匹配
注意:
  上面的sed命令只是将处理后的内容输出，并没有写入文件, 如要写入, 可使用重定向
    sed "s/my/Hao Chen's/g" pets.txt > hao_pets.txt
    或者使用-i参数直接修改文件内容
    sed -i "s/my/Hao Chen's/g" pets.txt
2. 在每一行前面加点东西
sed 's/^/#/g' pets.txt
3. 在每一行后面加点东西
sed 's/$/ --- /g' pets.txt
4. 替换指定行的内容
sed "3s/my/your/g" pets.txt  替换第3行
sed "3,6s/my/your/g" pets.txt  替换3到6行
5. 替换匹配的第几个
sed 's/s/S/1' my.txt  只替换每一行的第一个s
sed 's/s/S/2' my.txt  只替换每一行的第二个s
sed 's/s/S/3g' my.txt  替换每一行的第3个以后的s
6. 多个匹配
sed '1,3s/my/your/g; 3,$s/This/That/g' my.txt
等价于:
sed -e '1,3s/my/your/g' -e '3,$s/This/That/g' my.txt
7. 变量
sed 's/my/[&]/g' my.txt  使用&来当做被匹配的变量
sed 's/This is my \([^,]*\),.*is \(.*\)/\1:\2/g' my.txt
圆括号括起来的正则表达式所匹配的字符串可以当成变量来使用, 使用\1, \2来表示
This is my cat, my cat's name is betty  ->  cat:betty
```

#### 正则表达式

```
^ 表示一行的开头, 如: /^#/ 以#开头的匹配 
$ 表示一行的结尾, 如: /}$/ 以}结尾的匹配 
\< 表示词首,  如: \<abc 以abc 为首的詞
\> 表示词尾,  如: abc\> 以abc 結尾的詞 
. 表示任何单个字符
* 表示某个字符出现了0次或多次, 
[ ] 字符集合. 如: [abc] 表示匹配a或b或c，还有 [a-zA-Z] 表示匹配所有的26个字符.如果其中有^表示反，如 [^a] 表示非a的字符
```

#### 例子: html.txt

```
<b>This</b> is what <span style="text-decoration: underline;">I</span> meant. Understand?
sed 's/<.*>//g' html.txt
-> meant. Understand?
sed 's/<[^>]*>//g' html.txt
This is what I meant. Understand?
```

## 一些有用的命令

```
1. 在指定行前面或后面插入新行
sed '/test/i\ add a new line' -i a.txt
sed '/test/a\ a new line' -i a.txt
sed -i '/allow 361way.com/iallow www.361way.com' the.conf.file
```
