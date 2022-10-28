  noremap <LEADER>cj :!cp $HOME/.vim/Example/vimspector-c.json `pwd`/.vimspector.json<CR><CR>:echom CheckProjectFile(".vimspector.json")<CR>

  noremap <LEADER>ck :!clear && ctags -R --languages=c --langmap=c:+.h --c-kinds=+z -f .tags<CR><CR>
        \:echom CheckProjectFile(".tags")<CR>
