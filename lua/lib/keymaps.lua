K = {}

local keymap = vim.keymap.set
local opt = { silent = true, nowait = true }
local map = { "n", "v", "x" }

local setkeymap = {
  { map, ";", ":", nil },
  { map, "s", "<nop>", opt },
  { "n", "S", ":w<CR>", opt },
  { "n", "Q", ":q<CR>", opt },
  { "n", "<A-s>k", ":e $MYVIMRC<CR>", opt },
  { "n", "sr", ":source $MYVIMRC<CR>", opt },
  { "n", "sh", ":set nosplitright<CR>:vsplit<CR>", opt },
  { "n", "sk", ":set splitright<CR>:split<CR>", opt },
  { "n", "sj", ":set nosplitright<CR>:split<CR>", opt },
  { "n", "st", ":tabe<CR>", opt },
  { "n", "si", ":+tabnext<CR>", opt },
  { "n", "su", ":-tabnext<CR>", opt },
  { "n", "<LEADER>q", ":qa<CR>", opt },
  { "n", "<LEADER>j", "<C-w>j", opt },
  { "n", "<LEADER>k", "<C-w>k", opt },
  { "n", "<LEADER>h", "<C-w>h", opt },
  { "n", "<LEADER>l", "<C-w>l", opt },
  { "n", "<LEADER>o", "<CMD>TroubleToggle<cr>" },
  { map, "<LEADER>t", "<CMD>TranslateW<CR>" },
  { "n", "<LEADER>v", "<CMD>Buffers<CR>" },
  { "n", "<LEADER>;", "<CMD>Rg<CR>" },
  { "n", "<LEADER>F", "<CMD>Files<CR>" },
  { "n", "<LEADER>;", "<CMD>Rg<CR>" },
  { "n", "<LEADER>m", "<CMD>Vista!!<CR>" },
  { "n", "<LEADER>sp", ":set spell!<CR>", opt },
  { "n", "<LEADER>uu", ":UndotreeToggle<CR>" },
  { "n", "<Up>", ":res +5<CR>", opt },
  { "n", "<Down>", ":res -5<CR>", opt },
  { "n", "<Left>", ":vertical resize+5<CR>", opt },
  { "n", "<Right>", ":vertical resize-5<CR>", opt },
  { "v", "<C-c>", [["+y]], opt },
  { "n", "<C-p>", [["+p]], opt },
  { "i", "<C-p>", [[<ESC>"+p]], opt },
  { "v", ">", ">gv", opt },
  { "v", "<", "<gv", opt },
  { "v", "p", '"_dP', opt },
  { "n", "sD", ":bd!<CR>", opt },
  { "n", "sy", ":OpenClip<CR>", opt },
  { "n", "sP", ":PastUpload<CR>", opt },
  { "n", "sp", ":PastImage<CR>", opt },
  { "i", ",y", "<ESC>:OpenClip<CR>", opt },
  { "i", ",p", "<ESC>:PastImage<CR>i", opt },
  { "i", ",P", "<ESC>:PastUpload<CR>i", opt },
}

for i = 1, #setkeymap do keymap(setkeymap[i][1], setkeymap[i][2], setkeymap[i][3], setkeymap[i][4]) end

K.addKeymap = function(add)
  if not add then return end

  for i = 1, #add do keymap(add[i][1], add[i][2], add[i][3], add[i][4]) end
end
-- { "i", "'", [[''<left>]], opt },
-- { "i", "\"", [[""<left>]], opt },
-- { "i", "(", [[()<left>]], opt },
-- keymap("i", "[", [[[]<left>]], opt) -- [ -> []
-- keymap("i", "{", [[{}<left>]], opt) -- { -> {}
return K
