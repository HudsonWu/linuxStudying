https://github.com/VundleVim/Vundle.vim.git
Vundle
安装一个插件：
1. 选好插件
2. 在VIM的配置文件中加一句 Plugin 'your/script/path'
3. 在VIM中运行 :PluginInstall
卸载一个插件：
1. 去除配置文件中的 Plugin 'your/script/name'
2. 在VIM中运行 :PluginClean
更新插件： :PluginUpdate
:PluginList  列举出配置的所有插件
:PluginInstall!  更新列表中所有插件
:PluginSearch foo  查找foo插件
:PluginSearch! foo  刷新foo插件缓存
默认情况下，Vundle从github.com或vim-scripts.org下载并安装vim插件
github安装：Plugin 'user/plugin'
vim-scripts安装：Plugin 'plugin_name'
从另一个git软件库安装：Plugin 'git://git.another_repo.com/plugin'
从本地文件进行安装：Plugin 'file:///home/user/path/to/plugin'
从不是~/.vim的另一个目录安装插件：Plugin 'rstacruz/sparkup', {'rtp':'another_vim_path/'}
更名插件：Plugin 'user/plugin',{'name':'newPlugin'}

配色方案：Solarized  Molokai
导航与搜索：
NERDTree  -file navigation
（ 快捷键绑定：map <leader>e :NERDTreeToggle<CR> ）
CtrlP  -fast file finder
Taglist  -source code browser
（ map <silent> <F9> :TlistToggle<CR> ）
Tagbar  -tag generation and navigation
（ nmap <silent> <F4> :TagbarToggle<CR> ）
Tasklist  -eclipse task list
（ map <leader>td <Plug>TaskList ）
自动补全：
YouCompleteMe  -visual assist for vim
（代码跳转快捷键定义：nnoremap <leader>jd :YcmCompleterGoToDefinitionElseDeclaration<CR> 先跳到定义，如果没找到，则跳到声明处 ）
UltiSnips  -ultimate snippets
Zen Coding  -hi-speed coding for html/css
语法：
Syntastic  -integrated syntax checking
Python-mode  -Python in VIM
（ 默认情况下，该插件已经绑定了几个快捷键
K    跳到Python doc处
<leader>r    运行当前代码
<leader>b    增加/删除断点
 ）
其它：
Tabularize  -align everything
（ 按等号、冒号、表格等来对齐文本 ）
Easymotion  -jump anywhere
（ 默认快捷键：<leader><leader>w ）
NERDCommenter  -comment++
（ 快速、批量注释与反注释）
Surround  -managing all the "'[{}]'" etc
Gundo  -time machine
（ 通常会把这句加入_vimrc: nnoremap <Leader>u :GundoToggle<CR> ）
Sessionman  -session manager
Powerline  -ultimate statusline utility
终极配置：spf13