source $HOME/.vim/config/libproject.vim

noremap <buffer> <CMD>call InitialzeGoProject()<CR>
noremap <buffer><LEADER>ck <CMD>call job_start(["/bin/zsh", "-c", "ctags -R -f .tags"], {"exit_cb": "CheckCtags"})<CR>
noremap <buffer><LEADER>cg :term go get -u 
noremap <buffer><LEADER>cd :term go mod download 
noremap <buffer><LEADER>c, :term go mod tidy<CR><CR>

function InitialzeGoProject()
  if !filereadable(".vimspector.json")
    let l:messages = system("cp $HOME/.vim/Example/vimspector-go.json `pwd`/.vimspector.json")
    if strlen(l:messages) != 0
      call Pop_Waring(l:messages)
      return
    endif
  endif

  let l:mod = system("go mod init ".system("basename `pwd`"))
  if stridx(l:mod, "go.mod already exists") >= 0
    call Pop_Waring("go.mod already exists")
    return  
  elseif stridx(l:mod, "go mod cannot determine module path for source directory") >= 0
    call Pop_Warning("go mod cannot determine module path for source directory")
    return
  endif

  call Pop_Done("Go Initialzetion Procject Finish")
endfunction

" function Commentary()
  " normal! I// 
" endfunction
" 
" function UnCommentary()
  " normal! I
  " normal! 3dl
" endfunction
" 
