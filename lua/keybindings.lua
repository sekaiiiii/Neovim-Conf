local config = require("config")

vim.g.mapleader = config.leader_key
vim.g.maplocalleader = config.leader_key

local M = {}

M.cmp_keys = {
	cmp_complete = "<A-.>",
	cmp_abort = "<A-,>",
	cmp_confirm = "<CR>",
	cmp_scroll_doc_up = "<C-e>",
	cmp_scroll_doc_down = "<C-y>",
	cmp_select_prev_item = "<S-Tab>",
	cmp_select_next_item = "<Tab>",
}

M.snip_keys = {
	snip_jump_next = "<C-j>",
	snip_jump_prev = "<C-k>",
	snip_next_choice = "<C-h>",
	snip_prev_choice = "<C-l>",
}

M.lsp_keys = {
	rename = "<leader>lrn",
	code_action = "<leader>lca",
	go_definition = "<leader>lgd",
	go_hover = "<leader>lgh",
	go_declaration = "<leader>lgD",
	go_implementation = "<leader>lgi",
	go_references = "<leader>lgr",
	diagnostic_prev = "<leader>ldp",
	diagnostic_next = "<leader>ldn",
	diagnostic_show = "<leader>ldd",
	diagnostic_quickfix = "<leader>ldl",
	format = "<leader>lf",
}

-- cursor move
vim.keymap.set({ "n", "i", "t" }, "<A-h>", "<Left>")
vim.keymap.set({ "n", "i", "t" }, "<A-j>", "<Down>")
vim.keymap.set({ "n", "i", "t" }, "<A-k>", "<Up>")
vim.keymap.set({ "n", "i", "t" }, "<A-l>", "<Right>")
vim.keymap.set({ "n", "i", "t" }, "<A-u>", "<Home>")
vim.keymap.set({ "n", "i", "t" }, "<A-l>", "<End>")

-- Ctrl-c Ctrl-v
vim.keymap.set("v", "<C-c>", '"+y')
vim.keymap.set("v", "<C-x>", '"+x')
vim.keymap.set("v", "<C-v>", '"+p')
vim.keymap.set("i", "<C-v>", '<Esc>"+pa')
vim.keymap.set("t", "<C-v>", '<C-\\><C-n>"+pa')
vim.keymap.set("c", "<C-v>", "<C-r>+")

-- windows control
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")
vim.keymap.set("n", "<leader>wc", "<cmd>close<CR>")
vim.keymap.set("n", "<leader>wnn", "<cmd>new<CR>")
vim.keymap.set("n", "<leader>wnv", "<cmd>vnew<CR>")
vim.keymap.set("n", "<leader>wss", "<cmd>split<CR>")
vim.keymap.set("n", "<leader>wsv", "<cmd>vsplit<CR>")
-- window shortcut
vim.keymap.set("n", "<C-w>z", function()
	vim.cmd("WindowsMaximize")
end)
vim.keymap.set("n", "<c-w>_", function()
	vim.cmd("WindowsMaximizeVertically")
end)
vim.keymap.set("n", "<c-w>|", function()
	vim.cmd("WindowsMaximizeHorizontally")
end)
vim.keymap.set("n", "<c-w>=", function()
	vim.cmd("WindowsEqualize")
end)

-- window-picker shortcut
vim.keymap.set("n", "<leader>wpp", function()
	require("plugin-config.window-picker").pick_window()
end, { desc = "Pick Window" })
vim.keymap.set("n", "<leader>wps", function()
	require("plugin-config.window-picker").swap_window()
end, { desc = "Swap Window" })

-- windows size control
vim.keymap.set("n", "<A-Up>", "<C-w>+")
vim.keymap.set("n", "<A-Down>", "<C-w>-")
vim.keymap.set("n", "<A-Left>", "<C-w><")
vim.keymap.set("n", "<A-Right>", "<C-w>>")

