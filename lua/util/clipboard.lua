I = {
  cliphistory = {},
  float = {}
}

local command = {
  ["linux"] = { "xclip", "xclip -sel c -t image/jpg -o > %s" },
  ["microsoft"] = { "powershell.exe", [[powershell.exe \(Get-Clipboard -Format Image\).Save\(\'%s\'\)]] },
  ["windows"] = { "powershell.exe", [[powershell.exe (Get-Clipboard -Format Image).Save('%s')]] },
}

local errMag = {
  ["linux"] = "Please check whether xclip is in your path",
  ["windows"] = "Please check whether powershell is in your path"
}

local function handle()
  if command[G.system] == nil then return false, "Can't use the " .. G.os .. " OS clipboard" end

  if vim.fn.executable(command[G.system][1]) ~= 1 then return false, errMag[G.system] end

  return true, command[G.system][2]
end

local function saveImage()

  local ok, cmd = handle()
  if not ok then
    vim.notify(cmd)
    return nil
  end

  if vim.fn.isdirectory(G.imagepath) then vim.fn.system("mkdir " .. G.imagepath) end

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
  if path == nil then return end

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

  cmd = vim.loop.spawn("curl", { args = args, stdio = { nil, stdout, stderr } },
    vim.schedule_wrap(function()
      stdout:close()
      stderr:close()
      cmd:close()
      cmd, stderr, stdout = nil, nil, nil
    end))
  stdout:read_start( vim.schedule_wrap(function(err, data)
    assert(not err, err)
    if data ~= nil then
      data = data:match("https://.+%.png")
      Past(data)
      HandleHistory(data)
    end
  end))

  stderr:read_start( function(err, data)
    assert(not err, err)
    if data ~= nil then vim.notify(data, "info") end
  end)
end

function HandleHistory(data)
  if #I.cliphistory == 5 then
    table.remove(I.cliphistory)

    for i = 5, 1, -1 do I.cliphistory[i] = "[" .. i .. "] " .. I.cliphistory[i - 1] end

    I.cliphistory[1] = "[1] " .. data
    return
  end

  table.insert(I.cliphistory, data)
end

function Past(data)
  if data == nil then return end

  local lineString = vim.fn.getline(".")

  if lineString == "" then vim.fn.setline(".", " ") end

  local getcolnum = vim.fn.getcurpos()
  local col = getcolnum[3]
  local perfix, suffix = lineString:sub(1, col), lineString:sub(col + 1, -1)
  local pastLine = perfix .. data .. suffix
  vim.fn.setline(".", pastLine)
end

local openClip = function(columns)
  local cols = #columns
  local width = 30
  local height = math.min(cols + 5, math.max(80, cols - 20))
  local top = 0
  local left = (cols - width) / 2
  local keymap = vim.api.nvim_buf_set_keymap
  local keymapOpt = { silent = true }
  local line = vim.fn.getcurpos()

  if line[3] < 20 then left = left + 10 end

  local opt = { relative = "cursor", row = top, col = left, width = width, height = height, style = 'minimal',
    focusable = false }
  local topframe = "???" .. string.rep("???", width - 2) .. "???"
  local midframe = "???" .. string.rep(" ", width - 2) .. "???"
  local botframe = "???" .. string.rep("???", width - 2) .. "???"
  local frame = { topframe, string.rep(midframe, height - 2), botframe }
  local buf1 = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf1, 'modified', false)
  vim.api.nvim_buf_set_lines(buf1, 0, -1, false, frame)
  local win1 = vim.api.nvim_open_win(buf1, false, opt)
  local buf2 = vim.api.nvim_create_buf(false, true)
  opt.row = opt.row + 1
  opt.height = opt.height - 4
  opt.col = opt.col + 1
  opt.width = opt.width - 4
  opt.focusable = true
  vim.api.nvim_buf_set_lines(buf2, 0, -1, true, columns)
  vim.api.nvim_buf_set_option(buf2, 'modifiable', false)
  local win2 = vim.api.nvim_open_win(buf2, true, opt)
  vim.api.nvim_win_set_option(win2, 'number', true)
  I.float[1] = win1
  I.float[2] = win2

  keymap(buf2, "n", "q", ":lua I.close()<CR>", keymapOpt)
  keymap(buf2, "n", "<ENTER>", ":lua I:PastHistory()<CR>", keymapOpt)
  vim.cmd [[
    augroup float_close
      autocmd!
      autocmd BufLeave <buffer> lua I.close()
    augroup end
  ]]
end

function I:PastUpload()
  upload()
end

function I:PastHistory()
  local data = vim.fn.getline(".")
  I.close()
  Past(data)
end

function I:OpenClip()
  local columns = I.cliphistory
  if #columns == 0 then
    vim.notify("There's nothing in the Image clipboard", "warn")
    return
  end
  openClip(columns)
end

function I:PastImage()
  local data = saveImage()
  Past(data)
  HandleHistory(data)
end

I.close = function()
  if #I.float == 0 then return end

  for i, value in pairs(I.float) do
    vim.api.nvim_win_close(value, true)
    I.float[i] = nil
  end
end


vim.cmd [[command! PastUpload :lua I:PastUpload()]]
vim.cmd [[command! PastImage :lua I:PastImage()]]
vim.cmd [[command! OpenClip :lua I:OpenClip()]]

return I
