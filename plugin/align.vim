
function GeneralAlign(sFlag)
	let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . a:sFlag . '\)'
	let indent_pat  = '^' . matchstr(getline('.'), '^\s*') . '\S'
	let firstline   = search('^\%('. indent_pat . '\)\@!','bnW') + 1
	let lastline    = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
	if lastline < 0
		let lastline = line('$')
	endif
	let max_align_col = 0
	let max_op_width  = 0
	for linetext in getline(firstline, lastline)
		let left_width = match(linetext, '\s*' . a:sFlag)
		if left_width >= 0
			let max_align_col = max([max_align_col, left_width])
			let op_width      = strlen(matchstr(linetext, a:sFlag))
			let max_op_width  = max([max_op_width, op_width+1])
		endif
	endfor
	let FORMATTER = '\=printf("%-*s%*s", max_align_col, submatch(1), max_op_width, submatch(2))'
	for linenum in range(firstline, lastline)
		let oldline = getline(linenum)
		let newline = substitute(oldline, ASSIGN_LINE, FORMATTER, "")
		call setline(linenum, newline)
	endfor
endfunction
let AssinPattern = '[-+*/%|&]\?[<>=]\@<!=[=~]\@!'
let ColonPattern = ':'
let NotePattern  = '["#]'

nmap <silent> ;= :call GeneralAlign(AssinPattern)<CR>
nmap <silent> ;: :call GeneralAlign(ColonPattern)<CR>
nmap <silent> ;# :call GeneralAlign(NotePattern)<CR>
nmap <silent> ;" :call GeneralAlign(NotePattern)<CR>

