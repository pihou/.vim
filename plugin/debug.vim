
"print function name and para
function PrintFuncInfo()
    let filetype = &filetype
    if filetype == "go"
        let DEFFUNC_PAT = '^\s*func\s*\((\s*\w\+\s*\(\w\+\)\s*)\)\?\s*\(\w\+\)(\s*\(\w*\)'
        let PRINT_FORMAT = '%sfmt.Println(">>>>>>>> FanPrint[%d].%s", %s)'
    else
	    let DEFFUNC_PAT = '^\s*def\s*\(\w\+\)(\([^,]*\)[^)]*):'
        let PRINT_FORMAT = '%sprint(">>>>>>>> FanPrint[%d].%s", %s)'
    endif

	let FLAG_PAT  = 'FanPrint\[\d\+\]'
	let firstline = search(DEFFUNC_PAT,"bnW")
	let lastline  = search(DEFFUNC_PAT,"nW")-1
	let index     = 0
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
	let nowline  = line('.')
	let indent   = matchstr(getline('.'), '^\s*')
	let scontent = matchlist(getline(firstline), DEFFUNC_PAT)

    if filetype == "go"
        if scontent[1] == ""
            let printtext = printf(PRINT_FORMAT, indent, index, scontent[3], scontent[4])
        else
            let func_flag = scontent[2].":".scontent[3]
            let printtext = printf(PRINT_FORMAT, indent, index, func_flag, scontent[4])
        endif 
    else
	    let printtext = printf(PRINT_FORMAT, indent, index, scontent[1], scontent[2])
    endif
	call append(nowline-1, printtext)
	call cursor(nowline,len(printtext))
endfunction
nmap <silent> ;pf :call PrintFuncInfo()<CR>
