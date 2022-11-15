local scheme = "nordfox"

require('nightfox').setup({
    options = {
        -- Compiled file's destination location
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled", -- Compiled file suffix
        transparent = false, -- Disable setting background
        terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive = false, -- Non focused panes set to alternative background
        module_default = true, -- Default enable value for modules
        styles = { -- Style to be applied to different syntax groups
            comments = "italic", -- Value is any valid attr-list value `:help attr-list`
            conditionals = "bold",
            constants = "NONE",
            functions = "bold",
            keywords = "bold",
            numbers = "italic",
            operators = "NONE",
            strings = "italic",
            types = "bold",
            variables = "NONE",
        },
        inverse = { -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
        },
        modules = { -- List of various plugins and additional options
            -- ...
        },
    },
    palettes = {},
    specs = {},
    groups = {},
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. scheme)
if not status_ok then
    print("colorscheme " .. scheme .. " not found!")
else
    vim.cmd [[
        highlight Visual cterm=italic,bold
        highlight Comment cterm=italic
        set background=dark
    ]]
end

require("bufferline").setup {}

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
-- local airline_ok, _ = pcall(vim.cmd, "let g:airline_theme='" .. scheme .. "'")
-- if not airline_ok then
-- print("airline theme " .. scheme .. " not found!")
-- else
-- vim.cmd [[
-- let g:airline#extensions#tabline#enabled = 1
-- let g:airline#extensions#tabline#left_alt_sep = ''
-- ]]
-- end
