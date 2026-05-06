local keys = require("keymaps.keys")

-- ============================================================================
-- Leader 设置（由 init.lua 确保在本文之前加载）
-- ============================================================================

-- ============================================================================
-- 键位查看器
-- ============================================================================
vim.keymap.set("n", "<leader>?", function()
	require("keymaps.viewer").open()
end, { desc = "Open keymaps viewer" })

vim.api.nvim_create_user_command("Keymaps", function()
	require("keymaps.viewer").open()
end, { desc = "Open keymaps floating viewer" })

vim.api.nvim_create_user_command("KeymapsTelescope", function()
	require("keymaps.viewer").telescope()
end, { desc = "Open keymaps telescope picker" })

-- ============================================================================
-- 光标移动（Alt + hjkl 在 Normal/Insert/Terminal 模式）
-- ============================================================================
vim.keymap.set({ "n", "i", "t" }, "<A-h>", "<Left>")
vim.keymap.set({ "n", "i", "t" }, "<A-j>", "<Down>")
vim.keymap.set({ "n", "i", "t" }, "<A-k>", "<Up>")
vim.keymap.set({ "n", "i", "t" }, "<A-l>", "<Right>")
vim.keymap.set({ "n", "i", "t" }, "<A-u>", "<Home>")
vim.keymap.set({ "n", "i", "t" }, "<A-l>", "<End>")

-- ============================================================================
-- 系统剪贴板（Ctrl-c/x/v）
-- ============================================================================
vim.keymap.set("v", "<C-c>", '"+y')
vim.keymap.set("v", "<C-x>", '"+x')
vim.keymap.set("v", "<C-v>", '"+p')
vim.keymap.set("i", "<C-v>", '<Esc>"+pa')
vim.keymap.set("t", "<C-v>", '<C-\\><C-n>"+pa')
vim.keymap.set("c", "<C-v>", "<C-r>+")

-- ============================================================================
-- 窗口导航
-- ============================================================================
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- 窗口操作
vim.keymap.set("n", keys.window.close, "<cmd>close<CR>")
vim.keymap.set("n", keys.window.new, "<cmd>new<CR>")
vim.keymap.set("n", keys.window.vnew, "<cmd>vnew<CR>")
vim.keymap.set("n", keys.window.split, "<cmd>split<CR>")
vim.keymap.set("n", keys.window.vsplit, "<cmd>vsplit<CR>")
vim.keymap.set("n", keys.window.maximize, function()
	vim.cmd("WindowsMaximize")
end)
vim.keymap.set("n", keys.window.maximize_vert, function()
	vim.cmd("WindowsMaximizeVertically")
end)
vim.keymap.set("n", keys.window.maximize_horiz, function()
	vim.cmd("WindowsMaximizeHorizontally")
end)
vim.keymap.set("n", keys.window.equalize, function()
	vim.cmd("WindowsEqualize")
end)

-- 窗口选择
vim.keymap.set("n", keys.window.pick, function()
	require("plugin-config.window-picker").pick_window()
end, { desc = "Pick Window" })
vim.keymap.set("n", keys.window.swap, function()
	require("plugin-config.window-picker").swap_window()
end, { desc = "Swap Window" })

-- 窗口大小调整
vim.keymap.set("n", keys.window.size_up, "<C-w>+")
vim.keymap.set("n", keys.window.size_down, "<C-w>-")
vim.keymap.set("n", keys.window.size_left, "<C-w><")
vim.keymap.set("n", keys.window.size_right, "<C-w>>")

-- ============================================================================
-- Buffer 操作
-- ============================================================================
for i = 1, 9 do
	vim.keymap.set("n", keys.buffer["goto_" .. i], string.format("<cmd>BufferLineGoToBuffer %d<CR>", i))
end

