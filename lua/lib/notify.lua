vim.notify = require("notify")
vim.notify.setup {
    fps = 60,
    icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        WARN = ""
    },
    minimum_width = 40,
    timeout = 3000,
}
