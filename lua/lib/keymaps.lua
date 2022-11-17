local keymap = vim.keymap.set
local opt = { silent = true, nowait = true }
local map = { "n", "v", "x" }

keymap("n", "<A-s>k", ":e $MYVIMRC<CR>", opt) -- any time any where edit init.lua
keymap(map, ";", ":", nil) -- ; map :
keymap(map, "s", "<nop>", opt) -- s leave blank
keymap("n", "S", ":w<CR>", opt) -- S is save file
keymap("n", "Q", ":q<CR>", opt) -- Q is quit file
keymap("n", "<A-r>", ":source %<CR>", opt) -- source current file
keymap("n", "<A-k>", ":source $MYVIMRC<CR>", opt) -- source init.lua
keymap("n", "<LEADER>q", ":qa<CR>", opt) -- quit all buffer
keymap("n", "sl", ":set splitright<CR>:vsplit<CR>", opt) -- left split screen
keymap("n", "sh", ":set nosplitright<CR>:vsplit<CR>", opt) -- right split screen
keymap("n", "sk", ":set splitright<CR>:split<CR>", opt) -- up split screen
keymap("n", "sj", ":set nosplitright<CR>:split<CR>", opt) -- down split screen
keymap("n", "<LEADER>j", "<C-w>j", opt) -- cursor handoff down screen
keymap("n", "<LEADER>k", "<C-w>k", opt) -- cursor handoff up screen
keymap("n", "<LEADER>h", "<C-w>h", opt) -- cursor handoff left screen
keymap("n", "<LEADER>l", "<C-w>l", opt) -- cursor handoff right screen
keymap("n", "<LEADER>sp", ":set spell!<CR>", opt) -- open word spell check
keymap("n", "<Up>", ":res +5<CR>", opt) -- Increase the size of the up screen by 5
keymap("n", "<Down>", ":res -5<CR>", opt) -- Increase the size of the down screen by 5
keymap("n", "<Left>", ":vertical resize+5<CR>", opt) -- Increase the size of the left by 5
keymap("n", "<Right>", ":vertical resize-5<CR>", opt) -- Increase the size of the right by5
keymap("n", "st", ":tabe<CR>", opt) -- Create new tabs
keymap("n", "si", ":+tabnext<CR>", opt) -- left tabs
keymap("n", "su", ":-tabnext<CR>", opt) -- right tabs
keymap("v", "<C-c>", [["+y]], opt) -- select some string copy into clipboard
keymap("n", "<C-p>", [["+p]], opt) -- normal mod paste from clipborad
keymap("i", "<C-p>", [[<ESC>"+p]], opt) -- insert mod paste from clipborad
keymap("i", "'", [[''<left>]], opt) -- ' -> ''
keymap("i", "\"", [[""<left>]], opt) -- " -> ""
keymap("i", "(", [[()<left>]], opt) -- ( -> ()
keymap("i", "[", [[[]<left>]], opt) -- [ -> []
keymap("i", "{", [[{}<left>]], opt) -- { -> {}
keymap("n", "<LEADER><LEADER>", [[<Esc>/<++><CR>:nohlsearch<CR>"_c4l]], opt) -- Look backwards "<++>" edit it
keymap("i", ";f", [[<Esc>/<++><CR>:nohlsearch<CR>"_c4l]], opt) -- insert Look backwards "<++>" edit it
keymap("v", ">", ">gv", opt)
keymap("v", "<", "<gv", opt)
keymap("v", "p", '"_dP', opt)
keymap("n", "<LEADER>o", "<cmd>TroubleToggle<cr>")

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "StdinReadPost" }, {
    callback = function(args)
        local ft, _ = vim.filetype.match { filename = args.match, buf = args.buf }
        if ft == "go" or ft == "lua" or ft == "python" or ft == "c" or ft == "cpp" then
            local opts = { noremap = true, silent = true }
            local kmap = vim.api.nvim_buf_set_keymap
            kmap(args.buf, "n", "", ":Comm<CR>", opts)
            kmap(args.buf, "v", "", ":Comm<CR>", opts)
            kmap(args.buf, "i", "", "<ESC>:Comm<CR>", opts)
            kmap(args.buf, "n", "<A-b>", ":AsyncTaskEdit<CR>", opt)
            kmap(args.buf, "n", "<A-o>", ":AsyncTask file-run<cr>", opt)
            kmap(args.buf, "n", "<A-p>", ":AsyncTask file-build<cr>", opt)
            kmap(args.buf, "n", "<LEADER>p", ":AsyncTask project-build<cr>", opt)
            kmap(args.buf, "n", "<LEADER>n", ":cnext<CR>", opt)
            kmap(args.buf, "n", "<LEADER>N", ":cprev<CR>", opt)
            vim.cmd [[command! -range Comm :lua M.comm()]]
        end
    end
})

-- noremap <LEADER>f <Cmd>CocCommand explorer<CR>
--
-- inoremap <silent><expr> <TAB>
--     \ coc#pum#visible() ? coc#pum#next(1) :
--     \ CheckBackspace() ? "\<Tab>" :
--     \ coc#refresh()
-- inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
--
-- " Make <CR> to accept selected completion item or notify coc.nvim to format
-- " <C-g>u breaks current undo, please make your own choice.
-- inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
--                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
--
-- function! CheckBackspace() abort
--   let col = col('.') - 1
--   return !col || getline('.')[col - 1]  =~# '\s'
-- endfunction
--
-- " find <++> replace it
-- noremap <silent><LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>"_c4l
-- inoremap <silent><buffer>,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
--
-- ""coc-translator
-- nmap <Leader>t <Plug>(coc-translator-p)
-- vmap <Leader>t <Plug>(coc-translator-pv)
--
-- "" find error
-- nmap <silent><LEADER>= <Plug>(coc-diagnostic-prev)
-- nmap <silent><LEADER>- <Plug>(coc-diagnostic-next)
--
-- " GOTO code navigation.
-- " nmap <silent>gd <Plug>(coc-definition)
-- " nmap <silent>gy <Plug>(coc-type-definition)
-- " nmap <silent>gi <Plug>(coc-implementation)
-- nmap <silent>gr <Plug>(coc-references)
--
-- " Use K to show documentation in preview window.
-- nnoremap <silent><nowait><LEADER>u :call ShowDocumentation()<CR>
--
-- function! ShowDocumentation()
--   if CocAction('hasProvider', 'hover')
--     call CocActionAsync('doHover')
--   else
--     call feedkeys('K', 'in')
--   endif
-- endfunction
--
-- ""Symbol rename
-- nmap <LEADER>rn <Plug>(coc-rename)
--
-- noremap <silent><nowait><C-b> :Buffers<CR>
-- noremap <nowait><C-s> :Rg
-- noremap <silent><nowait><F1> :Helptags<CR>
--
-- "==========undotree==========
-- nnoremap <nowait><LEADER>uu :UndotreeToggle<CR>
-- if has("persistent_undo")
--    let target_path = expand('~/.config/nvim/.undodir')
--
--     " create the directory and any parent directories
--     " if the location does not exist.
--     if !isdirectory(target_path)
--         call mkdir(target_path, "p", 0700)
--     endif
--
--     let &undodir=target_path
--     set undofile
-- endif
--
-- "==========vim-gitgutter==========
-- nmap ]h <Plug>(GitGutterStageHunk)
-- nmap [h <Plug>(GitGutterUndoHunk)
-- nmap ghn :GitGutterDiffOrig<CR>
-- nmap ghp <Plug>(GitGutterPreviewHunk)
--
--
