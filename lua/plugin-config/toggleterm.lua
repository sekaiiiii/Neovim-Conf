local status, toggleterm = pcall(require, "toggleterm")
if not status then
	vim.notify("Plugin Error: can't find toggleterm plugin")
	return
end

local Terminal = require("toggleterm.terminal").Terminal

-- ============================================================================
-- VS Code 风格终端配置
-- ============================================================================
toggleterm.setup({
	-- 底部面板尺寸：占屏幕高度的 30%（VS Code 默认约 1/3）
	size = function(term)
		if term.direction == "horizontal" then
			return math.floor(vim.o.lines * 0.3)
		elseif term.direction == "vertical" then
			return math.floor(vim.o.columns * 0.3)
		elseif term.direction == "float" then
			return math.floor(vim.o.lines * 0.8)
		end
	end,

	-- 行为设置
	start_in_insert = true,        -- 打开终端自动进入 insert 模式
	insert_mappings = true,        -- insert 模式下也能用快捷键切换终端
	terminal_mappings = true,      -- 终端内也能用快捷键
	persist_size = true,
	persist_mode = true,
	autochdir = true,              -- 跟随 Neovim 的 cwd
	auto_scroll = true,            -- 自动滚动到底部
	close_on_exit = false,         -- VS Code 风格：进程退出后保留窗口
	shell = vim.o.shell,

	-- 外观设置
	direction = "horizontal",      -- VS Code 风格：底部面板
	hide_numbers = true,           -- 隐藏行号列
	shade_terminals = false,
	shading_factor = 0,

	-- Winbar：显示终端编号和名称（VS Code 风格标签页）
	winbar = {
		enabled = true,
		name_formatter = function(term)
			local name = term.display_name or term.name or "shell"
			return string.format("[%d] %s", term.id, name)
		end,
	},

	highlights = {
		Normal = { link = "Normal" },
		NormalFloat = { link = "Normal" },
		FloatBorder = { link = "FloatBorder" },
	},
})

-- ============================================================================
-- 预定义终端实例
-- ============================================================================

-- GitUI 浮动终端（保留原有功能）
local gituiTerm = Terminal:new({
	cmd = "gitui",
	display_name = "GitUI",
	direction = "float",
	border = "rounded",
	close_on_exit = true,
	float_opts = {
		width = math.floor(vim.o.columns * 0.8),
		height = math.floor(vim.o.lines * 0.9),
		zindex = 50,
	},
})

-- LazyGit 浮动终端（VS Code 风格：集成 git 工具）
local lazygitTerm = Terminal:new({
	cmd = "lazygit",
	display_name = "LazyGit",
	direction = "float",
	border = "rounded",
	close_on_exit = true,
	float_opts = {
		width = math.floor(vim.o.columns * 0.9),
		height = math.floor(vim.o.lines * 0.9),
		zindex = 50,
	},
})

-- ============================================================================
-- 对外接口
-- ============================================================================
local M = {}

---切换底部终端（VS Code Ctrl+` 风格）
---支持 count：3<C-`> 切换到 3 号终端
function M.toggleTerm(count)
	count = count or (vim.v.count > 0 and vim.v.count or nil)
	if count then
		vim.cmd(count .. "ToggleTerm direction=horizontal")
	else
		vim.cmd("ToggleTerm direction=horizontal")
	end
end

---切换到指定编号的终端
function M.toggleTermByIndex(index)
	vim.cmd(index .. "ToggleTerm direction=horizontal")
end

---新建一个终端（自动分配下一个编号）
function M.newTerm()
	local terms = require("toggleterm.terminal").get_all()
	local max_id = 0
	for _, term in pairs(terms) do
		if term.id > max_id then
			max_id = term.id
		end
	end
	vim.cmd((max_id + 1) .. "ToggleTerm direction=horizontal")
end

---关闭当前终端
function M.closeTerm()
	local current = vim.b.toggle_number
	if current then
		vim.cmd(current .. "ToggleTerm direction=horizontal")
	else
		vim.cmd("ToggleTerm direction=horizontal")
	end
end

---关闭所有终端
function M.closeAllTerms()
	vim.cmd("ToggleTermToggleAll")
end

---切换到下一个终端
function M.nextTerm()
	local terms = require("toggleterm.terminal").get_all(true)
	if #terms <= 1 then
		return
	end
	local current_id = vim.b.toggle_number
	table.sort(terms, function(a, b)
		return a.id < b.id
	end)
	for i, term in ipairs(terms) do
		if term.id == current_id and terms[i + 1] then
			terms[i + 1]:focus()
			return
		end
	end
	-- 循环到第一个
	terms[1]:focus()
end

---切换到上一个终端
function M.prevTerm()
	local terms = require("toggleterm.terminal").get_all(true)
	if #terms <= 1 then
		return
	end
	local current_id = vim.b.toggle_number
	table.sort(terms, function(a, b)
		return a.id < b.id
	end)
	for i, term in ipairs(terms) do
		if term.id == current_id and terms[i - 1] then
			terms[i - 1]:focus()
			return
		end
	end
	-- 循环到最后一个
	terms[#terms]:focus()
end

---切换浮动终端
function M.toggleFloatTerm()
	vim.cmd("ToggleTerm direction=float")
end

---切换垂直侧边终端
function M.toggleVerticalTerm()
	vim.cmd("ToggleTerm direction=vertical")
end

---切换 GitUI
function M.toggleGituiTerm()
	gituiTerm:toggle()
end

---切换 LazyGit
function M.toggleLazygitTerm()
	lazygitTerm:toggle()
end

---发送命令到当前终端
function M.sendCommand(cmd)
	local current = vim.b.toggle_number
	if current then
		require("toggleterm").exec(cmd, current)
	end
end

return M
