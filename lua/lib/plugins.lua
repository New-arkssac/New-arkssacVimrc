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

-- autocmd BufWritePost plugins.lua source <afile> | PackerClean
-- autocmd BufWritePost plugins.lua source <afile> | PackerInstall
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
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
    use { 'akinsho/bufferline.nvim', tag = "v3.*" }
    use 'EdenEast/nightfox.nvim'
    -- code lsp cmp
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'RRethy/vim-illuminate'
    use 'nvim-treesitter/nvim-treesitter'
    use 'jose-elias-alvarez/null-ls.nvim'

    -- LusSnip
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"

    -- Nvim-tree
    -- use {'nvim-tree/nvim-tree.lua', setup = require("lib.nvimtree")}
    use { 'nvim-tree/nvim-tree.lua' }

    -- icon
    use 'nvim-tree/nvim-web-devicons'

    -- go.nvim
    use { 'ray-x/go.nvim', ft = "go", config = function()
        require "go".setup()
        require("util.libproject")
    end }

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
    -- use { 'preservim/vim-markdown', ft = "md" }
    use { 'dhruvasagar/vim-table-mode', ft = { "markdown"} }
    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install",
        config = function() require "lib.markdown" end, ft = { "markdown" }})
    -- async
    use { 'skywind3000/asynctasks.vim', ft = { "go", "python", "lua", "c", "cpp" } }
    use { 'skywind3000/asyncrun.vim', ft = { "go", "python", "lua", "c", "cpp" }}

    -- vimspector
    use { 'puremourning/vimspector', ft = { "go", "python", "lua", "c", "cpp" }}

    -- undotree
    use 'mbbill/undotree'

    -- vista.vim
    use { 'liuchengxu/vista.vim',  config = function()
        require "lib.vista"
    end }
    -- use 'liuchengxu/vista.vim'

    -- vim translator
    use 'voldikss/vim-translator'

    -- plenary.nvim
    use 'nvim-lua/plenary.nvim'

    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
