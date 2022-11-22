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
        ["Normal"] = " "
    },
    mac = {
        ["Darwin"] = " "
    },
    windows = {
        ["Windows"] = " ",
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

local getOs = function()
    if vim.fn.has "win32" == 1 then
        return "Windows", "windows"
    end

    if vim.fn.has("Darwin") == 1 then
        return "Darwin", "mac"
    end

    local osMessage
    if vim.fn.has "linux" ~= 1 then
        return "Normal", "linux"
    else
        for _, value in pairs(G.release) do
            osMessage = vim.fn.system("cat /proc/version")
            if osMessage:match(value) ~= nil then
                return value, "linux"
            else
                return "linux", "linux"
            end
        end
    end
end

G.os,G.system = getOs()
return G
