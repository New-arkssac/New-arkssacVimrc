A = {}

A.setup = function(table, tf)
  local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap(bufnr, "n", "gk", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap(bufnr, "n", "sf", "<cmd>lua vim.lsp.buf.format {async = true}<cr>", opts)
    keymap(bufnr, "n", "sa", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    keymap(bufnr, "n", "<leader>=", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
    keymap(bufnr, "n", "<leader>-", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
    keymap(bufnr, "n", "sdn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    keymap(bufnr, "i", "<C-l>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap(bufnr, "n", "", ":Comm<CR>", opts)
    keymap(bufnr, "v", "", ":Comm<CR>", opts)
    keymap(bufnr, "n", "sg", ":tabnew term://lazygit<CR>", opts)

    if table then
      for _, value in pairs(table) do
        keymap(bufnr, value[1], value[2], value[3], value[4])
      end
    end

    if tf then
      for _, value in pairs(tf) do
        value[1](value[2])
      end
    end

    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
      return
    end

    illuminate.on_attach(client)
    require("nvim-navic").attach(client, bufnr)
    vim.notify("Loading LSP server " .. client.messages.name .. " Finish", "info", { title = "LSP server" })
  end
  return on_attach
end

return A
