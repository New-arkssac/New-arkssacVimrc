Dap = {}
Dap.dap,
    Dap.ui,
    Dap.vtext,
    Dap.repl = require "dap",
    require "dapui",
    require "nvim-dap-virtual-text",
    require "dap.repl"

Dap.setup = function()
  Dap.vtext.setup {
    enabled = true,
    enabled_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = false,
    show_stop_reason = true,
    commented = false,
    only_first_definition = true,
    all_references = false,
    filter_references_pattern = '<module>',
    -- experimental features:
    virt_text_pos = 'eol',
    all_frames = false,
    virt_lines = false,
    virt_text_win_col = nil
  }
  Dap.ui.setup {
    icons = { expanded = "╰─▸", collapsed = "╰─▸", current_frame = "╰─▸" },
    layouts = {
      {
        elements = {
          -- Elements can be strings or table with id and size keys.
          "breakpoints",
          "scopes",
          "watches",
        },
        size = 40, -- 40 columns
        position = "left",
      },
      {
        elements = {
          "console",
          "stacks",
        },
        size = 40, -- 25% of total lines
        position = "right",
      },
      {
        elements = {
          "repl",
        },
        size = 0.25, -- 25% of total lines
        position = "bottom",
      },
    },
  }
end

Dap.load = function()

  Dap.dap.listeners.after.event_initialized["dapui_config"] = function()
    Dap.open()
  end

  Dap.dap.listeners.before.event_terminated["dapui_config"] = function()
    vim.cmd [[DapTerminate]]
    Dap.close()
  end

  Dap.dap.listeners.before.event_exied["dapui_config"] = function()
    vim.cmd [[DapTerminate]]
    Dap.close()
  end

end

Dap.close = function()
  vim
      .cmd [[DapVirtualTextDisable]]
  vim
      .cmd [[DapTerminate]]

  Dap.ui.close()
  Dap.repl.close()
end

Dap.open = function()
  vim
      .cmd [[DapVirtualTextEnable]]
  Dap.ui.open()
end

Dap.editlc = function()
  local data = vim.fn.system("ls -a")
  local nvim = data:find(".nvim")
  if not nvim then
    if vim.fn.getcwd() == G.home then
      vim.notify("Not find .nvim", "warn", { title = "Dap" })
      return
    end

    vim.cmd "cd .."
    Dap.editlc()
    vim.cmd("cd " .. G.pwd)
    return
  end

  data = vim.fn.system("ls -a .nvim")
  local json = data:find("launch.json")
  if not json then
    vim.notify("Not find .nvim", "warn", { title = "Dap" })
    return
  end
  vim.cmd "tabnew .nvim/launch.json"
end

vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'CursorLineNr', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'Character', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'ErrorMsg', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'Conditional', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'Function', linehl = '', numhl = '' })

return Dap
