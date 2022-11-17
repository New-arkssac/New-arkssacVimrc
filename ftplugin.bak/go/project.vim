source $HOME/.config/nvim/config/libproject.vim

noremap <buffer> <CMD>call InitialzeGoProject()<CR>
noremap <buffer><LEADER>ck <CMD>call jobstart(["/bin/zsh", "-c", "ctags -R -f .tags"], g:job_option)<CR>
noremap <buffer><LEADER>cg :term go get -u 
noremap <buffer><LEADER>cd :term go mod download 
noremap <buffer><LEADER>c, :term go mod tidy<CR><CR>

function InitialzeGoProject()
    if !filereadable(".vimspector.json")
        let l:messages = system("cp $HOME/.config/nvim/Example/vimspector-go.json `pwd`/.vimspector.json")
        if strlen(l:messages) != 0
            call Pop_Warning(l:messages)
            return
        endif
        call Pop_Done("Set Debug finish")
    endif

    let l:mod = system("go mod init ".system("basename `pwd`"))
        if stridx(l:mod, "go.mod already exists") >= 0
        call Pop_Warning("go.mod already exists")
        return  
    elseif stridx(l:mod, "go mod cannot determine module path for source directory") >= 0
        call Pop_Warning("go mod cannot determine module path for source directory")
        return
    else
        call Pop_Done("Go mod finish")
    endif
endfunction

