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
    java = "jdtls",
    python = "pyright",
    c = "clangd"
}

CAPABILITIES = vim.lsp.protocol.make_client_capabilities()
CAPABILITIES.textDocument.completion.completionItem.snippetSupport = true
CAPABILITIES = require("cmp_nvim_lsp").default_capabilities(CAPABILITIES)

local signs = {

    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
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
        prefix = "",
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
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    keymap(bufnr, "n", "<leader>=", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
    keymap(bufnr, "n", "<leader>-", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
    keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
        return
    end
    illuminate.on_attach(client)
end

OPTS = {
    on_attach = on_attach,
    capabilities = CAPABILITIES
}

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "StdinReadPost" }, {
    callback = function(args)
        local opts = {}
        local ft, _ = vim.filetype.match({ filename = args.match, buf = args.buf })
        local lsp = SERVER[ft]
        if lsp == nil then
            return
        end
        local require_ok, conf_opts = pcall(require, "lib.lsp.settings." .. ft)
        if require_ok then
            opts = vim.tbl_deep_extend("force", conf_opts, OPTS)
        end
        require("lspconfig")[lsp].setup(opts)
        print("Loading LSP server " .. lsp .. " Finish")
    end,
})
