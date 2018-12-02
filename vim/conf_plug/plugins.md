## 插件管理工具

### vundle

项目地址: <https://github.com/VundleVim/Vundle.vim.git> <br/>

```
默认情况下, Vundle从github.com或vim-scripts.org下载并安装vim插件
github安装: Plugin 'user/plugin'
vim-scripts安装: Plugin 'plugin_name'
从另一个git软件库安装: Plugin 'git://git.another_repo.com/plugin'
从本地文件进行安装: Plugin 'file:///home/user/path/to/plugin'
从不是~/.vim的另一个目录安装插件: Plugin 'rstacruz/sparkup', {'rtp':'another_vim_path/'}
插件重命名: Plugin 'user/plugin',{'name':'newPlugin'}
```

1. 安装一个插件
```
在VIM的配置文件中加一句 Plugin 'your/script/path'
在VIM中运行 :PluginInstall
```
2. 卸载一个插件
```
去除配置文件中的 Plugin 'your/script/name'
在VIM中运行 :PluginClean
```
3. 更新插件
```
:PluginUpdate
:PluginList  //列举出配置的所有插件
:PluginInstall!  //更新列表中所有插件
:PluginSearch foo  //查找foo插件
:PluginSearch! foo  //刷新foo插件缓存
```

## 优秀插件推荐

### ctrlp.vim, 文件模糊搜索

项目地址: <https://github.com/kien/ctrlp.vim> <br/>

当你想打开某个文件时, 按下 Ctrl+p 快捷键, 输入文件名, 所有和这个文件名匹配的文件都会被按照优先级列出来, <br/>
按下Enter或Ctrl+t就可以在当前buffer或者新tab页打开你要的文件 <br/>

```
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlP'
" 设置过滤不进行查找的后缀名
let g:ctrlp_custom_ignore='\v[\/]\.(git|hg|svn|pyc)$'
```

### YouCompleteMe(YCM), 自动补全

项目地址: <https://github.com/Valloric/YouCompleteMe> <br/>

```
" 设置跳转到方法/函数定义的快捷键
nnoremap <leader>j :YcmCompleter GoToDefinitionElseDeclaration<CR>
" 触发补全快捷键
let g:ycm_key_list_select_completion = ['<TAB>', '<c-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<c-p>', '<Up>']
let g:ycm_auto_trigger = 1
" 最小自动触发补全的字符大小设置为 3
let g:ycm_min_num_of_chars_for_completion = 3
" YCM的previw窗口比较恼人, 还是关闭比较好
set completeopt-=preview
```

### vim-airline, 状态条加强

项目地址: <https://github.com/bling/vim-airline> <br/>

默认情况下, airline使用ASCII字符来作为状态条的分隔符 <br/>
可以安装字体（https://github.com/powerline/fonts）并在.vimrc中设置 <br/>
```
let g:airline_powerline_fonts=1
```

### tagbar, 代码分析

项目地址: <https://github.com/majutsushi/tagbar> <br/>

快速了解当前文件的结构, 并让你可以在各个内容之间快速跳转 <br/>

设置: 按F8打开当前文件的预览窗口 <br/>
```
nmap <F8> :TagbarToggle<CR> 
```

### NERD Tree, 文件浏览

项目地址: <https://github.com/scrooloose/nerdtree> <br/>

<http://www.vim.org/scripts/script.php?script_id=1658>
<pre>
快捷键: 
1）通过hjkl移动光标
2）o打开关闭文件或目录, 如果想打开文件, 必须光标移动到文件名
3）t在标签页中打开
4）s和i可以水平或纵向分割窗口打开文件
5）p到上层目录
6）P到根目录
7）K到同目录第一个节点
8）P到同目录最后一个节点
</pre>

```
nmap <F5> :NERDTreeToggle<CR> 
```
### spf13
