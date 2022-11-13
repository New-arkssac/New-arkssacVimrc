nnoremap <C-l> :call Commentary()<CR>
vnoremap <C-l> :call Commentary()<CR>
nnoremap  :call UnCommentary()<CR>
vnoremap  :call UnCommentary()<CR>
inoremap <C-l> <ESC>:call Commentary()<CR>

let s:list = []
let g:job_option = {}
let s:stderr = []
let s:stdout = []

let g:num = 1
let g:strnum = 2
let g:dnum = 0
if &filetype == "vim"
  let g:cm = "\" "
elseif &filetype == "python"
  let g:cm = "# "
elseif &filetype == "lua"
  let g:cm = "-- "
  let g:strnum = 3
  let g:num = 2
elseif &filetype == "go" || &filetype == "c" || &filetype == "cpp"
  let g:cm = "// "
  let g:strnum = 3
  let g:num = 2
endif

function Pop_Warning(msg)
    let message = "[WARNING] ".a:msg
    let buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(buf, 0, -1, v:true, [message])
    let opts = {
        \ 'relative': 'win',
        \ 'width': strlen(message),
        \ 'height': 1,
        \ 'col': 200 - strlen(a:msg),
        \ 'row': 0+len(s:list),
        \ 'anchor': 'NW',
        \ 'style': 'minimal'
        \}
    let win = nvim_open_win(buf, 0, opts)
    hi def MyWarning ctermfg=red ctermbg=237
    call nvim_win_set_option(win, 'winhl', 'Normal:MyWarning')

    call add(s:list, win)
    call timer_start(3000, "Close_Pop", {"repeat": 1})
endfunction

function Pop_Done(msg)
    let message = "[INFO] ".a:msg
    let buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(buf, 0, -1, v:true, [message])
    let opts = {'relative': 'win', 'width': strlen(message), 'height': 1, 'col': 200 - strlen(a:msg),
        \ 'row': 0+len(s:list), 'anchor': 'NW', 'style': 'minimal'}
    let win = nvim_open_win(buf, 0, opts)
    hi def MyDone ctermfg=green ctermbg=237
    call nvim_win_set_option(win, 'winhl', 'Normal:MyDone')
    call add(s:list, win)
    call timer_start(3000, "Close_Pop", {"repeat": 1})
endfunction

function Close_Pop(timer)
    call timer_info(a:timer)
    call nvim_win_close(s:list[0], v:true)
    call remove(s:list, 0)
endfunction

function g:job_option.on_stderr(chan_id, data, event) abort
   call extend(s:stderr, a:data)
endfunction

function g:job_option.on_stdout(chan_id, data, event) abort
   call extend(s:stdout, a:data)
endfunction

function g:job_option.on_exit(chan_id, data, event) abort
    if a:data != 0
        for msg in s:stderr
            call Pop_Warning(msg)
            call remove(s:stderr, 0)
        endfor
    elseif !empty(s:stdout)
        for msg in s:stderr
            call Pop_Done(msg)
            call remove(s:stdout, 0)
        endfor
    else
        call Pop_Done("make .tags Finish")
    endif
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
