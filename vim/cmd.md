## vim修改时发现没有写入权限
<pre>
1. 使用 :w newname 方式另存为新文件

2. :w !sudo tee % > /dev/null

:w !<cmd>用于将当前缓冲区内容作为标准输入送给cmd命令
比如:w !sh就是将缓冲区的每一行视为shell命令然后执行
:r !<cmd>用于将<cmd>命令的执行结果读入到当前缓冲区
比如:r !date就是将当前时间写入到当前行

%是vim中保存当前文件路径名的专用寄存器,在命令行下会自动替换为完整路径
:w !sudo tee %实际就能借助tee命令保存文件内容了,但tee命令还有标准输出,为了避免重复,将其丢弃,即/dev/null
</pre>

## 命令模式下一些有用的命令
<pre>
1. :help key-notation 查看帮助文件

2. :map 键盘映射

:map <F5> i{ea}<Esc>  通过F5键将单词用花括号括起来
i{将插入字符{, 然后用e移到单词结尾, a}增加字符}, 最后使用Esc退回

-----------------------------------------------------------------------
map \M <Esc>:set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>

map \m <Esc>:set expandtab tabstop=2 shiftwidth=2<CR>

map \t <Esc>:set expandtab tabstop=4 shiftwidth=4<CR>
map \T <Esc>:set expandtab tabstop=8 shiftwidth=8<CR>
------------------------------------------------------------------------

3. 匹配
:g/pattern/d  删除包含特定字符的行
:v/pattern/d  或者  :g!/pattern/d  删除不包含指定字符的行
</pre>

## 移除不需要的空行
<pre>
1. 移除空行
:g/^$/d
:v/./d
2. 移除空行以及只有空格的行(空格, tab)
:g/^\s*$/d
:v/\S/d
3. 将多个空行替换成一个空行
:v/\S/,/\S/-j
:%s/\s\+$//e
:%s/\n{3,}/\r\r/e
The e substitute flag means that no error is displayed if the pattern is not found. \n in the search pattern finds newline, while \r in the replacement inserts a newline
4. Handing IDEOGRAPHIC SPACE
the following will delete all empty lines, or lines that comtain only combinations of space, tab or IDEOGRAPHIC SPACE(in CJK languages, the Unicode character IDEOGRAPHIC SPACE may be used. if you have 'encoding' utf-8(and do not have the 'l' flag in 'cpoptions'),you can use \u3000 in a search pattern to specify the UTF-16 hex code for IDEOGRAPHIC SPACE, :help ^])
:g/^[ \t\u3000]*$/d
an alternative procedure, which should work in other encoding, would be to enter the CJK space directly into the pattern. that is, you would type the following, but instead of '#' youwould enter a CJK space
:g/^ \t#]*$/d
</pre>

## 查找当前单词
<pre>
normal模式下按下 * 即可查找光标所在单词，按下 g* 即可查找光标所在单词的字符序列
</pre>

## 查找与替换(substitude)
<pre>
:{作用范围}s/{目标}/{替换}/{替换标志}
如:%s/foo/bar/g  在全局范围(%)查找(foo)并替换为(bar),所有出现都会被替换(g)
1. 作用范围
 当前行
:s/foo/bar/g
 全文
:%s/foo/bar/g
 选区，在Visual模式下选择区域后输入 : , Vim即可自动补全为 :'<,'>
:'<,'>s/foo/bar/g
 2-11行
:2,11s/foo/bar/g
 当前行和接下来两行
:.,+2s/foo/bar/g
2. 替换标志
 空替换标志表示只替换从光标位置开始，目标的第一次出现
:%s/foo/bar
 i表示大小写不敏感查找，I表示大小写敏感查找
:%s/foo/bar/i
等效于模式中的\c(不敏感)或\C(敏感)  :%s/foo\c/bar
 c表示要确认
:%s/foo/bar/gc
(y/n/a/q/l/^E/6Y)?  y--替换 n--不替换 a--替换所有 q--退出查找模式 
l--替换当前位置并退出 ^E和^Y是光标移动快捷键
</pre>

## 将tabs替换为空格
<pre>
1. To insert space characters whenever the tab key is pressed, set the 'expandtab' option
-- :set expandtab --
with this option set, if you want to enter a real tab character use Ctrl-V<Tab> key sequence
2. To control the number of space characters that will be inserted when the tab key is pressed, set the 'tabstop' option.
-- :set tabstop=4 --
3. After the 'expandtab' option is set, all the new tab characters entered will be changed to spaces. This will not affect the existing tab characters. To change all the existing tab characters to match the current tab settings, use:
-- :retab --   (global)
-- :.retab --  (current line)
4. To change the number of space characters inserted for indentation, use the 'shiftwidth' option
-- :set shiftwidth=4 --

1. To turn off expandtab for editing makefiles, put the following in your vimrc
-- autocmd FileType make setlocal noexpandtab --
2. To use this mode only for Python add the following to your vimrc
-- autocmd FileType * set tabstop=2 | set shiftwidth=2 | set noexpandtab --
-- autocmd FileType python set tabstop=4 | set shiftwidth=4 | set expandtab --
3. for Python
autocmd BufEnter *.py set ai sw=4 ts=4 sta et fo=croql
4. makes the spaces feel like real tabs
-- set softtabstop=4 --
This makes the backspace key treat the four spaces like a tab
</pre>
