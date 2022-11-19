local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    sources = {
        formatting.yapf,
        diagnostics.flake8.with({ extra_args = { "--max-line-length=500" } }),
        -- formatting.stylua,
        -- formatting.clang_format,
        -- diagnostics.clang_check,
        -- diagnostics.golangci_lint,
    },
})
