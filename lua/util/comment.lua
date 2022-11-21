M = {}

Symbol = {
    go = { [[\/\/]], { "^/*//", "^%s*//" } },
    c = { [[\/\/]], { "^/*//", "^%s*//" } },
    cpp = { [[\/\/]], { "^/*//", "^%s*//" } },
    python = { "#", { "^#", "^%s*#", } },
    lua = { "--", { "^%-*%-%-", "^%s*%-%-" } },
    vim = { "\"", { "^\"", "^%s*\"", } },
}


function M.comm()
    local s = Symbol[vim.o.filetype]
    if s == nil then
        return
    end
    local can = ""
    local line = vim.fn.line(".")
    local firstLine = vim.fn.getpos("'<")[2]
    local lastLine = vim.fn.getpos("'>")[2]
    local getline = vim.fn.getline(".")
    for i = 1, #s[2] do
        can = getline:match(s[2][i])
    end
    if can ~= nil then
        if line == firstLine then
            vim.cmd(tostring(firstLine) .. "," .. tostring(lastLine) .. "s/" ..[[\(]].. s[1] .. [[ \|]].. s[1].. [[\)]] .. "// | nohlsearch")
        else
            vim.cmd(tostring(line) .. "," .. tostring(line) .. "s/" ..[[\(]].. s[1] .. [[ \|]].. s[1].. [[\)]] .. "// | nohlsearch")
        end
    else
        if line == firstLine then
            vim.cmd(tostring(firstLine) ..
                "," .. tostring(lastLine) .. [[s/\(^\s*\)\@<=\(\s\)\@!/]] .. s[1] .. " " .. "/ | nohlsearch")
        else
            vim.cmd(tostring(line) ..
                "," .. tostring(line) .. [[s/\(^\s*\)\@<=\(\s\)\@!/]] .. s[1] .. " " .. "/ | nohlsearch")
        end
    end
    firstLine, lastLine, getline = "", "", ""
end

return M
