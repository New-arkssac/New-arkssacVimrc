local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

require "lib.lsp.mason"

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile", "StdinReadPost"}, {
    callback = function (args)
        local server = {
            lua = "sumneko_lua",
            go = "gopls",
            json = "jsonls",
            java = "jdtls",
            python = "pyright",
            c = "clangd"
        }
        local ft, _ = vim.filetype.match({filename = args.match, buf = args.buf})
        local lsp = server[ft]
        if lsp == nil then
            return
        end
        require("lspconfig")[lsp].setup {}
    end,
})
-- local lsp_flags = {
  -- debounce_text_changes = 150,
-- }
-- 
-- local on_attach = function(_, bufnr)
    -- local bufopts = { noremap=true, silent=true, buffer=bufnr }
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wl', function()
    -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts)
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    -- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
-- end

-- local lsp_flags = {
  -- debounce_text_changes = 150,
-- }

