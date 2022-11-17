local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

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
    dashboard.button("g", "  > Find Go project file", ":Files " .. GOWORKEPATH .. "<CR>"),
    dashboard.button("c", "  > Find C project file", ":Files " .. CWORKPATH .. "<CR>"),
    dashboard.button("p", "  > Find Python project file", ":Files " .. PYTHONWORKPATH .. "<CR>"),
    dashboard.button("r", "  > Recent", ":History oldfile<CR>"),
    dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:h | :split .<CR>"),
    dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
}

alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