vim.keymap.set("n", keys.buffer.cycle_prev, "<cmd>BufferLineCyclePrev<CR>")
vim.keymap.set("n", keys.buffer.cycle_next, "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", keys.buffer.close, "<cmd>Bdelete!<CR>")
vim.keymap.set("n", keys.buffer.close_left, "<cmd>BufferLineCloseLeft<CR>")
vim.keymap.set("n", keys.buffer.close_right, "<cmd>BufferLineCloseRight<CR>")
vim.keymap.set("n", keys.buffer.close_others, "<cmd>BufferLineCloseOthers<CR>")
vim.keymap.set("n", keys.buffer.close_all, "<cmd>BufferLineCloseOthers<CR><cmd>Bdelete!<CR>")
vim.keymap.set("n", keys.buffer.pick_close, "<cmd>BufferLinePickClose<CR>")
vim.keymap.set("n", keys.buffer.pick, "<cmd>BufferLinePick<CR>")
vim.keymap.set("n", keys.buffer.move_next, "<cmd>BufferLineMoveNext<CR>")
vim.keymap.set("n", keys.buffer.move_prev, "<cmd>BufferLineMovePrev<CR>")

-- 关闭当前 buffer（别名）
vim.keymap.set("n", "<leader>cc", "<Cmd>Bdelete!<CR>")

-- ============================================================================
-- Neo-tree
-- ============================================================================
vim.keymap.set("n", keys.neotree.reveal, function()
	vim.cmd("Neotree reveal")
end)
vim.keymap.set("n", keys.neotree.close, function()
	vim.cmd("Neotree close")
end)
vim.keymap.set("n", keys.neotree.open, function()
	vim.cmd("Neotree")
end)
vim.keymap.set("n", keys.neotree.git_status, function()
	vim.cmd("Neotree git_status")
end)
vim.keymap.set("n", keys.neotree.diffview, function()
	vim.cmd("DiffviewOpen")
end)

-- ============================================================================
-- Telescope
-- ============================================================================
local builtin = require("telescope.builtin")
vim.keymap.set("n", keys.telescope.notify, function()
	require("telescope").extensions.notify.notify()
end)
vim.keymap.set("n", keys.telescope.find_files, builtin.find_files, {})
vim.keymap.set("n", keys.telescope.live_grep, builtin.live_grep, {})
vim.keymap.set("n", keys.telescope.buffers, builtin.buffers, {})
vim.keymap.set("n", keys.telescope.help_tags, builtin.help_tags, {})

-- ============================================================================
-- UFO 折叠
-- ============================================================================
vim.keymap.set("n", keys.ufo.open_all, require("ufo").openAllFolds)
vim.keymap.set("n", keys.ufo.close_all, require("ufo").closeAllFolds)
vim.keymap.set("n", keys.ufo.open_except_kinds, require("ufo").openFoldsExceptKinds)
vim.keymap.set("n", keys.ufo.close_with, require("ufo").closeFoldsWith)
vim.keymap.set("n", keys.ufo.peek, function()
	local winid = require("ufo").peekFoldedLinesUnderCursor()
	if not winid then
		return
	end
end)

