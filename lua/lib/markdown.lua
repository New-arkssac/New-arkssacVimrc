-- vim.g.mkdp_browser = 'chromium'
-- vim.g.mkdp_page_title = '「${name}」'
-- vim.g.mkdp_filetypes = { 'markdown', "vimwiki" }
-- vim.g.mkdp_theme = 'dark'
-- vim.g.mkdp_auto_start = 1
-- vim.g.mkdp_auto_close = 0
-- vim.g.mkdp_command_for_global = 1
O.addOpt {
  { "g", "mkdp_browser", "chrome" },
  { "g", "mkdp_page_title", "「${name}」" },
  { "g", "mkdp_filetypes", { 'markdown', "vimwiki" } },
  { "g", "mkdp_theme", 'dark' },
  { "g", "mkdp_auto_start", 1 },
  { "g", "mkdp_auto_close", 0 },
  { "g", "mkdp_command_for_global", 1 }
}

-- autocmd Filetype markdown inoremap <buffer> ,w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
-- autocmd Filetype markdown inoremap <buffer> ,n ---<Enter><Enter>
-- autocmd Filetype vimwiki inoremap <buffer> ,b  * <++>* <CR>:n,ohlsearch<CR>"_c4l
vim.cmd [[
autocmd Filetype markdown inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
autocmd Filetype markdown inoremap <buffer> ,b **** <++><Esc>F*hi
autocmd Filetype markdown inoremap <buffer> ,m ~~~~ <++><Esc>F~hi
autocmd Filetype markdown inoremap <buffer> ,i ** <++><Esc>F*i
autocmd Filetype markdown inoremap <buffer> ,x `` <++><Esc>F`i
autocmd Filetype markdown inoremap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown inoremap <buffer> ,h - [ ]  <Enter><++><ESC>kA
autocmd Filetype markdown inoremap <buffer> ,j * [ ]  <Enter><++><ESC>kA
autocmd Filetype markdown inoremap <buffer> ,s ![](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> ,a [](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> ,1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,4 ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,5 #####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,l --------<Enter>
autocmd Filetype vimwiki inoremap <buffer> ,va = <++>=<CR>:nohlsearch<CR>"_c4l
autocmd Filetype vimwiki inoremap <buffer> ,vs == <++>==<CR>:nohlsearch<CR>"_c4l
autocmd Filetype vimwiki inoremap <buffer> ,vd === <++>===<CR>:nohlsearch<CR>"_c4l
]]
