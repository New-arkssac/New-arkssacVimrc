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
  ensure_installed = {
    "sumneko_lua",
    "gopls",
    "jsonls",
    "jdtls",
    "pyright",
    "clangd",
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
    local stdin = vim.loop.new_pipe(false)
    local stdout = vim.loop.new_pipe(false)
    local stderr = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local port = 38697
    local opts = {
      stdio = { stdin, stdout, stderr },
      args = G.info[G.system][G.os].cmd.dapargs,
      detached = true
    }
    handle, pid_or_err = vim.loop.spawn(G.info[G.system][G.os].cmd.terminal, opts, function(code)
      stdin:close()
      stderr:close()
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

    stderr:read_start(function(err, chunk)
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

local signs = {
  { name = "DiagnosticSignError", text = "﫝" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do vim
      .fn
      .sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
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

vim
    .diagnostic
    .config(config)

vim
    .lsp
    .handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = "rounded",
  }
)

vim
    .lsp
    .handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "rounded",
  }
)

local ft, _ = vim
    .filetype
    .match({ filename = vim.fn.expand("%:p") })
local lsp = G.lspserver[ft]

if lsp == nil then return end

local opts = {}
local require_ok, setting = pcall(require, "lib.lsp.settings." .. ft)

if not require_ok then return end

vim.schedule(function()
  local apter = adapter[ft]
  if apter == nil then return end

  local dap = require 'lib.lsp.settings.dap'
  dap.setup()
  dap.load()
  dap
      .dap
      .adapters[ft] = apter

  require "dap.ext.vscode".load_launchjs(".nvim/launch.json", lsp[2])
end)

local opt = require "lib.lsp.handle"
opt.on_attach = setting.on_attach
opts = vim.tbl_deep_extend("force", setting.config, opt)

require("lspconfig")[lsp[1]].setup(opts)
vim.cmd [[command! -range Comm :lua M.comm()]]
vim.cmd [[command! ProjectInitialization :lua P.projectInitialization()]]
