--  __  ____   ____     _____ __  __ ____   ____
-- |  \/  \ \ / /\ \   / /_ _|  \/  |  _ \ / ___|
-- | |\/| |\ V /  \ \ / / | || |\/| | |_) | |
-- | |  | | | |    \ V /  | || |  | |  _ <| |___
-- |_|  |_| |_|     \_/  |___|_|  |_|_| \_\\____|
--

-- Author:@New-arkssac

G = require "global"
M = require "util.comment"
P = require "util.project"
require "lib.options"
require "lib.keymaps"
require "lib.plugins"
require "lib.notify"
require "util.asynctasks"
require "util.vimspector"
require "lib.undotree"
require "lib.nvimtree"
require "lib.scheme"
require "lib.gitsigns"
require "lib.treesitter"
require "lib.alpha"
require "lib.cmp"
require "lib.lsp"
require "lib.translator"

vim.cmd "nohlsearch"
