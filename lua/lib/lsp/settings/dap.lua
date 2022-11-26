Dap = {}
Dap.dap, Dap.ui, Dap.vtext = require "dap", require "dapui", require "nvim-dap-virtual-text"

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
          "watches",
        },
        size = 40, -- 40 columns
        position = "left",
      },
      {
        elements = {
          "stacks",
          "scopes",
        },
        size = 40, -- 25% of total lines
        position = "right",
      },
      {
        elements = {
          "console",
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
    Dap.close()
  end
  Dap.dap.listeners.before.event_exied["dapui_config"] = function()
    Dap.close()
  end
end

Dap.close = function()
  vim.cmd [[DapVirtualTextDisable]]
  if vim.fn.bufexists("[dap-repl]") == 1 then
    vim.cmd [[bd! dap-repl]]
  end
  Dap.ui.close()
end

Dap.open = function()
  vim.cmd [[DapVirtualTextEnable]]
  Dap.ui.open()
end

vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'CursorLineNr', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'Character', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'ErrorMsg', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'Conditional', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'Function', linehl = '', numhl = '' })

return Dap
