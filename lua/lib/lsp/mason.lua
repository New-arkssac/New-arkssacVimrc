require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- local server = {
    -- lua = "sumneko_lua",
    -- go = "gopls",
    -- json = "jsonls",
    -- java = "jdtls",
    -- python = "pyright",
    -- c = "clangd"
-- }

-- local filetype = vim.o.filetype 
-- local lsp = server[filetype]
-- for _, value in pairs(server) do
    -- print(value)
-- end
-- require("lspconfig")[lsp].setup {}

