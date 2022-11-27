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
keymap("n", "<LEADER>v", "<CMD>Buffers<CR>")
keymap("n", "<LEADER>;", "<CMD>Rg<CR>")
keymap("n", "<LEADER>F", "<CMD>Files<CR>")
keymap("n", "<LEADER>;", "<CMD>Rg<CR>")
keymap("n", "<LEADER>m", "<CMD>Vista!!<CR>")
keymap("n", "<LEADER>sp", ":set spell!<CR>", opt) -- open word spell check
keymap("n", "<LEADER>uu", ":UndotreeToggle<CR>")
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
keymap("n", "sD", ":bd!<CR>", opt)
keymap("n", "sy", ":OpenClip<CR>", opt)
keymap("n", "sP", ":PastUpload<CR>", opt)
keymap("n", "sp", ":PastImage<CR>", opt)
keymap("i", ",y", "<ESC>:OpenClip<CR>", opt)
keymap("i", ",p", "<ESC>:PastImage<CR>i", opt)
keymap("i", ",P", "<ESC>:PastUpload<CR>i", opt)
-- keymap("i", "'", [[''<left>]], opt) -- ' -> ''
-- keymap("i", "\"", [[""<left>]], opt) -- " -> ""
-- keymap("i", "(", [[()<left>]], opt) -- ( -> ()
-- keymap("i", "[", [[[]<left>]], opt) -- [ -> []
-- keymap("i", "{", [[{}<left>]], opt) -- { -> {}

