local M = {}

-- CMP 补全键位
M.cmp = {
	complete = "<A-.>",
	abort = "<A-,>",
	confirm = "<CR>",
	scroll_doc_up = "<C-e>",
	scroll_doc_down = "<C-y>",
	select_prev = "<S-Tab>",
	select_next = "<Tab>",
}

-- LuaSnip 片段键位
M.snip = {
	jump_next = "<C-j>",
	jump_prev = "<C-k>",
	next_choice = "<C-h>",
	prev_choice = "<C-l>",
}

-- LSP 键位
M.lsp = {
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

-- Telescope 键位
M.telescope = {
	find_files = "<leader>ff",
	live_grep = "<leader>fg",
	buffers = "<leader>fb",
	help_tags = "<leader>fh",
	notify = "<leader>fn",
}

-- Neo-tree 键位
M.neotree = {
	reveal = "<leader>mf",
	close = "<leader>mc",
	open = "<leader>mo",
	git_status = "<leader>mg",
	diffview = "<leader>mG",
}

-- Buffer 键位
M.buffer = {
	close = "<leader>bc",
	close_left = "<leader>bcl",
	close_right = "<leader>bcr",
	close_others = "<leader>bco",
	close_all = "<leader>bca",
	pick_close = "<leader>bcp",
	pick = "<leader>bp",
	move_next = "<leader>bsl",
	move_prev = "<leader>bsr",
	cycle_next = "<Tab>",
	cycle_prev = "<S-Tab>",
	goto_1 = "<A-1>",
	goto_2 = "<A-2>",
	goto_3 = "<A-3>",
	goto_4 = "<A-4>",
	goto_5 = "<A-5>",
	goto_6 = "<A-6>",
	goto_7 = "<A-7>",
	goto_8 = "<A-8>",
	goto_9 = "<A-9>",
}

-- Window 键位
M.window = {
	close = "<leader>wc",
	new = "<leader>wnn",
	vnew = "<leader>wnv",
	split = "<leader>wss",
	vsplit = "<leader>wsv",
	maximize = "<C-w>z",
	maximize_vert = "<c-w>_",
	maximize_horiz = "<c-w>|",
	equalize = "<c-w>=",
	pick = "<leader>wpp",
	swap = "<leader>wps",
	size_up = "<A-Up>",
	size_down = "<A-Down>",
	size_left = "<A-Left>",
	size_right = "<A-Right>",
}

-- Terminal 键位（VS Code 风格）
M.terminal = {
	toggle = "<C-`>",         -- 主切换键：Ctrl+`（VS Code 同款）
	toggle_1 = "<leader>t1",   -- 切换到终端 1
	toggle_2 = "<leader>t2",   -- 切换到终端 2
	toggle_3 = "<leader>t3",   -- 切换到终端 3
	new = "<leader>tn",        -- 新建终端
	close = "<leader>tc",      -- 关闭当前终端
	next = "<leader>tk",       -- 下一个终端
	prev = "<leader>tj",       -- 上一个终端
	toggle_all = "<leader>ta", -- 显示/隐藏所有终端
	toggle_float = "<leader>tf", -- 浮动终端
	toggle_vertical = "<leader>tv", -- 垂直终端
	toggle_gitui = "<leader>tg", -- GitUI
	toggle_lazygit = "<leader>tl", -- LazyGit
}

-- Format 键位
M.format = {
	conform = "<leader>cf",
}

-- UFO 折叠键位
M.ufo = {
	open_all = "zR",
	close_all = "zM",
	open_except_kinds = "zr",
	close_with = "zm",
	peek = "zp",
}

-- Leap 键位
M.leap = {
	forward = "s",
	backward = "S",
	from_window = "gs",
}

return M
