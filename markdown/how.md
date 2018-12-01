## 一些学习站点

+ [Markdown-简单的世界](https://legacy.gitbook.com/book/wizardforcel/markdown-simple-world/details)
+ [Markdown语法说明](https://www.appinn.com/markdown)
+ [Markdown常用语法总结](https://github.com/guangqiang-liu/MarkdownSyntax)

## 基本语法
```
 1. 段落(<p></p>)
一行文字就是一个段落
如要另起一段, 在两个段落之间加一个空行
(不加一个空行的换行行为, 一些编辑器解释为换行, 一些编辑器解释为插入一个空格; 对于后者若要插入换行, 输入两个空格)

2. 斜体, 粗体(<em></em>, <strong></strong>)
使用*或_指定粗体或者斜体
*这是斜体*
_这也是斜体_
**这是粗体**
***这是粗体加斜体***

3. 删除线(<strike></strike>)
使用~定义删除线
~~就像这样~~

4. 标题(H1-H6)
markdown总支持1~6六级标题, 通过在一行之前加上不同数量的#来表示
# 这是H1 #
## 这是H2 ##
行尾可以加上任意数量的井号字符, 这些字符不会算作标题内容, 通常会加上相等数量的字符以保持对称
H1和H2也可以采用在文本下方添加底线来实现
这是H1
======
这是H2
------

5. 引用
通过在行首加上>来添加引用格式
> This is a blockquote
引用可以嵌套
> This is the first level of quoting
>
> > This is nested blockquote
>
> Back to the first level
也可以嵌套其他格式
> ## 这是一个标题
>
> 1. 这是第一行列表项
> 2. 这是第二行列表项
>
> 给出一些例子代码
>
> return shell_exec("echo $input | $markdown_script");

6. 列表
无序列表使用 * 或 + 或 - 来标记
* Red
+ Red
- Red
有序列表使用数字接着一个英文句点
 1. Bird
 2. McHale

7. 内联代码
使用反引号`来标记内联代码, 会解释成<code>标签, 如果代码的内容中有反引号, 使用两个反引号包裹, 代码中的& < >符号都会自动转义
有两种方式标记代码区域, 原生风格是行首缩进4个空格
这是一个普通段落:
    这是一个代码区块
还有一种是github风格, 代码段的前后用三个反引号独占一行来标记
```
这是一个代码区块
```

8. 分割线
可以用三个以上的 * 或 - 或 _ 来建立一个分隔线, 行内不能有其他东西, 可以在中间插入空格
* * *
***
*****
- - -
----------

9. 链接
 a. 行内式
[an example](http://example.com/)
[an example](http://example.com/ "Optional Title")
会被解释为:
<a href='http://example.com/'>an example</a>
<a href='http://example.com/' title="Optional Title">an example</a>
 b. 参考式
[an example][id]
然后在任意空白位置定义
[id]: http://example.com/ "Optional Title"

10. 图像
![Alt text](/path/to/img.jpg)
![Alt text](/path/to/img.jpg "Optional Title")
会被解释为:
<img src='/path/to/img.jpg' alt='Alt text' />
<img src='/path/to/img.jpg' alt='Alt text' title='Optional Title' />

11. 自动链接
如果链接的地址和名字重复, 使用尖括号简化
<http://example.com/>
相当于:
[http://example.com/](http://example.com/)
大多数编辑器都会将符合url规则的东西视为链接, 很多时候由于疏忽等原因, 链接和后面的中文缺少空格, 导致链接不正常, 
所以建议链接要么加上尖括号, 要么两端加上空格

12. 转义
markdown支持在以下字符前插入反斜杠, 插入后, 将不再解析这些字符, 而是原样输出
\ 反斜杠, ` 反引号, * 星号, _ 下划线, {} 花括号, [] 方括号, () 括弧, 
# 井号, + 加号, - 减号, . 英文句点, ! 惊叹号

13. 表格
表格是github风格独有的语法
| Item     | Value | Qty   |
| :------- | ----: | :---: |
| Computer | $1600 |  5    |
| Phone    | $12   |  12   |
| Pipe     | $1    |  234  |
会被解释成:
<table>
<thead>
<tr>
    <th align="left">Item</th>
    <th align="right">Value</th>
    <th align="center">Qty</th>
</tr>
</thead>
<tbody><tr>
    <td align="left">Computer</td>
    <td align="right">$1600</td>
    <td align="center">5</td>
</tr>
<tr>
    <td align="left">Phone</td>
    <td align="right">$12</td>
    <td align="center">12</td>
</tr>
<tr>
    <td align="left">Pipe</td>
    <td align="right">$1</td>
    <td align="center">234</td>
</tr>
</tbody></table>
要注意第二行的冒号决定了居左居右还是居中, 如果不加冒号, 默认居左
可以把第一行去掉, 做成没有表头的表格, 但第二行始终都要有的

14. 内联HTML
任何html标签及其内容都会原样输出到结果中

空格符号:
半方大的空白&ensp;或&#8194;
全方大的空白&emsp;或&#8195;
不断行的空白格&nbsp;或&#160;
```
