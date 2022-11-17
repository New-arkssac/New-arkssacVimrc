let g:asyncrun_open = 6
let g:asynctasks_term_reuse = 1
let g:asynctasks_term_focus = 0

noremap <silent><LEADER>B :AsyncTaskEdit<CR>
noremap <silent><LEADER>I :AsyncTask file-run<cr>
noremap <silent><LEADER>o :AsyncTask file-build<cr>
noremap <silent><LEADER>p :AsyncTask project-build<cr>
noremap <silent><LEADER>n :cnext<CR>
noremap <silent><LEADER>N :cprev<CR>
