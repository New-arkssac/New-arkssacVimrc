require("neorg").setup {
  -- configuration here
  load = {
    ["core.defaults"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          wiki = "~/wiki",
        }
      }
    },
    ["core.norg.concealer"] = {
      config = {
        icons = {
          todo = {
            pending = { icon = "" },
            cycle = { icon = "" },
            on_hold = { icon = "" },
            cycle_reverse = { icon = "" },
            cancelled = { icon = "ﰸ" },
            recurring = { icon = "螺" },
            done = { icon = "" },
            undone = { icon = "" },
          }
        }
      }
    },
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp"
      },
    },
    ["core.export"] = {}
  }
}