-- bufferline shortcut
vim.keymap.set("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>")
vim.keymap.set("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>")
vim.keymap.set("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>")
vim.keymap.set("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>")
vim.keymap.set("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>")
vim.keymap.set("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>")
vim.keymap.set("n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>")
vim.keymap.set("n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>")
vim.keymap.set("n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>")


vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<leader>bc", "<cmd>Bdelete!<CR>")
vim.keymap.set("n", "<leader>bcl", "<cmd>BufferLineCloseLeft<CR>")
vim.keymap.set("n", "<leader>bcr", "<cmd>BufferLineCloseRight<CR>")
vim.keymap.set("n", "<leader>bco", "<cmd>BufferLineCloseOthers<CR>")
vim.keymap.set("n", "<leader>bca", "<cmd>BufferLineCloseOthers<CR><cmd>Bdelete!<CR>")
vim.keymap.set("n", "<leader>bcp", "<cmd>BufferLinePickClose<CR>")
vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<CR>")
vim.keymap.set("n", "<leader>bsl", "<cmd>BufferLineMoveNext<CR>")
vim.keymap.set("n", "<leader>bsr", "<cmd>BufferLineMovePrev<CR>")

vim.keymap.set("n", "<leader>cc", "<Cmd>Bdelete!<CR>")

-- nvim-tree shortcut
vim.keymap.set("n", "<leader>mf", function()
	vim.cmd("NvimTreeFindFile")
end)
vim.keymap.set("n", "<leader>mc", function()
	vim.cmd("NvimTreeClose")
end)
vim.keymap.set("n", "<leader>mo", function()
	vim.cmd("NvimTreeOpen")
end)

-- telescope shortcut
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fn", function()
	require("telescope").extensions.notify.notify()
end)
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- ufo
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
vim.keymap.set("n", "zp", function()
	local winid = require("ufo").peekFoldedLinesUnderCursor()
	if not winid then
		return
	end
end)

-- toggleterm shortcut
vim.keymap.set({ "n", "t" }, "<leader>t1", function()
	require("plugin-config.toggleterm").toggleNormalTerm(1)
end)
vim.keymap.set({ "n", "t" }, "<leader>t2", function()
	require("plugin-config.toggleterm").toggleNormalTerm(2)
end)
vim.keymap.set({ "n", "t" }, "<leader>t3", function()
	require("plugin-config.toggleterm").toggleNormalTerm(3)
end)
vim.keymap.set({ "n", "t" }, "<leader>tg", function()
	require("plugin-config.toggleterm").toggleGituiTerm()
end)

-- lsp shortcut
vim.keymap.set("n", M.lsp_keys.rename, function()
	vim.lsp.buf.rename()
end)
vim.keymap.set("n", M.lsp_keys.code_action, function()
	vim.lsp.buf.code_action()
end)
vim.keymap.set("n", M.lsp_keys.go_definition, function()
	vim.lsp.buf.definition()
end)
vim.keymap.set("n", M.lsp_keys.go_declaration, function()
	vim.lsp.buf.declaration()
end)
vim.keymap.set("n", M.lsp_keys.go_implementation, function()
	vim.lsp.buf.implementation()
end)
vim.keymap.set("n", M.lsp_keys.go_references, function()
	vim.lsp.buf.references()
end)
vim.keymap.set("n", M.lsp_keys.go_hover, function()
	vim.lsp.buf.hover()
end)
vim.keymap.set("n", M.lsp_keys.diagnostic_prev, function()
	vim.diagnostic.goto_prev()
end)
vim.keymap.set("n", M.lsp_keys.diagnostic_next, function()
	vim.diagnostic.goto_next()
end)
vim.keymap.set("n", M.lsp_keys.diagnostic_show, function()
	vim.diagnostic.open_float()
end)
vim.keymap.set("n", M.lsp_keys.diagnostic_quickfix, function()
	vim.diagnostic.setloclist()
end)
vim.keymap.set("n", M.lsp_keys.format, function()
	vim.lsp.buf.format()
end)

-- conform shortcut
vim.keymap.set("n", "<leader>cf", function()
	require("plugin-config.conform").format()
end)

return M
