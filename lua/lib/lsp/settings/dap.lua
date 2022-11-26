Dap = {}
Dap.dap, Dap.ui, Dap.vtext, Dap.vscode = require "dap", require "dapui", require "nvim-dap-virtual-text",
    require "dap.ext.vscode"

-- .setup {
-- enabled = true,                        -- enable this plugin (the default)
-- enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
-- highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
-- highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
-- show_stop_reason = true,               -- show stop reason when stopped for exceptions
-- commented = false,                     -- prefix virtual text with comment string
-- only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
-- all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
-- filter_references_pattern = '<module>', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
-- -- experimental features:
-- virt_text_pos = 'eol',                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
-- all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
-- virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
-- virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
-- }

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
