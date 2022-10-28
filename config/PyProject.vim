nnoremap <C-l> I# <ESC>
nnoremap  0<DEL><DEL>
vnoremap <C-l> I# <ESC>
inoremap <C-l> <ESC>I#<ESC>
noremap <LEADER>pip :!pip install 

noremap <LEADER>cm :call mkdir('venv')<CR>:!python3 -m venv ./venv<CR><CR>

noremap <LEADER>cj :!cp $HOME/.vim/Example/vimspector-python.json `pwd`/.vimspector.json<CR><CR>:echom CheckProjectFile(".vimspector.json")<CR>

noremap <LEADER>ck :!clear && ctags -R --languages=Python -f .tags<CR><CR>:echom CheckProjectFile(".tags")<CR>
