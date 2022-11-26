local opts = { noremap = true, silent = true }

local config = {
  settings = {
    java = {
      signatureHelp = { enabled = true };
      contentProvider = { preferred = 'fernflower' };
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
      };
    }
  },
  init_options = {
    bundles = {
      vim.fn.glob(G.home ..
        "/.local/share/nvim/debug/java-debug-0.42.0/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.42.0.jar"
        -- "~/.local/share/nvim/mason/bin/"
        , 1)
    };
  },
  sources = {
    organizeImports = {
      starThreshold = 9999;
      staticStarThreshold = 9999;
    };
  };
  codeGeneration = {
    toString = {
      template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
    },
    hashCodeEquals = {
      useJava7Objects = true,
    },
    useBlocks = true,
  };
  cmd = {
    G.home .. "/.local/share/nvim/mason/bin/jdtls",
    "-configuration",
    G.home .. "/.cache/jdtls/config",
    '-data',
    G.pwd
  },
  on_attach = require "lib.lsp.settings.attach".setup({
    { "n", "<F3>", "<Cmd>lua require'dap'.step_into()<CR>", opts },
    { "n", "<F4>", "<Cmd>lua require'dap'.step_out()<CR>", opts },
    { "n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", opts },
    { "n", "<F6>", "<Cmd>lua require'dap'.step_over()<CR>", opts },
    { "n", "<F8>", "<Cmd>DapTerminate<CR>", opts },
    { "n", "<F9>", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts },
    { "n", "<C-q>", "<Cmd>lua Dap.close()<CR>", opts },
    { "n", "K", "<Cmd>lua require 'dapui'.eval()<CR>", opts },
    { "n", "so", ":AsyncTaskEdit<CR>", opts },
    { "n", "<LEADER>i", ":AsyncTask file-run<cr>", opts },
    { "n", "<LEADER>b", ":AsyncTask file-build<cr>", opts },
    { "n", "<LEADER>n", ":AsyncTask project-build<cr>", opts },
    { "n", "s\\", ":ProjectInitialization<CR>", opts },
    { "n", "sdh", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts },
  }, {
    { require('jdtls').setup_dap, { hotcodereplace = 'auto' } },
    { require("jdtls.dap").setup_dap_main_class_configs },
    { vim.lsp.codelens.refresh }
  })
};

vim.schedule(function()
  local dap = require 'lib.lsp.settings.dap'
  dap.setup()
  dap.load()
end)
require 'jdtls'.start_or_attach(config)
