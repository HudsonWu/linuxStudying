1. 文件模糊搜索：ctrlp.vim
项目地址: https://github.com/kien/ctrlp.vim
使用：当你想打开某个文件时，按下 Ctrl+p 快捷键，输入文件名，所有和这个文件名匹配的文件都会被按照优先级列出来，按下enter或Ctrl+t就可以在当前buffer或者新tab页打开你要的文件
配置：
-------------------------------------------------------
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlP'
" 设置过滤不进行查找的后缀名
let g:ctrlp_custom_ignore='\v[\/]\.(git|hg|svn|pyc)$'
-------------------------------------------------------

2. 自动补全： YouCompleteMe(YCM)
项目地址：https://github.com/Valloric/YouCompleteMe
配置：
-----------------------------------------------------------------------
" 设置跳转到方法/函数定义的快捷键
nnoremap <leader>j :YcmCompleter GoToDefinitionElseDeclaration<CR>
" 触发补全快捷键
let g:ycm_key_list_select_completion = ['<TAB>', '<c-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<c-p>', '<Up>']
let g:ycm_auto_trigger = 1
" 最小自动触发补全的字符大小设置为 3
let g:ycm_min_num_of_chars_for_completion = 3
" YCM的previw窗口比较恼人，还是关闭比较好
set completeopt-=preview
------------------------------------------------------------------------

3. 状态条加强：vim-airline
项目地址：https://github.com/bling/vim-airline
默认情况下，airline使用ASCII字符来作为状态条的分隔符
可以安装字体（https://github.com/powerline/fonts）并在.vimrc中设置：
-- let g:airline_powerline_fonts=1 --

4. 代码分析：tagbar
项目地址：https://github.com/majutsushi/tagbar
使用：快速了解当前文件的结构，并让你可以在各个内容之间快速跳转
设置：按F8打开当前文件的预览窗口
-- nmap <F8> :TagbarToggle<CR> --

5. 文件浏览：NERD Tree
项目地址：https://github.com/scrooloose/nerdtree
http://www.vim.org/scripts/script.php?script_id=1658
快捷键：
1）通过hjkl移动光标
2）o打开关闭文件或目录，如果想打开文件，必须光标移动到文件名
3）t在标签页中打开
4）s和i可以水平或纵向分割窗口打开文件
5）p到上层目录
6）P到根目录
7）K到同目录第一个节点
8）P到同目录最后一个节点
配置：
-- nmap <F5> :NERDTreeToggle<CR> --

