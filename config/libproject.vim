nnoremap <C-l> :call Commentary()<CR>
vnoremap <C-l> :call Commentary()<CR>
nnoremap  :call UnCommentary()<CR>
vnoremap  :call UnCommentary()<CR>
inoremap <C-l> <ESC>:call Commentary()<CR>

let g:num = 1
let g:strnum = 2
let g:dnum = 0
if &filetype == "vim"
  let g:cm = "\" "
elseif &filetype == "python"
  let g:cm = "# "
elseif &filetype == "go" || &filetype == "c" || &filetype == "cpp"
  let g:cm = "// "
  let g:strnum = 3
  let g:num = 2
endif


function Pop_Warning(msg)
  let l:pop_dict = {
   \ "line": 1,
   \ "col": 200, 
   \ "minwidth": 5,
   \ "pos": "topright",
   \ "time": 10000,
   \ "highlight": "WarningMsg",
   \ "close": "click",
   \}
  call popup_notification(a:msg, l:pop_dict)
endfunction

function Pop_Done(msg)
  let l:pop_dict = {
   \ "line": 1,
   \ "col": 200, 
   \ "minwidth": 5,
   \ "time": 2000,
   \ "pos": "topright",
   \ "highlight": "Title",
   \ "close": "click",
   \}
  echom a:msg
  call popup_notification(a:msg, l:pop_dict)
endfunction

function CheckCtags(chann, msg)
  if !filereadable(".tags") || a:msg != 0
    call Pop_Warning("make .tags error")
   return
  endif
  call Pop_Done("make .tags Done")
endfunction

function Commentary()
  exec "normal! I".g:cm
endfunction

function UnCommentary()
  let l:bool = 0
  normal! I
 for i in range(5)
  if strcharpart(strpart(getline('.'),col('.')-1),i,g:strnum) == g:cm
    let l:bool = 1
    let g:dnum = i
    break
  endif
 endfor
 let g:dnum = g:dnum + g:num
 if l:bool
  exec "normal! ".g:dnum."dl"
 endif
endfunction
