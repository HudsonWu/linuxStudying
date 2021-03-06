# 命令模式

## tips and tricks

```
# 进入paste模式
:set paste
# 退出paste模式
:set nopaste

# 用空格替换tab
:set expandtab
# 取消空格替换tab
:set expandtab!
```

## vim 全局命令 g

当想要在整个文件中对于匹配的行或者不匹配的行进行一些操作时, 应该第一时间想到`:g`命令

```
:[range]global[!]/{pattern}/{command}

:[range]g/pattern/command
```

+ [range], 指定文本范围, 默认为整个文档
+ pattern, 在范围range内的行如果匹配pattern, 则执行command
+ !, 表示取反, 也就是不匹配的行, 也可以使用`vglobal`
+ command, 执行Ex command, 默认是打印文本, 可以使用`:help ex-cmd`来查看

常用的Ex command:
+ d, 删除
+ m, 移动
+ t, 拷贝
+ s, 替换

```
:20,200g/^/pu _    //在20行到200行之间, 每一行下插入空行
:g/pattern/d    //删除匹配的行
:g!/pattern/d   //删除不匹配的行
:v/pattern/d    //删除不匹配的行, :v是:inverse的缩写
```

vim在删除时, 会先把要删除的内容放到寄存器中, 如果没有指定寄存器, 会默认放到一个未命名的寄存器中, 对于要删除大量匹配行的行为, 可能导致vim花一些时间处理这些拷贝, 避免花费不必要的时间可以指定一个blackhole寄存器`_`
```
:g/pattern/d_
```

```
:g/pattern/m$   //将所有匹配的行移动到文件末尾
:g/pattern/t$   //将所有匹配的行复制到文件末尾
```

vim每个字母都是一个寄存器, 所以使用全局命令也可以将内容复制到某一个寄存器
```
qaq:g/pattern/y A
```
+ `qaq`, 清空寄存器a, `qa`开始记录命令到a寄存器, `q`停止记录
+ `y A`, 将匹配的行A(append)追加到寄存器a中
存放到寄存器a之后, 就可以使用`"ap`来粘贴使用或其他操作

```
:g/^/m0    //`:g`命令一行行匹配, 匹配第一行时移动到文件顶部
           //匹配第二行, 将第二行移动到文件顶部
           //跑完一遍后, 整个文件的每一行就反转了

:g/pattern/s/$/mytext   //在匹配行后添加文字, `s`, substitute
                        //可以使用`:help :s`查看帮助信息
```

## 查找与替换(substitude)

### 查找当前单词

normal模式下按下 `*` 即可查找光标所在单词, 按下 `g*` 即可查找光标所在单词的字符序列

### 查找后替换

```
:{作用范围}s/{目标}/{替换}/{替换标志}

:%s/foo/bar/g    //在全局范围(%)查找foo并替换为bar,所有出现都会被替换(g)
```

#### 作用范围

```
//当前行
:s/foo/bar/g

//全文
:%s/foo/bar/g

//选区, 在Visual模式下选择区域后输入 : , Vim即可自动补全为 :'<,'>
:'<,'>s/foo/bar/g

//2-11行
:2,11s/foo/bar/g

//当前行和接下来两行
:.,+2s/foo/bar/g

//2到最后一行
:2,$s/blob//g
```

#### 替换标志

+ 空替换标志表示只替换从光标位置开始, 目标的第一次出现
```
:%s/foo/bar
```
+ `i`表示大小写不敏感查找, `I`表示大小写敏感查找
```
:%s/foo/bar/i
:%s/foo\c/bar   //等效于模式中的\c(不敏感)或\C(敏感)
```
+ c表示要确认
```
:%s/foo/bar/gc
//(y/n/a/q/l/^E/^Y)?  y--替换 n--不替换 a--替换所有 q--退出查找模式 
//l--替换当前位置并退出 ^E和^Y是光标移动快捷键
```

## 其他一些用法
 
1. :help key-notation

2. :map 键盘映射

:map <F5> i{ea}<Esc>  通过F5键将单词用花括号括起来 <br/>
i{将插入字符{, 然后用e移到单词结尾, a}增加字符}, 最后使用Esc退回 <br/>

