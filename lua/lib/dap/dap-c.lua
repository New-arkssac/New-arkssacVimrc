local dap = require('dap')
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = G.home..'/.local/share/nvim/mason/bin/OpenDebugAD7',
}

dap.configurations.c = {
  {
    name = "Launc current file",
    type = "cppdbg",
    request = "launch",
    program = "${fileBasenameNoExtension}",
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
  {
    name = "Launc appoint file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
}
