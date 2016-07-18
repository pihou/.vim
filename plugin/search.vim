
function SearchWordGeneral(sSearchWord, sSearchDir)
	exe "vimgrep /". a:sSearchWord. "/j ". a:sSearchDir
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
	let sSearchWord = input("global search: ", "\\<". expand("<cword>"). "\\>")
	let sSearchDir  = g:sProjectRoot. "/**/*.py"
	let sSearchDir  = input("search in: ", sSearchDir, "dir")
	call SearchWordGeneral(sSearchWord, sSearchDir)
endfunction
nmap <silent> <leader>fg :call SearchWordGlobal()<CR>

"find word in directories.
function SearchWordLocal()
	let sSearchWord = input("local search: ", "\\<". expand("<cword>"). "\\>")
	let sSearchDir  = getcwd(). "/**/*.py"
	let sSearchDir  = input("search in: ", sSearchDir, "dir")
	call SearchWordGeneral(sSearchWord, sSearchDir)
endfunction
nmap <silent> <leader>fl :call SearchWordLocal()<CR>

" find word in file
function SearchWordFile()
	let sSearchWord = input("local search: ", "\\<". expand("<cword>"). "\\>")
	let sSearchDir  = expand("%")
	call SearchWordGeneral(sSearchWord, sSearchDir)
endfunction
nmap <silent> <leader>ft :call SearchWordFile()<CR>

