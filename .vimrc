set nocompatible
syntax enable
syntax on

"通用设置
set nu              "显示行号
set ai              "自动缩进
set nowrap          "自动换行
set autoindent      "换行自动缩进
set hlsearch
set incsearch
set expandtab
set backspace=2
set guioptions-=m
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guifont=Courier_new:h11:cANSI
set shiftwidth=4 tabstop=4 softtabstop=4
set gcr=a:block-blinkon0
au GUIEnter * simalt ~x 
hi normal guibg=#C7EDCC

"编码设置
set encoding=UTF-8
set langmenu=utf-8
set fileencodings=UTF-8,gbk,gb18030
"language message zh_CN.UTF-8

"ctags 设置
set tags=tags; "设置可递归查找tags文件
set autochdir  "设置可依据当前编辑文件切换目录

"taglist 设置
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Ctags_Cmd='/usr/local/bin/gotags'

"nedtree tagbar 设置
nmap nt :NERDTreeToggle<CR>
nmap tb :TagbarToggle<CR>

"minibufexpl 设置
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplorerMoreThanOne = 1

"杂项设置
let mapleader=" "
nnoremap <leader>q :wqa<CR>
autocmd FileType help wincmd L
map <leader>r :NERDTreeFind<cr>

"tmux兼容设置
set mouse+=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

filetype plugin indent on

" ==================== python ====================
augroup python
  autocmd!
  autocmd FileType python nnoremap <leader>= :0,$!yapf<CR>
augroup END

" ==================== vim-go ====================
"augroup go
"  autocmd!
"  autocmd FileType go nmap <silent> <Leader>d <Plug>(go-def)
"augroup END

