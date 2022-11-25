local dap, dapui = require "dap", require "dapui"

dap.listeners.after.event_initialized["dapui_config"] = function()
  vim.cmd [[DapVirtualTextEnable]]
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  vim.cmd [[DapVirtualTextDisable]]
  vim.cmd [[bd! dap-repl]]
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  vim.cmd [[DapVirtualTextDisable]]
  vim.cmd [[bd! dap-repl]]
  dapui.close()
end

vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'CursorLineNr', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'Character', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'ErrorMsg', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'Conditional', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'Function', linehl = '', numhl = '' })

dapui.setup({
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
        -- "console",
        "repl",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
}
)
