  noremap <LEADER>cj :edit .vimspector.json<CR>:read $HOME/.vim/Example/vimspector-c.json<CR>
        \:w<CR>:bfirst<CR>:bdelete .vimspector.json<CR>:echom CheckProjectFile(".vimspector.json")<CR>

  noremap <LEADER>ck :!clear && ctags -R --languages=c --langmap=c:+.h --c-kinds=+z -f .tags<CR><CR>
        \:echom CheckProjectFile(".tags")<CR>
