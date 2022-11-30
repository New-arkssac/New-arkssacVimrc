G = {}

local home = os.getenv("HOME")
local pwd = vim.fn.getcwd()
local folder = vim.split(vim.fn.system("basename `pwd`"), "\n")[1]
local recentpath = vim.fn.stdpath("data")
local vimrc = home .. "/.config/nvim"
local icon, color = require("nvim-web-devicons").get_icon_color(vim.fn.expand("%:e"))


G.fticon = icon
G.ftcolor = color
G.url = "https://fishpi.cn/upload"
G.projectpath = "project"
G.imagepath = "img"
G.home = home
G.pwd = pwd
G.folder = folder
G.recentpath = recentpath
G.vimrc = vimrc

G.info = {
  linux = {
    ["kali"] = { icon = " ", cmd = {
      terminal = "gnome-terminal",
      dapargs = { "--", G.home .. '/.local/share/nvim/mason/bin/dlv', "debug", "--listen=127.0.0.1:38697", "--headless",
        "--log", "--api-version=2", "--accept-multiclient" },
    }
    },
    ["linux"] = { icon = " ", cmd = {
      terminal = "gnome-terminal",
      dapargs = { "--", G.home .. '/.local/share/nvim/mason/bin/dlv', "debug", "--listen=127.0.0.1:38697", "--headless",
        "--log", "--api-version=2", "--accept-multiclient" },
    }
    },
    ["Ubuntul"] = { icon = " ", cmd = {
      terminal = "gnome-terminal",
      dapargs = { "--", G.home .. '/.local/share/nvim/mason/bin/dlv', "debug", "--listen=127.0.0.1:38697", "--headless",
        "--log", "--api-version=2", "--accept-multiclient" },
    },
    },
    ["color"] = "#f3b416"
  },
  mac = {
    ["Darwin"] = " ",
    ["color"] = "#4b63c6"
  },
  windows = {
    ["Windows"] = { icon = " ", cmd = {
      terminal = "start",
      dapargs = { "dlv", "debug", "--listen=127.0.0.1:38679", "--headless",
        "--log", "--api-version=2", "--accept-multiclient" },
    }
    },
    ["color"] = "#f0652b"
  },
  wsl = {
    ["microsoft"] = { icon = " ", cmd = {
      terminal = "cmd.exe",
      dapargs = { "start", "dlv", "debug", "--listen=127.0.0.1:38679", "--headless",
        "--log", "--api-version=2", "--accept-multiclient" },
    }
    },
    ["color"] = "#7aad01"
  },
  Normal = {
    ["Normal"] = { icon = " ", cmd = {
      terminal = "gnome-terminal",
      dapargs = { "--", G.home .. '/.local/share/nvim/mason/bin/dlv', "debug", "--listen=127.0.0.1:38697", "--headless",
        "--log", "--api-version=2", "--accept-multiclient" },
    }
    },
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
local server = {
  lua = "sumneko_lua",
  go = "gopls",
  json = "jsonls",
  -- java = "jdtls",
  python = "pyright",
  c = "clangd",
  cpp = "clangd"
}

G.lspserver = server

local getOs = function()
  if vim.fn.has "win32" == 1 then return "win32", system["win32"] end

  if vim.fn.has("Darwin") == 1 then return "Darwin", system["Darwin"] end

  local osMessage
  if vim.fn.has "linux" ~= 1 then return "Normal", "Normal"
  else
    for _, value in pairs(G.release) do
      osMessage = vim.fn.system("cat /proc/version")
      if osMessage:match(value) ~= nil then return value, system[value] end
    end
  end
  return "linux", "linux"
end

G.os, G.system = getOs()

local lib = {
  "lib.plugins",
  "lib.notify",
  "util.asynctasks",
  "lib.undotree",
  "lib.nvimtree",
  "lib.scheme",
  "lib.gitsigns",
  "lib.treesitter",
  "lib.alpha",
  "lib.cmp",
  "lib.translator",
  "lib.lsp",
}

G.setup = function()
  for i = 1, #lib do require(lib[i]) end
end

return G
