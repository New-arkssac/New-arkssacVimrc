H = {}

local navic = require("nvim-navic")

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
  -- keymap(bufnr, "n", "sdh", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
  navic.attach(client, bufnr)
  vim.notify("Loading LSP server " .. client.messages.name .. " Finish", "info", {title = "LSP server"})
end

local on_attachjava = function(client, bufnr)
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
  -- keymap(bufnr, "n", "sdh", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
  navic.attach(client, bufnr)
  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
  require("jdtls.dap").setup_dap_main_class_configs()
  vim.lsp.codelens.refresh()
  vim.notify("Loading LSP server " .. client.messages.name .. " Finish", "info", {title = "LSP server"})
end

local ftOnAttach = {
  lua = on_attach,
  go = on_attach,
  json = on_attach,
  python = "pyright",
  c = "clangd",
  java = on_attachjava,
}

OPTS = {
  on_attach = on_attach,
  capabilities = CAPABILITIES,
  flags = {
    debounce_text_changes = 150,
  }
}

M.setup = function(ft)
  CAPABILITIES = vim.lsp.protocol.make_client_capabilities()
  CAPABILITIES.textDocument.completion.completionItem.snippetSupport = true
  CAPABILITIES = require("cmp_nvim_lsp").default_capabilities(CAPABILITIES)

end
