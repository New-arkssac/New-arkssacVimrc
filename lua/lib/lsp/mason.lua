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
  ensure_installed = { "sumneko_lua", "gopls", "jsonls", "jdtls", "pyright", "clangd" },
  automatic_installation = true,
})

SERVER = {
  lua = "sumneko_lua",
  go = "gopls",
  json = "jsonls",
  -- java = "jdtls",
  python = "pyright",
  c = "clangd"
}

CAPABILITIES = vim.lsp.protocol.make_client_capabilities()
CAPABILITIES.textDocument.completion.completionItem.snippetSupport = true
CAPABILITIES = require("cmp_nvim_lsp").default_capabilities(CAPABILITIES)

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

local on_attach = function(client, bufnr)
  -- print(vim.inspect(client))
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  -- keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "gk", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "sf", "<cmd>lua vim.lsp.buf.format {async = true}<cr>", opts)
  keymap(bufnr, "n", "sa", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  keymap(bufnr, "n", "<leader>=", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
  keymap(bufnr, "n", "<leader>-", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
  keymap(bufnr, "n", "sdn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  keymap(bufnr, "i", "<C-l>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "<F3>", "<Cmd>lua require'dap'.step_into()<CR>", opts)
  keymap(bufnr, "n", "<F4>", "<Cmd>lua require'dap'.step_out()<CR>", opts)
  keymap(bufnr, "n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", opts)
  keymap(bufnr, "n", "<F6>", "<Cmd>lua require'dap'.step_over()<CR>", opts)
  keymap(bufnr, "n", "<F8>", "<Cmd>DapTerminate<CR>", opts)
  keymap(bufnr, "n", "<F9>", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
  keymap(bufnr, "n", "<C-q>", "<Cmd>lua require 'dapui'.toggle()<CR>", opts)
  keymap(bufnr, "n", "K", "<Cmd>lua require 'dapui'.eval()<CR>", opts)

  -- keymap(bufnr, "n", "sdh", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
  require("nvim-navic").attach(client, bufnr)
  vim.notify("Loading LSP server " .. client.messages.name .. " Finish", "info", {title = "LSP server"})
end

OPTS = {
  on_attach = on_attach,
  capabilities = CAPABILITIES,
  flags = {
    debounce_text_changes = 150,
  }
}

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "StdinReadPost" }, {
  callback = function(args)
    local opts = {}
    local ft, _ = vim.filetype.match({ filename = args.match, buf = args.buf })
    MESSAGE = ft
    local lsp = SERVER[ft]
    if lsp == nil then
      return
    end
    local require_ok, conf_opts = pcall(require, "lib.lsp.settings." .. ft)
    if require_ok then
      opts = vim.tbl_deep_extend("force", conf_opts, OPTS)
    end
    require("lspconfig")[lsp].setup(opts)
  end,
})
