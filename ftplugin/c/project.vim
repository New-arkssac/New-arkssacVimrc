source $HOME/.vim/config/libproject.vim

noremap <buffer> <CMD>call InitialzeClangPorject()<CR>
noremap <buffer><LEADER>ck <CMD>call job_start(["/bin/zsh", "-c", "ctags -R --languages=c --langmap=c:+.h --c-kinds=+z -f .tags"], {"exit_cb": "CheckCtags"})<CR>

function InitialzeClangPorject()
  if !filereadable(".vimspector.json")
    let l:makemasseage = system("cp $HOME/.vim/Example/vimspector-c.json `pwd`/.vimspector.json")
    if strlen(l:makemasseage) != 0
      call Pop_Warning(l:makemasseage)
    endif
  endif

  call Pop_Done("Clang Initialzetion Finish")
endfunction

" function Commentary()
  " normal! I// 
" endfunction
" 
" function UnCommentary()
  " normal! I
  " normal! 3dl
" endfunction