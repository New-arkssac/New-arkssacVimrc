H = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

H.opts = {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  }
}

return H
