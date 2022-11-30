-- vim.g.asynctasks_config_name = '.tasks,$HOME/.config/nvim/tasks.ini'
-- vim.g.asyncrun_open = 6
-- vim.g.asynctasks_term_focus = 0

O.addOpt({
  { "g", "asynctasks_rtp_config", "$HOME/.config/nvim/tasks.ini" },
  { "g", "asynctasks_config_name", ".tasks,.nvim/.tasks" },
  { "g", "asyncrun_rootmarks", { ".nvim", ".git" } },
  { "g", "asyncrun_open", 6 },
  { "g", "asynctasks_term_reuse", 1 },
  { "g", "asynctasks_term_focus", 0 },
})
