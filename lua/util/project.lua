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
  { ".vimspector.json", "cp", { G.vimrc .. "/Example/py/vimspector-python.json", "./.vimspector.json" },
    G.language.python },
  { "venv", "mkdir", { "venv" }, G.language.python },
  { "venv/bin/python", "python3", { "-m", "venv", "./venv" }, G.language.python }
}

local golangInitialization = {
  { ".vimspector.json", "cp", { G.vimrc .. "/Example/go/vimspector-go.json", "./.vimspector.json" }, G.language.golang },
  { "go.mod", "go", { "mod", "init", vim.split(vim.fn.system("basename `pwd`"), "\n")[1] }, G.language.golang }
}

local clangInitialization = {
  { ".vimspector.json", "cp", { G.vimrc .. "/Example/c/vimspector-c.json", "./.vimspector.json" }, G.language.clang },
}

local pythonMain = {
  { 1, "#! venv/bin/python" },
  { 2, "# -*- coding:utf-8 -*-" },
  { 3, "" },
  { 4, "import requests" },
  { 5, "" },
  { 6, "" },
  { 7, "def main():" },
  { 8, [[    response = requests.get("https://www.baidu.com")]] },
  { 9, [[    print(response.text)]] },
  { 10, "" },
  { 11, "" },
  { 12, [[if __name__ == "__main__":]] },
  { 13, "    main()" },
}

local golangMain = {
  { 1, "package main" },
  { 2, "" },
  { 3, [[import "fmt"]] },
  { 4, "" },
  { 5, "func main() {" },
  { 6, [[	fmt.Println("hello Neovim!!")]] },
  { 7, "}" },
}

local clangMain = {
  { 1, [[#include "stdio.h"]] },
  { 2, "" },
  { 3, "int main() {" },
  { 4, [[  printf("hello Neovim\n");]] },
  { 5, "  return 0;" },
  { 6, "}" },
}

local projectType = {
  python = pythonInitialization,
  go = golangInitialization,
  c = clangInitialization
}

local projectMain = {
  py = pythonMain,
  go = golangMain,
  c = clangMain,
}

local start = function()
  local ft = vim.bo.filetype
  local t = projectType[ft]
  for _, value in pairs(t) do
    projectInitialization(value[1], value[2], value[3], value[4])
  end
end

P.newProject = function(dir, n, suffix)
  local file = io.open(dir, "r")
  if file == nil then
    vim.fn.system("mkdir " .. dir)
  else
    dir = G.projectpath .. n
    P.newProject(dir, n + 1, suffix)
    file:close()
    return
  end

  vim.fn.system("cd ./" .. dir)
  vim.cmd("cd ./" .. dir)
  vim.cmd("edit main." .. suffix)
  for _, value in pairs(projectMain[suffix]) do
    vim.fn.setline(value[1], value[2])
  end
  P.projectInitialization()
end

P.projectInitialization = start

return P
