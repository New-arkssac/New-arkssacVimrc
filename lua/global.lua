---@diagnostic disable: need-check-nil
G = {}

local home = os.getenv("HOME")
local pwd = vim.fn.getcwd()
local folder = vim.split(vim.fn.system("basename `pwd`"), "\n")[1]
local recentpath = vim.fn.stdpath("data")
local vimrc = home .. "/.config/nvim"

G.url = "https://fishpi.cn/upload"
G.projectpath = "project"
G.imagepath = "img"
G.home = home
G.pwd = pwd
G.folder = folder
G.recentpath = recentpath
G.vimrc = vimrc
G.icons = {
    linux = {
        ["kali"] = " ",
        ["linux"] = " ",
        ["Ubuntul"] = " ",
        ["Normal"] = " "
    },
    mac = {
        ["Darwin"] = " "
    },
    windows = {
        ["Windows"] = " ",
    },
    wsl = {
        ["microsoft"] = " "
    }
}

G.language = {
  python = "Python Notify",
  golang = "Golang Notify",
  clang = "Clang Notify"
}

G.release = {
    "kali",
    "Ubuntu",
    "microsoft",
}
local system = {
  kali = "linux",
  Ubuntu = "linux",
  Normal = "linux",
  microsoft = "wsl",
  win32 = "windows",
  Darwin = "mac"
}

local getOs = function()
    if vim.fn.has "win32" == 1 then
        return "win32", system["win32"]
    end

    if vim.fn.has("Darwin") == 1 then
        return "Darwin", system["Darwin"]
    end

    local osMessage
    if vim.fn.has "linux" ~= 1 then
        return "Normal", "linux"
    else
        for _, value in pairs(G.release) do
            osMessage = vim.fn.system("cat /proc/version")
            if osMessage:match(value) ~= nil then
                return value, system[value]
            end
        end
    end
    return "linux", "linux"
end


G.os,G.system = getOs()
return G
