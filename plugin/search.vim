
function SearchWordGeneral(sSearchWord)
	execute "hide vimgrep /". a:sSearchWord. "/j ##"
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
	let sSearchDir  = g:sProjectRoot
	let sSearchDir  = input("search in: ", sSearchDir, "dir")
	execute "silent args `find ". sSearchDir. " -type f`"
	call SearchWordGeneral(sSearchWord)
endfunction
nmap <silent> <leader>fg :call SearchWordGlobal()<CR>

"find word in directories.
function SearchWordLocal()
	let sSearchWord = input("local search: ", "\\<". expand("<cword>"). "\\>")
	let sSearchDir  = getcwd()
	let sSearchDir  = input("search in: ", sSearchDir, "dir")
	execute "silent args `find ". sSearchDir. " -type f`"
	call SearchWordGeneral(sSearchWord)
endfunction
nmap <silent> <leader>fl :call SearchWordLocal()<CR>

" find word in file
function SearchWordFile()
	let sSearchWord  = input("local search: ", "\\<". expand("<cword>"). "\\>")
	execute "silent args ". expand("%")
	call SearchWordGeneral(sSearchWord)
endfunction
nmap <silent> <leader>ft :call SearchWordFile()<CR>

