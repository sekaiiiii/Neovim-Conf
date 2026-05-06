local M = {}

-- ============================================================================
-- 收集当前 Neovim 中的所有映射（全局 + buffer-local）
-- ============================================================================
local function collect_keymaps()
	local results = {}
	local modes = { "n", "i", "v", "x", "s", "o", "t", "c" }

	for _, mode in ipairs(modes) do
		-- 全局映射
		local global_maps = vim.api.nvim_get_keymap(mode)
		for _, map in ipairs(global_maps) do
			if not map.lhs:match("^<Plug>") and map.lhs ~= "" then
				table.insert(results, {
					mode = mode,
					lhs = map.lhs,
					desc = map.desc or "",
					rhs = map.rhs or "",
					buffer = nil,
				})
			end
		end

		-- 当前窗口的 buffer-local 映射
		local bufnr = vim.api.nvim_get_current_buf()
		local ok, buf_maps = pcall(vim.api.nvim_buf_get_keymap, bufnr, mode)
		if ok then
			for _, map in ipairs(buf_maps) do
				if not map.lhs:match("^<Plug>") and map.lhs ~= "" then
					table.insert(results, {
						mode = mode,
						lhs = map.lhs,
						desc = map.desc or "",
						rhs = map.rhs or "",
						buffer = bufnr,
					})
				end
			end
		end
	end

	return results
end

-- ============================================================================
-- 格式化映射为可读文本
-- ============================================================================
local mode_names = {
	n = "Normal",
	i = "Insert",
	v = "Visual",
	x = "Visual-Block",
	s = "Select",
	o = "Operator",
	t = "Terminal",
	c = "Command",
}

local function format_keymaps(keymaps)
	local lines = {}
	local by_mode = {}

	for _, km in ipairs(keymaps) do
		by_mode[km.mode] = by_mode[km.mode] or {}
		table.insert(by_mode[km.mode], km)
	end

	for _, mode in ipairs({ "n", "i", "v", "x", "o", "t", "c" }) do
		if by_mode[mode] then
			-- 去重：buffer-local 优先
			local seen = {}
			local unique = {}
			for _, km in ipairs(by_mode[mode]) do
				local key = km.lhs
				if not seen[key] or km.buffer then
					seen[key] = true
					unique[key] = km
				end
			end

			-- 排序
			local sorted = {}
			for _, km in pairs(unique) do
				table.insert(sorted, km)
			end
			table.sort(sorted, function(a, b)
				return a.lhs < b.lhs
			end)

			local title = string.format("▌ %s ", mode_names[mode] or mode):upper()
			title = title .. string.rep("─", math.max(0, 70 - #title))
			table.insert(lines, title)

			for _, km in ipairs(sorted) do
				local desc = km.desc ~= "" and km.desc or km.rhs
				desc = desc:gsub("\n", " ")
				if #desc > 45 then
					desc = desc:sub(1, 42) .. "..."
				end
				local buf_mark = km.buffer and "[B]" or "   "
				table.insert(lines, string.format("%s  %-26s │ %s", buf_mark, km.lhs, desc))
			end
			table.insert(lines, "")
		end
	end

	return lines
end

-- ============================================================================
-- 打开浮动窗口查看器
-- ============================================================================
function M.open()
	local keymaps = collect_keymaps()
	local lines = format_keymaps(keymaps)

	if #lines == 0 then
		vim.notify("No keymaps found", vim.log.levels.WARN)
		return
	end

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	local width = math.min(78, vim.o.columns - 4)
	local height = math.min(#lines + 2, vim.o.lines - 4)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = " Keymaps ",
		title_pos = "center",
	})

	vim.bo[buf].modifiable = false
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].filetype = "keymaps"
	vim.wo[win].cursorline = true
	vim.wo[win].wrap = false

	-- 关闭映射
	local close_opts = { buffer = buf, silent = true, nowait = true }
	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win, true)
	end, close_opts)
	vim.keymap.set("n", "<Esc>", function()
		vim.api.nvim_win_close(win, true)
	end, close_opts)

	-- 搜索映射（模拟 / 搜索）
	vim.keymap.set("n", "/", function()
		local prompt = vim.fn.input("Filter: ")
		if prompt == "" then
			return
		end
		local filtered = {}
		for _, line in ipairs(lines) do
			if line:lower():match(prompt:lower()) then
				table.insert(filtered, line)
			end
		end
		vim.bo[buf].modifiable = true
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, filtered)
		vim.bo[buf].modifiable = false
	end, close_opts)

	-- 还原映射
	vim.keymap.set("n", "R", function()
		vim.bo[buf].modifiable = true
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
		vim.bo[buf].modifiable = false
	end, close_opts)
end

-- ============================================================================
-- 使用 Telescope 查看（如果可用）
-- ============================================================================
function M.telescope()
	local ok, pickers = pcall(require, "telescope.pickers")
	if not ok then
		vim.notify("Telescope not available, falling back to floating window", vim.log.levels.WARN)
		M.open()
		return
	end

	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local entry_display = require("telescope.pickers.entry_display")

	local keymaps = collect_keymaps()

	local displayer = entry_display.create({
		separator = " ",
		items = {
			{ width = 3 },
			{ width = 20 },
			{ remaining = true },
		},
	})

	local function make_display(entry)
		return displayer({
			{ "[" .. entry.value.mode .. "]", "TelescopeResultsIdentifier" },
			{ entry.value.lhs, "TelescopeResultsConstant" },
			{ entry.value.desc, "TelescopeResultsComment" },
		})
	end

	pickers.new({}, {
		prompt_title = "Keymaps",
		finder = finders.new_table({
			results = keymaps,
			entry_maker = function(entry)
				local desc = entry.desc ~= "" and entry.desc or entry.rhs
				return {
					value = {
						mode = entry.mode,
						lhs = entry.lhs,
						desc = desc,
						buffer = entry.buffer,
					},
					ordinal = entry.mode .. " " .. entry.lhs .. " " .. desc,
					display = make_display,
				}
			end,
		}),
		sorter = conf.generic_sorter({}),
		attach_mappings = function(prompt_bufnr)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
			end)
			return true
		end,
	}):find()
end

return M
