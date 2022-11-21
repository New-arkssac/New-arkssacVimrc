I = {}

local command = {
    ["linux"] = { "xclip", "xclip -sel -c -t image/png -o > %s" },
    ["windows"] = { "powershell", "powershell.exe (Get-Clipboard -Format Image).Save('%s/%s.png')" },
}

local errMag = {
    ["linux"] = "Please check whether xclip is in your path",
    ["windows"] = "Please check whether powershell is in your path"
}

local function handle()
    if command[G.system] == nil then
        return false, "Can't use the " .. G.os .. " OS clipboard"
    end

    if vim.fn.executable(command[G.system][1]) ~= 1 then
        return false, errMag[G.system]
    end
    return true, command[G.system][2]
end

local function saveImage()

    local ok, cmd = handle()
    if not ok then
        vim.notify(cmd)
        return nil
    end

    if vim.fn.isdirectory(G.imagepath) then
        vim.fn.system("mkdir " .. G.imagepath)
    end

    local filename = G.imagepath .. "/" .. os.date("%Y%m%d%H%M%S") .. ".png"
    local path = string.format(cmd, filename)
    local msg = vim.fn.system(path)
    if #msg ~= 0 then
        vim.notify(msg)
        return nil
    end

    return filename
end

local function upload()
    local path = saveImage()
    if path == nil then
        return
    end
    local args = {
        "--location",
        "--request", "POST", G.url,
        "--header",
        "User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36",
        "--form", string.format([[file[]=@"%s"]], path)
    }
    local cmd
    local stdout = vim.loop.new_pipe()
    local stderr = vim.loop.new_pipe()
    local flag = true
    cmd = vim.loop.spawn("curl", { args = args, stdio = { nil, stdout, stderr } },
        vim.schedule_wrap(function()
            stdout:close()
            stderr:close()
            cmd:close()
            cmd, stderr, stdout = nil, nil, nil
        end))
    vim.loop.read_start(stdout, vim.schedule_wrap(function(err, data)
        assert(not err, err)
        if data ~= nil then
            data = data:match("https://.+%.png")
            Past(data)
        end
    end))

    vim.loop.read_start(stderr, function(err, data)
        assert(not err, err)
        if data ~= nil then
            vim.notify(data, "info")
        end
    end)
end

function Past(data)
    if data == nil then
        return
    end

    local lineString = vim.fn.getline(".")
    if lineString == "" then
        vim.fn.setline(".", " ")
    end

    local getcolnum = vim.fn.getcurpos()
    local col = getcolnum[3]
    local perfix, suffix = lineString:sub(1, col), lineString:sub(col + 1, -1)
    local pastLine = perfix .. data .. suffix
    vim.fn.setline(".", pastLine)
end

function I:PastUpload()
    upload()
end

function I:PastImage()
    Past(saveImage())
end

vim.cmd [[command! PastUpload :lua I:PastUpload()]]
vim.cmd [[command! PastImage :lua I:PastImage()]]

return I

