-- local scheme = "gruvbox"
-- local scheme = "dawnfox"
-- local scheme = "meliora"
local scheme = "kanagawa"

local scheme_setup = {
  ["nightfox"] = function()
    require('nightfox').setup({
      options = {
        compile_path        = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled", -- Compiled file suffix
        transparent         = false, -- Disable setting background
        terminal_colors     = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive        = false, -- Non focused panes set to alternative background
        module_default      = true, -- Default enable value for modules
        styles              = { -- Style to be applied to different syntax groups
          comments = "italic", -- Value is any valid attr-list value `:help attr-list`
          conditionals = "bold",
          constants = "NONE",
          functions = "bold",
          keywords = "bold",
          numbers = "italic",
          operators = "NONE",
          strings = "NONE",
          types = "bold",
          variables = "NONE",
        },
        inverse             = { -- Inverse highlight for different types
          match_paren = false,
          visual = true,
          search = false,
        },
      },
    })
  end,
  ["dawnfox"] = function()
    require('nightfox').setup({
      options = {
        compile_path        = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled", -- Compiled file suffix
        transparent         = false, -- Disable setting background
        terminal_colors     = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive        = false, -- Non focused panes set to alternative background
        module_default      = true, -- Default enable value for modules
        styles              = { -- Style to be applied to different syntax groups
          comments = "italic", -- Value is any valid attr-list value `:help attr-list`
          conditionals = "bold",
          constants = "NONE",
          functions = "bold",
          keywords = "bold",
          numbers = "italic",
          operators = "NONE",
          strings = "NONE",
          types = "bold",
          variables = "NONE",
        },
        inverse             = { -- Inverse highlight for different types
          match_paren = false,
          visual = true,
          search = false,
        },
      },
    })
  end,
  ["gruvbox"] = function()
    vim.o.background = "dark"
    require("gruvbox").setup({
      undercurl = true,
      underline = true,
      bold = true,
      italic = true,
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "", -- can be "hard", "soft" or empty string
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
      palette_overrides = {
        bright_red = "#f86654"
      }
    })
  end,
  ["meliora"] = function()
    require 'meliora'.setup({
      dim_inactive = false,
      color_set = 'mountain',
      styles = {
        comments = 'italic',
        conditionals = 'NONE',
        folds = 'NONE',
        loops = 'NONE',
        functions = 'bold',
        keywords = 'bold',
        strings = 'NONE',
        variables = 'NONE',
        numbers = 'italic',
        booleans = 'NONE',
        properties = 'NONE',
        types = 'bold',
        operators = 'NONE',
      },
      transparent_background = {
        enabled = false,
        floating_windows = false,
        -- telescope = true,
        file_tree = true,
        cursor_line = true,
        status_line = false,
      },
      plugins = {
        cmp = true,
        indent_blankline = true,
        nvim_tree = {
          enabled = true,
          show_root = false,
        },
        -- telescope = {
        -- enabled = true,
        -- nvchad_like = true,
        -- },
        startify = true,
      },
    })
  end,
  ["kanagawa"] = function()
    require('kanagawa').setup({
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      variablebuiltinStyle = { italic = true },
      specialReturn = true, -- special highlight for the return keyword
      specialException = true, -- special highlight for exception handling keywords
      transparent = false, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      globalStatus = false, -- adjust window separators highlight for laststatus=3
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = {},
      overrides = {},
      theme = "default" -- Load "default" theme or the experimental "light" theme
    })
  end
}

local setup = scheme_setup[scheme]
if not setup then return end

setup()

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. scheme)
if not status_ok then print("colorscheme " .. scheme .. " not found!") end

local lspname = function()
  local msg = 'No Active Lsp'
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()

  if next(clients) == nil then return msg end

  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes

    if client.config.name == "null-ls" then goto continue end
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then return client.config.name end

    ::continue::
  end
  return msg
end

local getdate = function()
  return os.date("%Y???%m???%d??? %H:%M:%S")
end


