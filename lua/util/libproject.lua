-- asynctasks
vim.g.asynctasks_config_name = '.tasks,$HOME/.config/nvim/tasks.ini'
vim.g.asyncrun_open = 6
vim.g.asynctasks_term_reuse = 1
vim.asynctasks_term_focus = 0

-- vimspector
-- vim.g.vimspector_variables_display_mode = 'full'
-- vim.g.vimspector_disassembly_height = 10
-- vim.g.vimspector_enable_mappings = 'HUMAN'
-- vim.g.vimspector_install_gadgets = { 'vscode-cpptools', 'debugpy', "delve" }


local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap("n", "so", ":AsyncTaskEdit<CR>", opts)
keymap("n", "<LEADER>i", ":AsyncTask file-run<cr>", opts)
keymap("n", "<LEADER>b", ":AsyncTask file-build<cr>", opts)
keymap("n", "<LEADER>n", ":AsyncTask project-build<cr>", opts)
keymap("n", "<A-l>", "<Plug>VimspectorStepOver", opts)
keymap("n", "<A-i>", ":VimspectorWatch", nil)
keymap("n", "<A-n>", ":VimspectorShowOutput", opts)
keymap("x", "<A-k>", "<Plug>VimspectorBalloonEval", opts)
keymap("n", "<A-k>", "<Plug>VimspectorBalloonEval", opts)
keymap("n", "<A-'>", "<Plug>VimspectorDisassemble", opts)
