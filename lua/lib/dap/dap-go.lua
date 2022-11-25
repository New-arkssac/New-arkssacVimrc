local dap = require "dap"

dap.adapters.delve = function(cb)
  local stdout = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local port = 38697
  local opts = {
    stdio = { nil, stdout },
    args = { "dap", "-l", "127.0.0.1:" .. port, "--check-go-version=false" },
    detached = true
  }
  handle, pid_or_err = vim.loop.spawn(G.home .. '/.local/share/nvim/mason/bin/dlv', opts, function(code)
    stdout:close()
    handle:close()
    if code ~= 0 then
      print('dlv exited with code', code)
    end
  end)
  assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        --- You could adapt this and send `chunk` to somewhere else
        require('dap.repl').append(chunk)
      end)
    end
  end)
  -- Wait for delve to start
  vim.defer_fn(
    function()
      cb({ type = "server", host = "127.0.0.1", port = port })
    end,
    100)
end

dap.configurations.go = {
  {
    type = "delve",
    name = "Debug workspace",
    request = "launch",
    program = "${workspaceFolder}",
    mode = "debug",
    console = "integratedTerminal",
  },
  {
    type = "delve",
    name = "Debug file",
    mode = "debug",
    request = "launch",
    program = "${file}",
    console = "integratedTerminal",
  },
}

dap.defaults.fallback.terminal_win_cmd = 'split'
