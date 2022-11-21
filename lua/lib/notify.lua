vim.notify = require("notify")
vim.notify.setup {
    fps = 60,
    icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        WARN = ""
    },
    minimum_width = 20,
    timeout = 3000,
}
