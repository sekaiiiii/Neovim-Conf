local opts = require("keymaps.plugins").goto_preview()

require("goto-preview").setup(vim.tbl_extend("force", {
	width = 120,
	height = 25,
	debug = false,
	opacity = nil,
	post_open_hook = nil,
}, opts))
