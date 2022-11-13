local api = vim.api
local message = { "test" }
local buf = api["nvim_create_buf"](false, true)
local opts = {
	relative = "win",
	width = #"test",
	height = 1,
	col = 200 - #"test",
	row = 0,
	anchor = "NW",
	style = "minimal",
}
local win = api["nvim_open_win"](buf, 0, opts)

api["nvim_buf_set_lines"](buf, 0, -1, true, message)
vim.cmd([[hi def MyWarning ctermfg=red ctermbg=237]])
api["nvim_win_set_option"](win, "winhl", "Normal:MyWarning")
