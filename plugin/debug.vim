
"print function name and para
function PrintFuncInfo()
	let DEFFUNC_PAT = '^\s*def\s*\(\w\+\)(\([^,]*\)[^)]*):'
	let FLAG_PAT    = 'FanPrint\[\d\+\]'
	let firstline   = search(DEFFUNC_PAT,"bnW")
	let lastline    = search(DEFFUNC_PAT,"nW")-1
	let index       = 0
	if firstline == 0
		return
	endif
    if lastline == -1
        let lastline = line('$')
    endif
	for linetext in getline(firstline, lastline)
		if match(linetext,FLAG_PAT) != -1
			let index += 1
		endif
	endfor
	let nowline   = line('.')
	let indent    = matchstr(getline('.'), '^\s*')
	let scontent  = matchlist(getline(firstline), DEFFUNC_PAT)
	let printtext = printf('%sprint ">>>>>>>> FanPrint[%d].%s", %s', indent, index, scontent[1], scontent[2])
	call append(nowline-1, printtext)
	call cursor(nowline,len(printtext))
endfunction
nmap <silent> ;pf :call PrintFuncInfo()<CR>
