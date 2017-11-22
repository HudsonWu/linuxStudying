runtime! debian.vim

" 不使用代码折叠功能
set nofoldenable
" 不使用swapfile
set noswapfile
" 设置编码格式
set encoding=utf-8
" 去掉vi一致性模式
set nocompatible
" 语法高亮
syntax on
" 显示行号
set number
" 检测文件类型
filetype on
" 记录历史的行数
set history=1000
" 背景使用黑色
set background=dark
" 自动对齐
set autoindent
" 智能对齐
set smartindent
" tab键位4个空格
set tabstop=4
" 当行之间交错时使用4个空格
set shiftwidth=4
" 设置匹配模式
set showmatch
" 去除vim的GUI版本中的toolbar
set guioptions=T
" 在右下角显示光标位置的状态行
set ruler
" 默认寻找匹配是高亮度显示的，关闭高亮显示
set nohls
" 查询时快速找到答案
set incsearch
" 设定编码类型，解决中文编码问题
let &termencoding=&encoding
set fileencodings=utf-8,gbk,ucs-bom,cp936
" 设置默认进行大小写不敏感查找
set ignorecase
" 如果有一个大写字母，则切换到大小写敏感查找
set smartcase
" 当光标一段时间保持不动了，就禁用搜索高亮
autocmd cursorhold * set nohlsearch
" 当输入查找命令时，再启用高亮
noremap n :set hlsearch<cr>n
noremap N :set hlsearch<cr>N
noremap / :set hlsearch<cr>/
noremap ? :set hlsearch<cr>?
noremap * *:set hlsearch<cr>

if has('mouse')
	set mouse-=a
endif

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

