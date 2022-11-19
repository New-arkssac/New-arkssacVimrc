
local uv = vim.loop

local startInit = function(files, cmd, args, ft, msg)
    local title = ft .. "Notify"
    local file = io.open(files, "r")
    if file ~= nil then
        vim.notify(files .. " " .. "Already exists!", "warn", { title = title })
        return
    end
    local handle
    local stdout = uv.new_pipe()
    local stderr = uv.new_pipe()
    local flag = false
    handle = uv.spawn(cmd, { args = args, stdio = { nil, stdout, stderr } },
        vim.schedule_wrap(function()
            stdout:close()
            stderr:close()
            handle:close()
            handle, stderr, stdout = nil, nil, nil
        end)
    )

    uv.read_start(stderr, function(err, data)
        assert(not err, err)
        if data ~= nil then
            flag = true
            vim.notify(data, "error", { title = title })
        end
    end)

    uv.read_start(stdout, function(err, data)
        assert(not err, err)
        if data ~= nil then
            vim.notify(ft .. " " .. data .. " Finish!", "info", { titile = title })
        elseif not flag then
            vim.notify(ft .. " " .. msg .. " Finish!", "info", { titile = title })
        end
    end)

end


local pythonArgs = {
    { "venv", "mkdir", { "venv" }, "Python", "Creade Venv Folder" },
    { "venv/bin/python", "python3", { "-m", "venv", "./venv" }, "Python", "Creade Python Venv" },
    { ".vimspector.json", "cp", { G.home .. "/.config/nvim/Example/py/vimspector-python.json", "./.vimspector.json" },
        "Python",
        "Debug Set" },
    { "venv/bin/python", "venv/bin/pip", { "install", "yapf" }, "Python", "Yapf install" },
}

local golangArgs = {
    { ".vimspector.json", "cp", { G.home .. "/.config/nvim/Example/go/vimspector-go.json", "./.vimspector.json" },
        "Golang", "Debug set" },
    { "go.mod", "go", { "mod", "init", G.folder }, "Golang", "Go mod init" },
}

local clangArgs = {
    { ".vimspector.json", "cp", { G.home .. "/.config/nvim/Example/c/vimspector-c.json", "./.vimspector.json" },
        "Golang", "Debug set" },
}


-- local project = { }
P = {
    go = golangArgs,
    python = pythonArgs,
    c = clangArgs,
}

function P:projectInitialization()
    local ft = vim.o.filetype
    local t = P[ft]
    if t == nil then
        vim.notify("Can't Initialization Project for "..ft, "warn", {title = "Project Notify"})
        return
    end
    for _, value in pairs(t) do
        startInit(value[1], value[2], value[3], value[4], value[5])
    end
end

function P:newProject (f, n, suffix)
    local file = io.open(f, "r")
    local path = f
    if file ~= nil then
        path = f..n
        P:newProject(path, n+1, suffix)
        return
    end
    vim.fn.system("mkdir "..path)
    vim.cmd("cd ./"..path)
    vim.cmd("edit main."..suffix)
    vim.cmd("r "..G.vimrc.."/Example/"..suffix.."/main")
    -- vim.cmd("lua vim.lsp.buf.format {async = true}")
    P:projectInitialization()
end

return P
