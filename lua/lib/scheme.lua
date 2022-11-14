local scheme = "gruvbox"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. scheme)
if not status_ok then
    print("colorscheme "..scheme.." not found!")
else
    vim.cmd[[
        highlight Visual cterm=italic,bold
        highlight Comment cterm=italic
    ]]
end
local status_ok, _ = pcall(vim.cmd, "let g:airline_theme='"..scheme.."'")
if not status_ok then
    print("airline theme "..scheme.." not found!")
else
    vim.cmd [[
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_alt_sep = ''
    ]]
end
