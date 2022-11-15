local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
require "lib.global"

dashboard.section.header.val = {
    "                                                                   ",
    " ██████╗ ██╗   ██╗██╗      █████╗ ██████╗ ██╗   ██╗██╗      █████╗ ",
    " ██╔══██╗██║   ██║██║     ██╔══██╗██╔══██╗██║   ██║██║     ██╔══██╗",
    " ██████╔╝██║   ██║██║     ███████║██████╔╝██║   ██║██║     ███████║",
    " ██╔══██╗██║   ██║██║     ██╔══██║██╔══██╗██║   ██║██║     ██╔══██║",
    " ██████╔╝╚██████╔╝███████╗██║  ██║██████╔╝╚██████╔╝███████╗██║  ██║",
    " ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝",
    "                                                                   ",
}

dashboard.section.buttons.val = {
    dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("f", "  > Find Go project file", ":Files " .. GOWORKEPATH .. "<CR>"),
    dashboard.button("f", "  > Find C project file", ":Files " .. CWORKPATH .. "<CR>"),
    dashboard.button("f", "  > Find Python project file", ":Files " .. PYTHONWORKPATH .. "<CR>"),
    dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
    dashboard.button("s", "  > Settings", ":e $MYVIMRC | :split .<CR>"),
    dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
}

alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
