JSON = {}

JSON.on_attach = require "lib.lsp.settings.attach".setup()

JSON.config = {
  settings = {
    json = {
      {
        fileMatch = { "/.github/workflows/*" },
        url = "https://json.schemastore.org/github-workflow.json",
      },
    },
  },
}

return JSON
