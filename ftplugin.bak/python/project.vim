source $HOME/.config/nvim/config/libproject.vim

noremap <buffer> <CMD>call jobstart(["/bin/zsh", "-c", "mkdir venv"], {"on_exit": "InitialzeGoProject")<CR>
noremap <buffer><LEADER>ck <CMD>call jobstart(["/bin/zsh", "-c", "ctags -R -f .tags"], g:job_option)<CR>


function InitialzeGoProject()
  let l:pwd = split(system("pwd"), "\n")[0]
  if !filereadable(l:pwd.".vimspector.json")
    let l:makemasseage = system("cp $HOME/.config/nvim/Example/vimspector-python.json `pwd`/.vimspector.json")
    if strlen(l:makemasseage) != 0
      call Pop_Warning(l:makemasseage)
      return
    endif
  else
      call Pop_Done("Set Debug Finish")
  endif

  if !filereadable(l:pwd."/venv/bin/python")
    let l:makemasseage =  system("python3 -m venv ./venv")
    if strlen(l:makemasseage) != 0
        call Pop_Waring(l:makemasseage)
      return
    else
      call Pop_Done("[INFO] venv initialized Finish")
    endif
    let l:makemasseage =  system("./venv/bin/pip install yapf")
    if stridx(l:makemasseage, "ERROR") >= 0
      call Pop_Warning(l:makemasseage)
      return
    else
      call Pop_Done("venv project install yapf Finish")
    endif
  else
    call Pop_Warning("It's already initialized, don't try again'")
    return
  endif
endfunction

