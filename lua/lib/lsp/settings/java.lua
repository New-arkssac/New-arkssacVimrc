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
  }
};

  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
  require("jdtls.dap").setup_dap_main_class_configs()
  vim.lsp.codelens.refresh()
return config
