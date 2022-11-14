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
    -- vim-airline
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    -- gruvbox
    use 'morhetz/gruvbox'
    -- onedark
    use 'joshdick/onedark.vim'
    -- code lsp cmp
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- LSP
    use 'neovim/nvim-lspconfig'
    -- use "williamboman/mason.nvim"
    -- use "williamboman/mason-lspconfig.nvim"
    -- Nvim-tree
    use 'nvim-tree/nvim-tree.lua'

    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