-- ============================================================================
-- ToggleTerm（VS Code 风格终端）
-- ============================================================================
-- 主切换键：Ctrl+`（VS Code 同款）
vim.keymap.set({ "n", "i", "t" }, keys.terminal.toggle, function()
	require("plugin-config.toggleterm").toggleTerm()
end, { desc = "Toggle terminal panel" })

-- 切换到指定编号的终端
vim.keymap.set({ "n", "t" }, keys.terminal.toggle_1, function()
	require("plugin-config.toggleterm").toggleTermByIndex(1)
end, { desc = "Toggle terminal 1" })
vim.keymap.set({ "n", "t" }, keys.terminal.toggle_2, function()
	require("plugin-config.toggleterm").toggleTermByIndex(2)
end, { desc = "Toggle terminal 2" })
vim.keymap.set({ "n", "t" }, keys.terminal.toggle_3, function()
	require("plugin-config.toggleterm").toggleTermByIndex(3)
end, { desc = "Toggle terminal 3" })

-- 终端管理
vim.keymap.set("n", keys.terminal.new, function()
	require("plugin-config.toggleterm").newTerm()
end, { desc = "New terminal" })
vim.keymap.set({ "n", "t" }, keys.terminal.close, function()
	require("plugin-config.toggleterm").closeTerm()
end, { desc = "Close current terminal" })
vim.keymap.set({ "n", "t" }, keys.terminal.next, function()
	require("plugin-config.toggleterm").nextTerm()
end, { desc = "Next terminal" })
vim.keymap.set({ "n", "t" }, keys.terminal.prev, function()
	require("plugin-config.toggleterm").prevTerm()
end, { desc = "Previous terminal" })
vim.keymap.set({ "n", "t" }, keys.terminal.toggle_all, function()
	require("plugin-config.toggleterm").closeAllTerms()
end, { desc = "Toggle all terminals" })

-- 特殊终端
vim.keymap.set({ "n", "t" }, keys.terminal.toggle_float, function()
	require("plugin-config.toggleterm").toggleFloatTerm()
end, { desc = "Toggle float terminal" })
vim.keymap.set({ "n", "t" }, keys.terminal.toggle_vertical, function()
	require("plugin-config.toggleterm").toggleVerticalTerm()
end, { desc = "Toggle vertical terminal" })
vim.keymap.set({ "n", "t" }, keys.terminal.toggle_gitui, function()
	require("plugin-config.toggleterm").toggleGituiTerm()
end, { desc = "Toggle GitUI" })
vim.keymap.set({ "n", "t" }, keys.terminal.toggle_lazygit, function()
	require("plugin-config.toggleterm").toggleLazygitTerm()
end, { desc = "Toggle LazyGit" })

-- ============================================================================
-- LSP
-- ============================================================================
vim.keymap.set("n", keys.lsp.rename, function()
	vim.lsp.buf.rename()
end)
vim.keymap.set("n", keys.lsp.code_action, function()
	vim.lsp.buf.code_action()
end)
vim.keymap.set("n", keys.lsp.go_definition, function()
	vim.lsp.buf.definition()
end)
vim.keymap.set("n", keys.lsp.go_declaration, function()
	vim.lsp.buf.declaration()
end)
vim.keymap.set("n", keys.lsp.go_implementation, function()
	vim.lsp.buf.implementation()
end)
vim.keymap.set("n", keys.lsp.go_references, function()
	vim.lsp.buf.references()
end)
vim.keymap.set("n", keys.lsp.go_hover, function()
	vim.lsp.buf.hover()
end)
vim.keymap.set("n", keys.lsp.diagnostic_prev, function()
	vim.diagnostic.goto_prev()
end)
vim.keymap.set("n", keys.lsp.diagnostic_next, function()
	vim.diagnostic.goto_next()
end)
vim.keymap.set("n", keys.lsp.diagnostic_show, function()
	vim.diagnostic.open_float()
end)
vim.keymap.set("n", keys.lsp.diagnostic_quickfix, function()
	vim.diagnostic.setloclist()
end)
vim.keymap.set("n", keys.lsp.format, function()
	vim.lsp.buf.format()
end)

-- ============================================================================
-- Conform 格式化
-- ============================================================================
vim.keymap.set("n", keys.format.conform, function()
	require("plugin-config.conform").format()
end)

-- ============================================================================
-- LuaSnip 片段跳转
-- ============================================================================
local ls = require("luasnip")
vim.keymap.set({ "i", "s" }, keys.snip.jump_next, function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end)
vim.keymap.set({ "i", "s" }, keys.snip.jump_prev, function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end)
vim.keymap.set({ "i", "s" }, keys.snip.next_choice, function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)
vim.keymap.set({ "i", "s" }, keys.snip.prev_choice, function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end)

-- ============================================================================
-- Leap（全局映射，在 neo-tree 中自动避让）
-- ============================================================================
local leap = require("leap")

local function safe_leap(opts)
	return function()
		if vim.bo.filetype == "neo-tree" then
			return
		end
		leap.leap(opts)
	end
end

vim.keymap.set({ "n", "x", "o" }, keys.leap.forward, safe_leap({}))
vim.keymap.set({ "n", "x", "o" }, keys.leap.backward, safe_leap({ backward = true }))
vim.keymap.set({ "n", "x", "o" }, keys.leap.from_window, safe_leap({
	target_windows = vim.tbl_filter(function(winid)
		return vim.api.nvim_win_get_config(winid).focusable
	end, vim.api.nvim_tabpage_list_wins(0)),
}))
