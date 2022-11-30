L = {}

local opts = { noremap = true, silent = true, nowait = true }
L.on_attach = require "lib.lsp.settings.attach".setup({
  { "n", "<A-r>", ":source % | nohlsearch <CR>", opts }
})

L.config = {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT"
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
}

return L
