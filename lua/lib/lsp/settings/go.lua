GO = {}

local opts = { noremap = true, silent = true }
GO.on_attach = require "lib.lsp.settings.attach".setup({
  { "n", "<F3>", "<Cmd>lua require'dap'.step_into()<CR>", opts },
  { "n", "<F4>", "<Cmd>lua require'dap'.step_over()<CR>", opts },
  { "n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", opts },
  { "n", "<F6>", "<Cmd>lua require'dap'.step_out()<CR>", opts },
  { "n", "<F8>", "<Cmd>DapTerminate<CR>", opts },
  { "n", "<F9>", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts },
  { "n", "<C-q>", "<Cmd>lua Dap.close()<CR>", opts },
  { "n", "K", "<Cmd>lua require 'dapui'.eval()<CR>", opts },
  -- { "n", "<F2>", "<Plug>VimspectorDisassemble", opts },
  -- { "n", "<F3>", "<Plug>VimspectorStepInto", opts },
  -- { "n", "<F4>", "<Plug>VimspectorStepOver", opts },
  -- { "n", "<F5>", "<Plug>VimspectorContinue", opts },
  -- { "n", "<F6>", "<Plug>VimspectorRestart", opts },
  -- { "n", "<F8>", "<Plug>VimspectorAddFunctionBreakpoint", opts },
  -- { "n", "<F20>", "<Plug>VimspectorRunToCursor", opts },
  -- { "n", "<F9>", "<Plug>VimspectorToggleBreakpoint", opts },
  -- { "n", "<F21>", "<Plug>VimspectorToggleConditionalBreakpoint", opts },
  -- { "n", "<C-q>", ":VimspectorReset<CR>", opts },
  -- { "n", "K", "<Plug>VimspectorBalloonEval", opts },
  { "n", "so", ":AsyncTaskEdit<CR>", opts },
  { "n", "s[", ":lua ASYNC.edit()<CR>", opts },
  { "n", "s]", ":lua Dap.editlc()<CR>", opts },
  { "n", "<LEADER>i", ":AsyncTask file-run<cr>", opts },
  { "n", "<LEADER>b", ":AsyncTask file-build<cr>", opts },
  { "n", "<LEADER>n", ":AsyncTask project-build<cr>", opts },
  { "n", "s\\", ":ProjectInitialization<CR>", opts },
})

GO.config = {
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

return GO
