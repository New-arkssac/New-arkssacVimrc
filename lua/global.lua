local home = os.getenv("HOME")
local pwd = vim.fn.getcwd()
local folder = vim.split(vim.fn.system("basename `pwd`"), "\n")[1]
local recentpath = vim.fn.stdpath("data")
local vimrc = home .. "/.config/nvim"

G = {
    home = home,
    pwd = pwd,
    folder = folder,
    recentpath = recentpath,
    vimrc = vimrc
}

return G
