-- vim.g.asynctasks_config_name = '.tasks,$HOME/.config/nvim/tasks.ini'
-- vim.g.asyncrun_open = 6
-- vim.g.asynctasks_term_focus = 0
ASYNC = {}

O.addOpt({
  { "g", "asynctasks_rtp_config", "$HOME/.config/nvim/tasks.ini" },
  { "g", "asynctasks_config_name", ".tasks,.nvim/.tasks" },
  { "g", "asyncrun_rootmarks", { ".nvim", ".git" } },
  { "g", "asyncrun_open", 6 },
  { "g", "asynctasks_term_reuse", 1 },
  { "g", "asynctasks_term_focus", 0 },
})

ASYNC.edit = function()
  local data = vim.fn.system("ls -a")
  local nvim = data:find(".nvim")
  local tasks = data:find(".tasks")

  if nvim or tasks then
    vim.cmd("cd " .. G.pwd)
    local flag = true
    if flag and tasks then
      vim.cmd "tabnew .tasks"
      flag = false
    end

    if flag and nvim then
      vim.cmd "tabnew .nvim/.tasks"
    end
    return
  end

  if vim.fn.getcwd() == G.home then
    vim.notify("Not find .nvim or .tasks", "warn", { title = "async edit" })
    return
  end

  vim.cmd "cd .."
  ASYNC.edit()
  vim.cmd("cd " .. G.pwd)
end

return ASYNC
