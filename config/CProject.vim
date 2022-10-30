nnoremap <C-l> I// <ESC>
nnoremap  I<DEL><DEL><ESC>
inoremap <C-l> <ESC>I//<ESC>

noremap <buffer> <CMD>echom InitialzeClangPorject()<CR>
noremap <buffer><LEADER>ck <CMD>call job_start(["/bin/zsh", "-c", "ctags -R --languages=c --langmap=c:+.h --c-kinds=+z -f .tags"], {"exit_cb": "CheckCtags"})<CR>

function InitialzeClangPorject()
  if !filereadable(".vimspector.json")
    let l:makemasseage = system("cp $HOME/.vim/Example/vimspector-c.json `pwd`/.vimspector.json")
    if strlen(l:makemasseage) != 0
      return l:makemasseage
    endif
  endif

  return "Clang Initialzetion Finish"
endfunction
