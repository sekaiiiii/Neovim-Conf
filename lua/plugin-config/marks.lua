local marks_keys = require("keymaps.plugins").marks()

require("marks").setup(vim.tbl_extend("force", {
	-- builtin_marks = { ".", "<", ">", "^" },
	cyclic = true,
	force_write_shada = false,
	refresh_interval = 250,
	sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
	excluded_filetypes = {
		"qf",
		"neo-tree",
		"toggleterm",
		"TelescopePrompt",
		"alpha",
		"netrw",
	},
	bookmark_0 = {
		sign = "",
		virt_text = "hello world",
		annotate = false,
	},
}, marks_keys))
