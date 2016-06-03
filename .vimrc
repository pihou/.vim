set nocompatible
syntax enable
syntax on

"通用设置
set nu              "显示行号
set ai              "自动缩进
set nowrap          "自动换行
set cursorline      "高亮当前行
set hlsearch
set incsearch
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
language message zh_CN.UTF-8

"ctags 设置
set tags=tags; "设置可递归查找tags文件
set autochdir  "设置可依据当前编辑文件切换目录

"taglist 设置
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

"winmanager 设置
let g:winManagerWindowLayout='FileExplorer|TagList'
let g:explHideFiles='.*\~$,.*\.swp$,.*\.bak$,.*\.o$'
nmap wm :WMToggle<cr>

"minibufexpl 设置
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplorerMoreThanOne = 1

"杂项设置
let mapleader=" "
nnoremap <leader>q :wqa<CR>
autocmd FileType help wincmd L

"搜索设置
let g:ackprg = 'ag --vimgrep'
function SearchWordGeneral(sSearchWord, sSearchDir)
	exe "Ack! " . a:sSearchWord . " " . a:sSearchDir
	copen
endfunction

let sDirList = split(getcwd(), '/')
let iDirDeep = len(sDirList)
for i in range(1, iDirDeep)
	let g:sProjectRoot = join(sDirList[0:i*-1], "/")
	let g:sProjectRoot = "/".g:sProjectRoot
	if filereadable(g:sProjectRoot."/_vimproject")
		break
	endif
endfor

"find word in directories.
function SearchWordGlobal()
	let sSearchWord = input("global search: ", expand("<cword>"))
	let sSearchDir  = g:sProjectRoot
	let sSearchDir  = input("search in: ", sSearchDir, "dir")
	call SearchWordGeneral(sSearchWord, sSearchDir)
endfunction
nmap <silent> fg :call SearchWordGlobal()<CR>

"find word in directories.
function SearchWordLocal()
	let sSearchWord = input("local search: ", expand("<cword>"))
	let sSearchDir  = getcwd()
	let sSearchDir  = input("search in: ", sSearchDir, "dir")
	call SearchWordGeneral(sSearchWord, sSearchDir)
endfunction
nmap <silent> fl :call SearchWordLocal()<CR>

" find word in file
function SearchWordFile()
	let sSearchWord = input("local search: ", "\\<" . expand("<cword>") ."\\>")
	let sSearchDir = expand("%")
	call SearchWordGeneral(sSearchWord, sSearchDir)
endfunction
nmap <silent> ft :call SearchWordFile()<CR>

