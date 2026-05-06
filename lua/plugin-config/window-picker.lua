local M = {}

local picker = require("window-picker")

picker.setup({
	hint = "floating-big-letter",
	autoselect_one = true,
	include_current = false,
	filter_rules = {
		bo = {
			filetype = { "notify", "quickfix", "neo-tree", "help", "noice" },
			buftype = { "terminal" },
		},
	},
	other_win_hl_color = "#e35e4f",
})

function M.pick_window()
	local picked_window_id = picker.pick_window({
		include_current_win = false,
	}) or vim.api.nvim_get_current_win()
	vim.api.nvim_set_current_win(picked_window_id)
end

function M.swap_window()
	local window = picker.pick_window({
		include_current_win = false,
	})
	local target_buffer = vim.fn.winbufnr(window)
	-- Set the target window to contain current buffer
	vim.api.nvim_win_set_buf(window, 0)
	-- Set current window to contain target buffer
	vim.api.nvim_win_set_buf(0, target_buffer)
end

return M
