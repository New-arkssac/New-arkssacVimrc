source $HOME/.vim/config/libproject.vim

noremap <buffer> <CMD>call job_start(["/bin/zsh", "-c", "mkdir venv"], {"exit_cb": 'InitialzeGoProject'})<CR>
noremap <buffer><LEADER>ck <CMD>call job_start(["/bin/zsh", "-c", "ctags -R -f .tags"], {"exit_cb": "CheckCtags"})<CR>

function InitialzeGoProject(chann, msg)
  let l:pwd = split(system("pwd"), "\n")[0]
  if !filereadable(l:pwd.".vimspector.json")
    let l:makemasseage = system("cp $HOME/.vim/Example/vimspector-python.json `pwd`/.vimspector.json")
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
      call Pop_Done("Venv initialized Finish")
    endif
    let l:makemasseage =  system("./venv/bin/pip install yapf")
    if stridx(l:makemasseage, "ERROR") >= 0
      call Pop_Warning(l:makemasseage)
      return
    else
      call Pop_Done("Venv install yapf Finish")
    endif
  else
    call Pop_Warning("It's already initialized, don't try again'")
    return
  endif
endfunction

