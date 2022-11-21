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
    dashboard.button("g", "  > New Golang Project",
        ":lua P:newProject('" .. G.projectpath .. "', 1, 'go')<CR>:split . | wincmd w | w <CR>"),
    dashboard.button("c", "  > New Clang Project",
        ":lua P:newProject('" .. G.projectpath .. "', 1, 'c')<CR>:split . | wincmd w | w <CR>"),
    dashboard.button("p", "  > New Python Project",
        ":lua P:newProject('" .. G.projectpath .. "', 1, 'py')<CR>:split . | wincmd w | w <CR>"),
    dashboard.button("r", "  > Recent", ":History oldfile<CR>"),
    dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:h | :split .<CR>"),
    dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
}

alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
