-- setup cmp
local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local icon = {
    Folder = "\u{f07c}",
    File = "\u{f15c}",
    Value = "\u{f27d}",
    Text = "",
    Interface = "\u{f287}",
    EnumMember = "\u{f175}",
    Event = "\u{f12a}",
    Operator = "\u{f162}",
    Keyword = "\u{f02e}",
    Reference = "\u{f044}",
    Snippet = "\u{f121}",
    Unit = "\u{f032}",
    Color = "\u{f1fc}",
    Subroutine = "\u{f247}",
    Method = "\u{f1b2}",
    Func = "\u{f09a}",
    Variables = "\u{f1b2}",
    Constructor = "\u{f2b8}",
    Field = "\u{f1cb}",
    Interfac = "\u{f1e6}",
    Type = "\u{f173}",
    Packages = "\u{f1c4}",
    Property = "\u{f155}",
    Implementation = "\u{f111}",
    Default = "",
    Augroup = "\u{f248}",
    Macro = "\u{f196}",
    Enumerator = "\u{f175}",
    Const = "\u{f08d}",
    Macros = "\u{f047}",
    Map = "\u{f03a}",
    Fields = "\u{f056}",
    Functions = "\u{f09a}",
    Enum = "\u{f162}",
    Function = "\u{0192}",
    Target = "\u{f140}",
    Typedef = "\u{f174}",
    Namespace = "\u{f035}",
    Enummember = "\u{f063}",
    Variable = "\u{f1b2}",
    Modules = "",
    Constant = "\u{f08d}",
    Struct = "\u{f0e8}",
    Types = "\u{f174}",
    Module = "",
    TypeParameter = "\u{f174}",
    Package = "\u{f1c4}",
    Class = "\u{f085}",
    Member = "",
    Var = "\u{f1b2}",
    Union = "\u{f0ec}"
}
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<A-k>"] = cmp.mapping.select_prev_item(),
        ["<A-j>"] = cmp.mapping.select_next_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<A-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, { "i", "s", }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip', option = { show_autosnippets = true } },
        { name = 'buffer' },
        { name = 'path' },
    }),
    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
            vim_item.kind = string.format("%s", icon[vim_item.kind])
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Text]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
    },
    window = {
        completion = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
    },
    experimental = {
        ghost_text = true,
        native_menu = false,
    },
})
