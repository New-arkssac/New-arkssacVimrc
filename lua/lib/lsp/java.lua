local on_attach = function(client, bufnr)
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
end

local config = {
  cmd = {
    G.home .. "/.local/share/nvim/mason/bin/jdtls",
    "-configuration",
    G.home .. "/.cache/jdtls/config",
    '-data',
    G.pwd
  },
  settings = {
    java = {
    }
  },
  on_attach = on_attach,
  init_options = {
    bundles = {
      vim.fn.glob(G.home ..
        "/.local/share/nvim/debug/java-debug-0.42.0/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.42.0.jar"
        , 1)
    };
  }

}
-- local dap = require("dap")
-- dap.adapters.java = function(callback, config)
    -- execute_command({ command = 'vscode.java.startDebugSession' }, function(err0, port)
    -- assert(not err0, vim.inspect(err0))
-- 
    -- callback({ type = 'server'; host = '127.0.0.1'; port = port; })
  -- end)
-- end

require('jdtls').start_or_attach(config)
