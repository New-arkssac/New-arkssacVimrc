source $HOME/.config/nvim/config/libproject.vim

noremap <buffer> <CMD>call InitialzeClangPorject()<CR>
noremap <buffer><LEADER>ck <CMD>call jobstart(["/bin/zsh", "-c", "ctags -R --languages=c --langmap=c:+.h --c-kinds=+z -f .tags"], {"on_exit": "CheckCtags"})<CR>

function InitialzeClangPorject()
  if !filereadable(".vimspector.json")
    let l:makemasseage = system("cp $HOME/.config/nvim/Example/vimspector-c.json `pwd`/.vimspector.json")
    if strlen(l:makemasseage) != 0
      call Pop_Warning(l:makemasseage)
    endif
  else
      call Pop_Done("Set Debug Finish")
  endif
endfunction

