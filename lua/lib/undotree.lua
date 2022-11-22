if vim.fn.has("presistent_undo") then
    local target_path = vim.fn.expand('~/.config/nvim/.undodir')
    if vim.fn.isdirectory(target_path) then
        vim.fn.system("mkdir "..target_path)
        vim.cmd("call mkdir('"..target_path.."', 'p', 0700)")
    end

    vim.o.undodir= target_path
    -- vim.cmd "set undodir"
    vim.cmd("set undofile")
end