```
map \M <Esc>:set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>

map \m <Esc>:set expandtab tabstop=2 shiftwidth=2<CR>

map \t <Esc>:set expandtab tabstop=4 shiftwidth=4<CR>
map \T <Esc>:set expandtab tabstop=8 shiftwidth=8<CR>
```

3. wildmenu

```
set wildmenu wildmode=longest:full,full
```
What it does:
+ First tab: longest match, list in the statusbar
+ Following tabs: cycle through matches

## 使用实例

### vim修改时发现没有写入权限

1. 使用 :w newname 方式另存为新文件

2. :w !sudo tee % > /dev/null
```
:w !<cmd>用于将当前缓冲区内容作为标准输入送给cmd命令
比如:w !sh就是将缓冲区的每一行视为shell命令然后执行
:r !<cmd>用于将<cmd>命令的执行结果读入到当前缓冲区
比如:r !date就是将当前时间写入到当前行

%是vim中保存当前文件路径名的专用寄存器,在命令行下会自动替换为完整路径
:w !sudo tee %实际就能借助tee命令保存文件内容了,但tee命令还有标准输出,为了避免重复,将其丢弃,即/dev/null
```

### 移除不需要的空行

1. 移除空行
```
:g/^$/d
:v/./d
```

2. 移除空行以及只有空格的行(空格, tab)
```
:g/^\s*$/d
:v/\S/d
```

3. 将多个空行替换成一个空行
```
:v/\S/,/\S/-j
:%s/\s\+$//e
:%s/\n{3,}/\r\r/e
```
The e substitute flag means that no error is displayed if the pattern is not found <br/>
\n in the search pattern finds newline, while \r in the replacement inserts a newline <br/>

4. 把空格替换为换行
```
:%s/ /\r/g
```

5. Handing IDEOGRAPHIC SPACE
the following will delete all empty lines, <br/>
or lines that contain only combinations of space, tab or IDEOGRAPHIC SPACE <br/>
(in CJK languages, the Unicode character IDEOGRAPHIC SPACE may be used. <br/>
if you have 'encoding' utf-8(and do not have the 'l' flag in 'cpoptions'), <br/>
you can use \u3000 in a search pattern to specify the UTF-16 hex code for IDEOGRAPHIC SPACE, :help ^]) <br/>
```
:g/^[ \t\u3000]*$/d
```
an alternative procedure, which should work in other encoding, <br/>
would be to enter the CJK space directly into the pattern. that is, <br/>
you would type the following, but instead of '#' youwould enter a CJK space <br/>
```
:g/^[ \t#]*$/d
```

### 将tabs替换为空格

1. To insert space characters whenever the tab key is pressed, set the 'expandtab' option
```
:set expandtab
```
with this option set, if you want to enter a real tab character use Ctrl-V<Tab> key sequence

2. To control the number of space characters that will be inserted when the tab key is pressed, set the 'tabstop' option.
```
:set tabstop=4
```

3. To change all the existing tab characters to match the current tab settings
```
//global
:retab

//current line
:.retab
```

4. To change the number of space characters inserted for indentation, use the 'shiftwidth' option
```
:set shiftwidth=4 
```

### 特定文件类型单独设置tabs

1. To turn off expandtab for editing makefiles, put the following in your vimrc
```
autocmd FileType make setlocal noexpandtab 
```

2. To use this mode only for Python, add the following to your vimrc
```
autocmd FileType * set tabstop=2 | set shiftwidth=2 | set noexpandtab 
autocmd FileType python set tabstop=4 | set shiftwidth=4 | set expandtab 
```

3. for Python
```
autocmd BufEnter *.py set ai sw=4 ts=4 sta et fo=croql
```

4. makes the spaces feel like real tabs
```
set softtabstop=4 
```
This makes the backspace key treat the four spaces like a tab

### 大小写切换

```
# 首字母大写，其他小写
## \< 代表单词的开始    \> 代表单词的结束
## \u 转换为大写    \L 转换为小写
:s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g

# \S，非空白字符
:s/\<\(\w\)\(\S*\)/\u\1\L\2/g

# \v，启用符号的特殊含义
:s#\v(\w)(\S*)/\u\1\L\2#g
```

## References

+ [vim全局命令g](https://blog.einverne.info/post/2017/10/vim-global.html)
+ [Power of g](http://vim.wikia.com/wiki/Power_of_g)
+ [大小写](https://vim.fandom.com/wiki/Switching_case_of_characters)
