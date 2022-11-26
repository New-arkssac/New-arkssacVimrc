require("mason").setup({
  ui = {
    border = "none",
    icons = {
      package_installed = "",
      package_pending = "",
      package_uninstalled = ""
    }
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})
require("mason-lspconfig").setup({
  ensure_installed = { "sumneko_lua",
    "gopls",
    "jsonls",
    "jdtls",
    "pyright",
    "clangd",
    -- "cpptools",
    -- "debugpy",
    -- "delve",
  },
  automatic_installation = true,
})

local adapter = {
  python = {
    type = 'executable';
    command = '/usr/bin/python',
    args = { '-m', 'debugpy.adapter' }
  },
  go = function(cb)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local port = 38697
    local opts = {
      stdio = { nil, stdout },
      args = { "dap", "-l", "127.0.0.1:" .. port, "--check-go-version=false", "--log", " --log-output=dap" },
      detached = true
    }
    handle, pid_or_err = vim.loop.spawn(os.getenv("HOME") .. '/.local/share/nvim/mason/bin/dlv', opts, function(code)
      -- handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
      stdout:close()
      handle:close()
      if code ~= 0 then
        vim.notify('dlv exited with code ' .. code, "warn", { title = "Dap" })
      end
    end)
    assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require('dap.repl').append(chunk)
        end)
      end
    end)
    vim.defer_fn(
      function()
        cb({ type = "server", host = "127.0.0.1", port = port })
      end,
      100)
  end,
  c = {
    id = 'cppdbg',
    type = 'executable',
    command = G.home .. '/.local/share/nvim/mason/bin/OpenDebugAD7',
    options = {
      detached = false
    }
  }
}
local configurations = {
  python = {
    {
      type = 'python';
      request = 'launch';
      name = "Launch file";
      program = "${file}";
      pythonPath = function()
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
          return cwd .. '/venv/bin/python'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
          return cwd .. '/.venv/bin/python'
        else
          return '/usr/bin/python'
        end
      end;
      console = "integratedTerminal"
    },
  },
  go = {
    {
      type = "go",
      name = "Debug workspace",
      request = "launch",
      program = "${workspaceFolder}",
      mode = "debug",
      console = "integratedTerminal",
    },
    {
      type = "go",
      name = "Debug file",
      mode = "debug",
      request = "launch",
      program = "${file}",
      console = "integratedConsole",
    },
    {
      type = "go",
      name = "Debug vscode-go",
      request = 'launch';
      showLog = false;
      program = "${file}";
      dlvToolPath = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/dlv",
      console = "externalTerminal",
    },
  },
  -- go = function ()
  -- require "dap.ext.vscode".load_launchjs("./.nvim/launch.json", { go = { "go" } })
  -- end,
  c = {
    {
      name = "Launch current file",
      type = "c",
      request = "launch",
      program = "${fileBasenameNoExtension}",
      cwd = '${workspaceFolder}',
      stopAtEntry = true,
    },
    {
      name = "Launch appoint file",
      type = "c",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopAtEntry = true,
    },
  }
}

local server = {
  lua = "sumneko_lua",
  go = "gopls",
  json = "jsonls",
  python = "pyright",
  c = "clangd"
}


local signs = {
  { name = "DiagnosticSignError", text = "﫝" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  signs = {
    active = signs, -- show signs
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "WARNING: ",
  },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})


vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "StdinReadPost" }, {
  callback = function(args)
    local opts = {}
    local ft, _ = vim.filetype.match({ filename = args.match, buf = args.buf })

    local lsp = server[ft]
    if lsp == nil then
      return
    end

    local require_ok, setting = pcall(require, "lib.lsp.settings." .. ft)
    if not require_ok then
      return
    end

    vim.schedule(function()
      local dap = require 'lib.lsp.settings.dap'
      local apter, conf = adapter[ft], configurations[ft]
      if apter == nil or conf == nil then
        return
      end
      dap.setup()
      dap.load()
      dap.dap.adapters[ft] = apter
      dap.dap.configurations[ft] = conf
    end)

    local opt = require "lib.lsp.handle"
    opt.on_attach = setting.on_attach
    opts = vim.tbl_deep_extend("force", setting.config, opt)
    require("lspconfig")[lsp].setup(opts)
  end,
})
