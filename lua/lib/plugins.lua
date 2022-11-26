local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- autocmd BufWritePost plugins.lua source <afile> | PackerSync
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    autocmd BufWritePost plugins.lua source <afile> | PackerClean
    autocmd BufWritePost plugins.lua source <afile> | PackerInstall
  augroup end
]])


local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return packer.startup(function(use)

  use 'wbthomason/packer.nvim'
  -- theme
  use 'nvim-lualine/lualine.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'SmiteshP/nvim-navic'

  -- code lsp cmp
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-nvim-lua'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'RRethy/vim-illuminate'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use 'jose-elias-alvarez/null-ls.nvim'

  -- LusSnip
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"

  -- Nvim-tree
  -- use {'nvim-tree/nvim-tree.lua', config = require("")}
  use { 'nvim-tree/nvim-tree.lua', config = function()
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
      callback = function(args)
        if vim.fn.expand "%:p" ~= "" then
          vim.api.nvim_del_autocmd(args.id)
          vim.cmd "noautocmd NvimTreeOpen"
          vim.schedule(function()
            vim.cmd "wincmd p"
          end)
        end
      end,
    })
  end }

  -- icon
  use { 'nvim-tree/nvim-web-devicons', config = function()
    require("nvim-web-devicons").set_icon {
      java = {
        icon = "",
        color = "#ae0014",
        cterm_color = "red",
        name = "java"
      }
    }
  end }

  -- go.nvim
  use { 'ray-x/go.nvim', ft = "go", config = function()
    require "go".setup()
  end }
  -- use 'mfussenegger/nvim-dap'
  use { 'rcarriga/nvim-dap-ui',
    requires = {
      "mfussenegger/nvim-dap",
      "theHamsta/nvim-dap-virtual-text"
    },
    ft = { "go", "python", "lua", "c", "cpp", "java", "json" },
    -- config = function ()
    -- require "lib.dap"
    -- end
  }

  -- java.nvim
  use {
    'mfussenegger/nvim-jdtls',
    ft = "java",
    config = function()
      local java_ok = pcall(require, "lib.lsp.settings.java")
      if not java_ok then
        return
      end
      -- require "lib.lsp.java"
    end
  }

  use 'lewis6991/gitsigns.nvim'
  -- trouble
  use { 'folke/trouble.nvim', config = function() require("trouble").setup {} end }

  -- notify
  use 'rcarriga/nvim-notify'
  -- alpha.vim
  use 'goolord/alpha-nvim'

  -- fzf
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'

  -- vim-markdown
  use { 'mzlogin/vim-markdown-toc', ft = { "vimwiki", "markdown" } }
  use { 'dhruvasagar/vim-table-mode', ft = { "vimwiki", "markdown" } }
  use({ "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    config = function() require "lib.markdown" end,
    ft = { "vimwiki", "markdown" } })
  use { 'vimwiki/vimwiki', ft = { "vimwiki", "markdown" } }

  -- async
  use { 'skywind3000/asynctasks.vim', ft = { "go", "python", "lua", "c", "cpp", "java" } }
  use { 'skywind3000/asyncrun.vim', ft = { "go", "python", "lua", "c", "cpp", "java" } }

  -- vimspector
  -- use { 'puremourning/vimspector', ft = { "go", "python", "lua", "c", "cpp" }, run = function ()
  -- vim.cmd [[VimspectorInstall]]
  -- end }

  -- undotree
  use 'mbbill/undotree'

  -- vista.vim
  use { 'liuchengxu/vista.vim', config = function()
    require "lib.vista"
  end }

  -- vim translator
  use 'voldikss/vim-translator'

  -- plenary.nvim
  use 'nvim-lua/plenary.nvim'

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
