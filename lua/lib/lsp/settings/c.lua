C = {}

local opts = { noremap = true, silent = true }
C.on_attach = require "lib.lsp.settings.attach".setup({
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
  { "n", "<LEADER>i", ":AsyncTask file-run<cr>", opts },
  { "n", "<LEADER>b", ":AsyncTask file-build<cr>", opts },
  { "n", "<LEADER>n", ":AsyncTask project-build<cr>", opts },
  { "n", "s\\", ":ProjectInitialization<CR>", opts },
})

C.config = {
  settings = {
    args = {
      "--background-index",
      "--pch-storage=memory",
      "--clang-tidy",
      "--suggest-missing-includes",
      "--background-index", -- 后台建立索引，并持久化到disk
      "--clang-tidy", -- 开启clang-tidy
      "--clang-tidy-checks=bugprone-*, clang-analyzer-*, google-*, modernize-*, performance-*, portability-*, readability-*, -bugprone-too-small-loop-variable, -clang-analyzer-cplusplus.NewDelete, -clang-analyzer-cplusplus.NewDeleteLeaks, -modernize-use-nodiscard, -modernize-avoid-c-arrays, -readability-magic-numbers, -bugprone-branch-clone, -bugprone-signed-char-misuse, -bugprone-unhandled-self-assignment, -clang-diagnostic-implicit-int-float-conversion, -modernize-use-auto, -modernize-use-trailing-return-type, -readability-convert-member-functions-to-static, -readability-make-member-function-const, -readability-qualified-auto, -readability-redundant-access-specifiers,",
      "--completion-style=detailed",
      "--cross-file-rename=true",
      "--header-insertion=iwyu",
      "--pch-storage=memory",
      "--function-arg-placeholders=false",
      "--log=verbose",
      "--ranking-model=decision_forest",
      "--header-insertion-decorators",
      "-j=12",
      "--pretty",
    }
  }
}

return C
