local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	vim.notify("Plugin Error: can't find lualine plugin")
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
		disabled_filetypes = {},
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(str)
					return str:sub(1, 1) .. string.lower(str:sub(2, #str))
				end,
			},
		},
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			"filename",
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress", "location" },
		lualine_z = { "windows" },
	},
	winbar = {},
	extensions = { "neo-tree", "toggleterm", "mason", "lazy", "symbols-outline", "fzf", "quickfix", "trouble" },
})
