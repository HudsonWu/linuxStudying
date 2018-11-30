## 编辑器
<pre>
Markdown编辑器推荐:
在线版: dillinger, StackEdit, MaHua, 简书, 马克飞象
windows: MarkdownPad, MarkPad, Smark, Miu
跨平台: Cmd Markdown, 小书匠, FarBox, Atom, ReText
</pre>
1. retext
<pre>
apt-get install retext
retext Release-Notes.md
</pre>

2. Vim-Instant-Markdown插件
<pre>
https://github.com/suan/vim-instant-markdown
</pre>

## 转换成html
<pre>
1. discount
apt-get install discount
markdown -o Release-Notes.html Release-Notes.md
2. python-markdown软件包提供的markdown
apt-get install python-markdown
markdown_py -o html4 Release-Notes.md > Release-Notes.html
</pre>

## 转换成pdf
<pre>
//使用python-pisa提供的xhtml2pdf
apt-get install python-pisa
xhtml2pdf --html Release-Notes.html Release-Notes.pdf
</pre>

## 转换中出现的编码问题
```js
sed -i '1i\<meta http-equiv="content-type" content="text/html; charset=UTF-8">' *.md
```

## Makefile
可以在文档目录下放置Makefile来自动转换过程
```js
# Makefile

MD = markdown
MDFLAGS = -T
H2P = xhtml2pdf
H2PFLAGS = --html
SOURCES := $(wildcard *.md)
OBJECTS := $(patsubst %.md, %.html, $(wildcard *.md))
OBJECTS_PDF := $(patsubst %.md, %.pdf, $(wildcard *.md))

all: build

build: html pdf

pdf: $(OBJECTS_PDF)

html: $(OBJECTS)

$(OBJECTS_PDF): %.pdf: %.html
    $(H2P) $(H2PFLAGS) $< > $@

$(OBJECTS): %.html: %.md
    $(MD) $(MDFLAGS) -o $@ $<
clean:
    rm -f $(OBJECTS)
```

## 继续学习
```js
https://legacy.gitbook.com/book/wizardforcel/markdown-simple-world/details  Markdown-简单的世界
https://www.appinn.com/markdown/  Markdown语法说明

空格符号:
半方大的空白&ensp;或&#8194;
全方大的空白&emsp;或&#8195;
不断行的空白格&nbsp;或&#160;
```
