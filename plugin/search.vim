
function SearchWordGeneral(sSearchWord,sSearchFile)
	execute "silent vimgrep /". a:sSearchWord. "/j ". a:sSearchFile
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
	let g:sSearchWord  = input("global search: ", "\\<". expand("<cword>"). "\\>")
	let sSearchDir     = g:sProjectRoot
	let g:sSearchDir   = input("search in: ", sSearchDir, "dir"). "/**/*". expand("%:e")
	let search_files   = glob(g:sSearchDir)
	let g:sSearchFiles = split(search_files, "\n")
	let search_files   = join(g:sSearchFiles, " ")
	call SearchWordGeneral(g:sSearchWord,search_files)
endfunction
nmap <silent> <leader>fg :call SearchWordGlobal()<CR>

"find word in directories.
function SearchWordLocal()
	let g:sSearchWord  = input("local search: ", "\\<". expand("<cword>"). "\\>")
	let g:sSearchDir   = getcwd()
	let g:sSearchDir   = input("search in: ", g:sSearchDir, "dir"). "/**/*". expand("%:e")
	let search_files   = glob(g:sSearchDir)
	let g:sSearchFiles = split(search_files, "\n")
	let search_files   = join(g:sSearchFiles, " ")
	call SearchWordGeneral(g:sSearchWord,search_files)
endfunction
nmap <silent> <leader>fl :call SearchWordLocal()<CR>

" find word in file
function SearchWordFile()
	let g:sSearchWord  = input("local search: ", "\\<". expand("<cword>"). "\\>")
	call SearchWordGeneral(g:sSearchWord,expand("%"))
endfunction
nmap <silent> <leader>ft :call SearchWordFile()<CR>

