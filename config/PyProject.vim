source $HOME/.vim/config/popup.vim
nnoremap <C-l> I# <ESC>
nnoremap  I<DEL><DEL><ESC>:w<CR>
inoremap <C-l> <ESC>I#<ESC>

noremap <buffer> <CMD>call job_start(["/bin/zsh", "-c", "mkdir venv"], {"exit_cb": 'InitialzeGoProject'})<CR>
noremap <buffer><LEADER>ck <CMD>call job_start(["/bin/zsh", "-c", "ctags -R -f .tags"], {"exit_cb": "CheckCtags"})<CR>

function InitialzeGoProject(chann, msg)
  let l:pwd = split(system("pwd"), "\n")[0]
  if !filereadable(l:pwd.".vimspector.json")
    let l:makemasseage = system("cp $HOME/.vim/Example/vimspector-python.json `pwd`/.vimspector.json")
    if strlen(l:makemasseage) != 0
      echom l:makemasseage
      return
    endif
  endif

  if !filereadable(l:pwd."/venv/bin/python")
    let l:makemasseage =  system("python3 -m venv ./venv")
    if strlen(l:makemasseage) != 0
      call Pop_Waring(l:makemasseage)
      return
    endif
  else
    call Pop_Waring("It's already initialized, don't try again'")
    return
  endif
  
  call Pop_Done("Python Initialzetion Finish")
endfunction

