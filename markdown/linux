# linux 下使用markdown进行文档工作

## 编辑器

### retext
> apt-get install retext
> retext Release-Notes.md

### Vim-Instant-Markdown插件
https://github.com/suan/vim-instant-markdown

## 转换成html
1. discount
> apt-get install discount
> markdown -o Release-Notes.html Release-Notes.md
2. python-markdown软件包提供的markdown
> apt-get install python-markdown
> markdown_py -o html4 Release-Notes.md > Release-Notes.html

## 转换成pdf
使用python-pisa提供的xhtml2pdf
> apt-get install python-pisa
> xhtml2pdf --html Release-Notes.html Release-Notes.pdf

## 转换中出现的编码问题
> sed -i '1i\<meta http-equiv="content-type" content="text/html; charset=UTF-8">' *.md

## Makefile
可以在文档目录下放置Makefile来自动转换过程
<pre>
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
</pre>