local bar = function()
  -- local sbar = { '???', '???', '???', '???', '???', '???', '???', '???' }
  -- local sbar = { '???', '???', '???', '???', '???', '???', '???', '???', '???', '???', '???' }
  -- local sbar = { '???', '???','???', '???', '???', '???', '???', '???', '???', '???', '???', '???', '???' }
  local sbar = { '???? ', '???? ', '???? ', '???? ', '???? ', '???? ', '???? ', '???? ', '???? ' }
  local curr_line = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_line_count(0)
  local i = math.floor((curr_line - 1) / lines * #sbar) + 1
  return string.rep(sbar[i], 1)
end

local workDir = function()
  local icon = (vim.fn.haslocaldir(0) == 1 and "l" .. " " .. "??? " or "g" .. " " .. "??? ")
  local cwd = vim.fn.getcwd(0)
  cwd = vim.fn.fnamemodify(cwd, ":~")
  local trail = cwd:sub(-1) == '/' and '' or "/"
  return icon .. cwd .. trail .. vim.fn.expand("%:t:p")
end

local navic = require("nvim-navic")
navic.setup {
  icons = {
    File          = "??? ",
    Module        = "??? ",
    Namespace     = "??? ",
    Package       = "??? ",
    Class         = "??? ",
    Method        = "??? ",
    Property      = "??? ",
    Field         = "??? ",
    Constructor   = "??? ",
    Enum          = "???",
    Interface     = "???",
    Function      = "??? ",
    Variable      = "??? ",
    Constant      = "??? ",
    String        = "??? ",
    Number        = "??? ",
    Boolean       = "??? ",
    Array         = "??? ",
    Object        = "??? ",
    Key           = "??? ",
    Null          = "??? ",
    EnumMember    = "??? ",
    Struct        = "??? ",
    Event         = "??? ",
    Operator      = "??? ",
    TypeParameter = "??? ",
  },
  highlight = true,
  separator = " ??? ",
  depth_limit = 0,
  depth_limit_indicator = "..",
  safe_output = true
}

local hl = {
  { 0, "NavicIconsFile", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsModule", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsNamespace", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsPackage", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsClass", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsMethod", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsProperty", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsField", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsConstructor", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsEnum", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsInterface", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsFunction", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsVariable", { default = true, bg = "#232831", fg = "#b8babd" } },
  { 0, "NavicIconsConstant", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsString", { default = true, bg = "#232831", fg = "#9eb889" } },
  { 0, "NavicIconsNumber", { default = true, bg = "#232831", fg = "#c37f6a" } },
  { 0, "NavicIconsBoolean", { default = true, bg = "#232831", fg = "#c37f6a" } },
  { 0, "NavicIconsArray", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsObject", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsKey", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsNull", { default = true, bg = "#232831", fg = "#c37f6a" } },
  { 0, "NavicIconsEnumMember", { default = true, bg = "#232831", fg = "#c37f6a" } },
  { 0, "NavicIconsStruct", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsEvent", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsOperator", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicIconsTypeParameter", { default = true, bg = "#232831", fg = "#b48ead" } },
  { 0, "NavicText", { default = true, bg = "#232831", fg = "#b8babd" } },
  { 0, "NavicSeparator", { default = true, bg = "#232831", fg = "#b48ead" } },
}

for i = 1, #hl do vim.api.nvim_set_hl(hl[i][1], hl[i][2], hl[i][3]) end

require('lualine').setup {
  options = {
    theme                = "auto",
    icons_enabled        = true,
    component_separators = { left = '???', right = '???' },
    section_separators   = { left = '???', right = '???' },
    separator            = { left = "???", right = "???" },
    disabled_filetypes   = {
      statusline = {},
      winbar = {},
    },
    ignore_focus         = {},
    always_divide_middle = true,
    globalstatus         = false,
    refresh              = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { { 'mode', icon = G.info[G.system][G.os].icon, } },
    lualine_b = { { 'branch', icon = "??? ", color = { fg = "#e94d34" } },
      {
        'diff',
        symbols = { added = '??? ', modified = '??? ', removed = '??? ' },
      },
      'diagnostics'
    },
    lualine_c = { { workDir, color = { fg = "#81a1c1" } } },
    lualine_x = {
      {
        lspname,
        icon = "???  LSP:",
        color = { fg = "#131a24", bg = G.ftcolor },
      },
      { 'filetype',
        color = { bg = "#000000", fg = G.ftcolor, bold = true }
      },
      {
        'encoding',
        icon = "???",
        color = { bg = "#baa1e2", fg = "#131a24" }
      },
      {
        'fileformat',
        color = { bg = G.info[G.system]["color"], fg = "#131a24" }
      },
    },
    lualine_y = { 'progress', { bar, color = { fg = G.ftcolor } } },
    lualine_z = { 'location' }
  },
  tabline = {
    lualine_a = {
      {
        'buffers',
        mode          = 2, -- 0: Shows buffer name
        icons_enabled = true,
        max_length    = vim.o.columns * 2 / 3,
        symbols       = {
          modified = ' ???', -- Text to show when the buffer is modified
          alternate_file = '??? ', -- Text to show to identify the alternate file
          directory = '??? ', -- Text to show when the buffer is a directory
        },
      },
    },
    lualine_c = {
      { navic.get_location, cond = navic.is_available,
        separator = { right = "" },
      }
    },
    lualine_x = {
      { getdate,
        color = { fg = "#131a24", bg = G.ftcolor },
      }
    }
  },
  extensions = { 'quickfix', 'fzf', 'nvim-tree' }
}
