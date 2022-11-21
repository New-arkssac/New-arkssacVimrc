local keymap = vim.keymap.set
local opt = { silent = true, nowait = true }
local map = { "n", "v", "x" }

keymap(map, ";", ":", nil) -- ; map :
keymap(map, "s", "<nop>", opt) -- s leave blank
keymap("n", "S", ":w<CR>", opt) -- S is save file
keymap("n", "Q", ":q<CR>", opt) -- Q is quit file
keymap("n", "<A-r>", ":source % | nohlsearch <CR>", opt) -- source current file
keymap("n", "<A-s>k", ":e $MYVIMRC<CR>", opt) -- any time any where edit init.lua
keymap("n", "sr", ":source $MYVIMRC<CR>", opt) -- source init.lua
keymap("n", "sl", ":set splitright<CR>:vsplit<CR>", opt) -- left split screen
keymap("n", "sh", ":set nosplitright<CR>:vsplit<CR>", opt) -- right split screen
keymap("n", "sk", ":set splitright<CR>:split<CR>", opt) -- up split screen
keymap("n", "sj", ":set nosplitright<CR>:split<CR>", opt) -- down split screen
keymap("n", "st", ":tabe<CR>", opt) -- Create new tabs
keymap("n", "si", ":+tabnext<CR>", opt) -- left tabs
keymap("n", "su", ":-tabnext<CR>", opt) -- right tabs
keymap("n", "<LEADER>q", ":qa<CR>", opt) -- quit all buffer
keymap("n", "<LEADER>j", "<C-w>j", opt) -- cursor handoff down screen
keymap("n", "<LEADER>k", "<C-w>k", opt) -- cursor handoff up screen
keymap("n", "<LEADER>h", "<C-w>h", opt) -- cursor handoff left screen
keymap("n", "<LEADER>l", "<C-w>l", opt) -- cursor handoff right screen
keymap("n", "<LEADER>o", "<CMD>TroubleToggle<cr>")
keymap(map, "<LEADER>t", "<CMD>TranslateW<CR>")
keymap("n", "<LEADER>b", "<CMD>Buffers<CR>")
keymap("n", "<LEADER>r", "<CMD>Rg<CR>")
keymap("n", "<LEADER>m", "<CMD>Vista!!<CR>")
keymap("n", "<LEADER>sp", ":set spell!<CR>", opt) -- open word spell check
keymap("n", "<LEADER>uu", ":NvimTreeClose<CR>:UndotreeToggle<CR>")
keymap("n", "<Up>", ":res +5<CR>", opt) -- Increase the size of the up screen by 5
keymap("n", "<Down>", ":res -5<CR>", opt) -- Increase the size of the down screen by 5
keymap("n", "<Left>", ":vertical resize+5<CR>", opt) -- Increase the size of the left by 5
keymap("n", "<Right>", ":vertical resize-5<CR>", opt) -- Increase the size of the right by5
keymap("v", "<C-c>", [["+y]], opt) -- select some string copy into clipboard
keymap("n", "<C-p>", [["+p]], opt) -- normal mod paste from clipborad
keymap("i", "<C-p>", [[<ESC>"+p]], opt) -- insert mod paste from clipborad
keymap("v", ">", ">gv", opt)
keymap("v", "<", "<gv", opt)
keymap("v", "p", '"_dP', opt)
-- keymap("i", "'", [[''<left>]], opt) -- ' -> ''
-- keymap("i", "\"", [[""<left>]], opt) -- " -> ""
-- keymap("i", "(", [[()<left>]], opt) -- ( -> ()
-- keymap("i", "[", [[[]<left>]], opt) -- [ -> []
-- keymap("i", "{", [[{}<left>]], opt) -- { -> {}

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    callback = function(args)
        local ft, _ = vim.filetype.match { filename = args.match, buf = args.buf }
        local opts = { noremap = true, silent = true }
        local kmap = vim.api.nvim_buf_set_keymap
        if ft == "go" or ft == "lua" or ft == "vim" or ft == "python" or ft == "c" or ft == "cpp" then
            vim.cmd [[command! -range Comm :lua M.comm()]]
            vim.cmd [[command! ProjectInitialization :lua P:projectInitialization()]]
            kmap(args.buf, "n", "", ":Comm<CR>", opts)
            kmap(args.buf, "v", "", ":Comm<CR>", opts)
            kmap(args.buf, "i", "", "<ESC>:Comm<CR>", opts)
        end
        if ft == "go" or ft == "python" or ft == "c" or ft == "cpp" then
            kmap(args.buf, "n", "so", ":AsyncTaskEdit<CR>", opt)
            kmap(args.buf, "n", "<LEADER>i", ":AsyncTask file-run<cr>", opt)
            kmap(args.buf, "n", "<LEADER>b", ":AsyncTask file-build<cr>", opt)
            kmap(args.buf, "n", "<LEADER>n", ":AsyncTask project-build<cr>", opt)
            kmap(args.buf, "n", "<A-l>", "<Plug>VimspectorStepOver", opt)
            kmap(args.buf, "n", "<A-i>", ":VimspectorWatch", opt)
            kmap(args.buf, "n", "<A-n>", ":VimspectorShowOutput", opt)
            kmap(args.buf, "x", "<A-k>", "<Plug>VimspectorBalloonEval", opt)
            kmap(args.buf, "n", "<A-k>", "<Plug>VimspectorBalloonEval", opt)
            kmap(args.buf, "n", "<A-'>", "<Plug>VimspectorDisassemble", opt)
        end
    end
})
