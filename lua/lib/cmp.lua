local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
    return
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
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
          -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    mapping = {
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<A-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<A-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
        },
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
      { name = 'path' },
    }),
    formatting = {
      fields = {"abbr", "kind", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = string.format("%s", icon[vim_item.kind])
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          vsnip = "[Snippet]",
          buffer = "[Text]",
          path = "[Path]",
        })[entry.source.name]
        return vim_item
      end,
    },
     window = {
       documentation = {
         border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
     },
    })
    -- "diagnostic.errorSign"= "\uf061",
    -- "diagnostic.warningSign"= "\uf071",
    -- "diagnostic.infoSign"= "\uf0d7",
    -- "diagnostic.hintSign"= "\uf0ec",
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
    })
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
    })
