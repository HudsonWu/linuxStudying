## rename

### 通配符
<pre>
假设文件夹中有文件foo1,foo2,...,foo200
1. ? 替代单个字符
rename foo foo0 foo?
找到文件名为4个字符长度且前三个字符为foo的文件, 将文件名中的foo替换为foo0
2. * 替代多个字符
rename foo foo0 foo*
找到文件名以foo开头的文件, 替换foo为foo0
3. [charset] 替代charset集中的任意单个字符
rename foo0 foo foo0[2]*
找到文件名以foo02开头的文件, 替换foo0为foo
</pre>

### 正则表达式
```
1. 字母的替换
rename "s/AA/aa/" *  //把文件名中的AA替换成aa
2. 修改文件的后缀
rename "s/\.html/\.php/" *  //把.html后缀改成.php
3. 批量添加文件后缀
rename "s/$/\.txt/" *  //把所有文件名都以.txt结尾
4. 批量删除文件名
rename "s/\.txt//" *  //把所有以.txt结尾的文件名的.txt删除
```
