G = {}

G.on_attach = function(client, bufnr)
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
  keymap(bufnr, "n", "<C-q>", "<Cmd>lua Dap.close()<CR>", opts)
  keymap(bufnr, "n", "K", "<Cmd>lua require 'dapui'.eval()<CR>", opts)
  keymap(bufnr, "n", "so", ":AsyncTaskEdit<CR>", opts)
  keymap(bufnr, "n", "<LEADER>i", ":AsyncTask file-run<cr>", opts)
  keymap(bufnr, "n", "<LEADER>b", ":AsyncTask file-build<cr>", opts)
  keymap(bufnr, "n", "<LEADER>n", ":AsyncTask project-build<cr>", opts)
  keymap(bufnr, "n", "s\\", ":ProjectInitialization<CR>", opts)
  -- end
  -- keymap(bufnr, "n", "sdh", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
  require("nvim-navic").attach(client, bufnr)
  vim.notify("Loading LSP server " .. client.messages.name .. " Finish", "info", { title = "LSP server" })
end

G.config = {
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        },
    }
}

return G
