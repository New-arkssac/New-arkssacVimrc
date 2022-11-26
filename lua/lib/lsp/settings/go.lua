G = {}

local opts = { noremap = true, silent = true }
G.on_attach = require "lib.lsp.settings.attach".setup({
  { "n", "<F3>", "<Cmd>lua require'dap'.step_into()<CR>", opts },
  { "n", "<F4>", "<Cmd>lua require'dap'.step_out()<CR>", opts },
  { "n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", opts },
  { "n", "<F6>", "<Cmd>lua require'dap'.step_over()<CR>", opts },
  { "n", "<F8>", "<Cmd>DapTerminate<CR>", opts },
  { "n", "<F9>", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts },
  { "n", "<C-q>", "<Cmd>lua Dap.close()<CR>", opts },
  { "n", "K", "<Cmd>lua require 'dapui'.eval()<CR>", opts },
  { "n", "so", ":AsyncTaskEdit<CR>", opts },
  { "n", "<LEADER>i", ":AsyncTask file-run<cr>", opts },
  { "n", "<LEADER>b", ":AsyncTask file-build<cr>", opts },
  { "n", "<LEADER>n", ":AsyncTask project-build<cr>", opts },
  { "n", "s\\", ":ProjectInitialization<CR>", opts },
})

G.config = {
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  }
}

return G
