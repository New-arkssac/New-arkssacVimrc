noremap <LEADER>pip :!pip install 

noremap <LEADER>cm :call mkdir('venv')<CR>:!python3 -m venv ./venv<CR><CR>

noremap <LEADER>cj :edit .vimspector.json<CR>:read $HOME/.vim/Example/vimspector-python.json<CR>
      \:w<CR>:bfirst<CR>:bdelete .vimspector.json<CR>:echom CheckProjectFile(".vimspector.json")<CR>

noremap <LEADER>ck :!clear && ctags -R --languages=Python -f .tags<CR><CR>:echom CheckProjectFile(".tags")<CR>
