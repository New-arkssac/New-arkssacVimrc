P = {}
local uv = vim.loop

local projectInitialization = function(file, cmd, args, title)

  if vim.fn.filereadable(file) ~= 0 then
    vim.notify(file .. " Already exists!!", "warn", { title = title })
    return
  else

    local stdout = vim.loop.new_pipe()
    local stderr = vim.loop.new_pipe()
    local flag = true
    local handle

    handle = vim.loop.spawn(cmd, { args = args, stdio = { nil, stdout, stderr } },
      vim.schedule_wrap(function()
        stdout:close()
        stderr:close()
        handle:close()
        if flag then
          vim.notify(file .. " create finish!", "info", { title = title })
        end
        handle, stderr, stdout = nil, nil, nil
      end))

    vim.loop.read_start(stdout, function(err, data)
      assert(not err, err)
      if data ~= nil then
        flag = false
        vim.notify(data)
      end
    end)

    vim.loop.read_start(stderr, function(err, data)
      assert(not err, err)
      if data ~= nil then
        flag = false
        vim.notify(data, "info")
      end
    end)

  end
end

local pythonInitialization = {
  { ".vimspector.json", "cp", { G.vimrc .. "/Example/py/vimspector-python.json", "./.vimspector.json" }, G.language.python },
  { "venv", "mkdir", { "venv" }, G.language.python },
  { "venv/bin/python", "python3", { "-m", "venv", "./venv" }, G.language.python }
}

local golangInitialization = {
  { ".vimspector.json", "cp", { G.vimrc .. "/Example/go/vimspector-go.json", "./.vimspector.json" }, G.language.golang },
  { "go.mod", "go", {"mod", "init", vim.split(vim.fn.system("basename `pwd`"), "\n")[1]}, G.language.golang}
}

local clangInitialization = {
  { ".vimspector.json", "cp", { G.vimrc .. "/Example/c/vimspector-c.json", "./.vimspector.json" }, G.language.clang },
}

local projectType = {
  python = pythonInitialization,
  go = golangInitialization,
  c = clangInitialization
}

local start = function()
  local ft = vim.bo.filetype
  local t = projectType[ft]
  for _, value in pairs(t) do
    projectInitialization(value[1], value[2], value[3], value[4])
  end
end

P.projectInitialization = start

return P
