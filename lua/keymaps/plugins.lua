local keys = require("keymaps.keys")

local M = {}

-- ============================================================================
-- Telescope
-- ============================================================================
function M.telescope()
	return {
		i = {
			["<C-j>"] = "move_selection_next",
			["<C-k>"] = "move_selection_previous",
			["<C-e>"] = "preview_scrolling_down",
			["<C-y>"] = "preview_scrolling_up",
			["<C-h>"] = "which_key",
		},
	}
end

-- ============================================================================
-- Comment.nvim
-- ============================================================================
function M.comment()
	return {
		toggler = {
			line = "gcc",
			block = "gbc",
		},
		oleader = {
			line = "gc",
			block = "gb",
		},
		extra = {
			above = "gcO",
			below = "gco",
			eol = "gcA",
		},
		mappings = {
			basic = true,
			extra = true,
		},
	}
end

-- ============================================================================
-- nvim-treesitter
-- ============================================================================
function M.treesitter()
	return {
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<CR>",
				node_incremental = "<CR>",
				scope_incremental = "<TAB>",
				node_decremental = "<BS>",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
					["ai"] = "@conditional.outer",
					["ii"] = "@conditional.inner",
					["al"] = "@loop.outer",
					["il"] = "@loop.inner",
					["ab"] = "@block.outer",
					["ib"] = "@block.inner",
				},
			},
			swap = {
				enable = false,
				swap_next = { ["<leader>a"] = "@parameter.inner" },
				swap_previous = { ["<leader>A"] = "@parameter.inner" },
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
		},
	}
end

-- ============================================================================
-- nvim-surround
-- ============================================================================
function M.surround()
	return {
		insert = "<C-g>e",
		insert_line = "<C-g>E",
		normal = "ye",
		normal_cur = "yee",
		normal_line = "yE",
		normal_cur_line = "yEE",
		visual = "E",
		visual_line = "gE",
		delete = "de",
		change = "ce",
		change_line = "cE",
	}
end

-- ============================================================================
-- nvim-ufo (preview mappings)
-- ============================================================================
function M.ufo_preview()
	return {
		scrollU = "<C-u>",
		scrollD = "<C-d>",
		jumpTop = "[",
		jumpBot = "]",
	}
end

-- ============================================================================
-- nvim-bqf
-- ============================================================================
function M.bqf()
	return {
		func_map = {
			drop = "o",
			openc = "O",
			split = "<C-s>",
			tabdrop = "<C-t>",
			tabc = "",
			vsplit = "<C-v>",
			ptogglemode = "z,",
			stoggleup = "",
		},
		filter = {
			fzf = {
				action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
				extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
			},
		},
	}
end

-- ============================================================================
-- symbols-outline
-- ============================================================================
function M.symbols_outline()
	return {
		close = { "<Esc>", "q" },
		goto_location = "<Cr>",
		focus_location = "o",
		hover_symbol = "<C-space>",
		toggle_preview = "K",
		rename_symbol = "r",
		code_actions = "a",
		fold = "h",
		unfold = "l",
		fold_all = "W",
		unfold_all = "E",
		fold_reset = "R",
	}
end

-- ============================================================================
-- goto-preview
-- ============================================================================
function M.goto_preview()
	return {
		default_mappings = true,
	}
end

-- ============================================================================
-- marks.nvim
-- ============================================================================
function M.marks()
	return {
		default_mappings = true,
		mappings = {},
	}
end

-- ============================================================================
-- neo-tree
-- ============================================================================
function M.neotree_window()
	return {
		["<space>"] = "none",
		["s"] = function()
			require("leap").leap({})
		end,
		["S"] = function()
			require("leap").leap({ backward = true })
		end,
		-- 在任何 neo-tree 视图中按 gs 切换到 git_status（覆盖 leap 的 gs 全局映射）
		["gs"] = "git_status",
	}
end

function M.neotree_filesystem()
	return {
		["<A-r>"] = "open_with_system_application",
		["ga"] = "git_add_file",
		["gu"] = "git_unstage_file",
		["gr"] = "git_revert_file",
		["gd"] = function(state)
			local node = state.tree:get_node()
			if node and node.type == "file" then
				vim.cmd("DiffviewOpen -- " .. vim.fn.fnameescape(node.path))
			else
				vim.cmd("DiffviewOpen")
			end
		end,
		["gD"] = function(state)
			local node = state.tree:get_node()
			if node and node.type == "file" then
				vim.cmd("DiffviewFileHistory " .. vim.fn.fnameescape(node.path))
			end
		end,
	}
end

function M.neotree_git_status()
	return {
		["gf"] = "filesystem", -- 从 git_status 切回文件树
		["A"] = "git_add_all",
		["gu"] = "git_unstage_file",
		["ga"] = "git_add_file",
		["gr"] = "git_revert_file",
		["gc"] = "git_commit",
		["gp"] = "git_push",
		["gg"] = "git_commit_and_push",
		["o"] = "open",
		["<cr>"] = "open",
		["gd"] = function(state)
			local node = state.tree:get_node()
			if node and node.path then
				vim.cmd("DiffviewOpen -- " .. vim.fn.fnameescape(node.path))
			end
		end,
		["gD"] = function(state)
			local node = state.tree:get_node()
			if node and node.path then
				vim.cmd("DiffviewFileHistory " .. vim.fn.fnameescape(node.path))
			end
		end,
	}
end

-- ============================================================================
-- CMP (nvim-cmp)
-- ============================================================================
function M.cmp(cmp_module, luasnip_module)
	local cmp = cmp_module
	local luasnip = luasnip_module
	return {
		[keys.cmp.complete] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		[keys.cmp.abort] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		[keys.cmp.confirm] = cmp.mapping.confirm({
			select = true,
			behavior = cmp.ConfirmBehavior.Replace,
		}),
		[keys.cmp.scroll_doc_up] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		[keys.cmp.scroll_doc_down] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		[keys.cmp.select_prev] = cmp.mapping.select_prev_item(),
		[keys.cmp.select_next] = cmp.mapping.select_next_item(),
	}
end

-- ============================================================================
-- Lazy.nvim plugin specs 中的 keys（用于延迟加载触发）
-- ============================================================================
function M.lazy_goto_preview()
	return { "gp" }
end

-- ============================================================================
-- Diffview（接受 actions 参数）
-- ============================================================================
function M.diffview(actions)
	return {
		disable_defaults = false,
		view = {
			{ "n", "<tab>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
			{ "n", "<s-tab>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
			{ "n", "gf", actions.goto_file_edit, { desc = "Open the file in the previous tabpage" } },
			{ "n", "<C-w><C-f>", actions.goto_file_split, { desc = "Open the file in a new split" } },
			{ "n", "<C-w>gf", actions.goto_file_tab, { desc = "Open the file in a new tabpage" } },
			{ "n", "<leader>e", actions.focus_files, { desc = "Bring focus to the file panel" } },
			{ "n", "<leader>b", actions.toggle_files, { desc = "Toggle the file panel." } },
			{ "n", "g<C-x>", actions.cycle_layout, { desc = "Cycle through available layouts." } },
			{ "n", "[x", actions.prev_conflict, { desc = "In the merge-tool: jump to the previous conflict" } },
			{ "n", "]x", actions.next_conflict, { desc = "In the merge-tool: jump to the next conflict" } },
			{ "n", "<leader>co", actions.conflict_choose("ours"), { desc = "Choose the OURS version of a conflict" } },
			{ "n", "<leader>ct", actions.conflict_choose("theirs"), { desc = "Choose the THEIRS version of a conflict" } },
			{ "n", "<leader>cb", actions.conflict_choose("base"), { desc = "Choose the BASE version of a conflict" } },
			{ "n", "<leader>ca", actions.conflict_choose("all"), { desc = "Choose all the versions of a conflict" } },
			{ "n", "dx", actions.conflict_choose("none"), { desc = "Delete the conflict region" } },
			{ "n", "<leader>cO", actions.conflict_choose_all("ours"), { desc = "Choose the OURS version of a conflict for the whole file" } },
			{ "n", "<leader>cT", actions.conflict_choose_all("theirs"), { desc = "Choose the THEIRS version of a conflict for the whole file" } },
			{ "n", "<leader>cB", actions.conflict_choose_all("base"), { desc = "Choose the BASE version of a conflict for the whole file" } },
			{ "n", "<leader>cA", actions.conflict_choose_all("all"), { desc = "Choose all the versions of a conflict for the whole file" } },
			{ "n", "dX", actions.conflict_choose_all("none"), { desc = "Delete the conflict region for the whole file" } },
		},
		diff1 = {
			{ "n", "g?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
		},
		diff2 = {
			{ "n", "g?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
		},
		diff3 = {
			{ { "n", "x" }, "2do", actions.diffget("ours"), { desc = "Obtain the diff hunk from the OURS version of the file" } },
			{ { "n", "x" }, "3do", actions.diffget("theirs"), { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
			{ "n", "g?", actions.help({ "view", "diff3" }), { desc = "Open the help panel" } },
		},
		diff4 = {
			{ { "n", "x" }, "1do", actions.diffget("base"), { desc = "Obtain the diff hunk from the BASE version of the file" } },
			{ { "n", "x" }, "2do", actions.diffget("ours"), { desc = "Obtain the diff hunk from the OURS version of the file" } },
			{ { "n", "x" }, "3do", actions.diffget("theirs"), { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
			{ "n", "g?", actions.help({ "view", "diff4" }), { desc = "Open the help panel" } },
		},
		file_panel = {
			{ "n", "j", actions.next_entry, { desc = "Bring the cursor to the next file entry" } },
			{ "n", "<down>", actions.next_entry, { desc = "Bring the cursor to the next file entry" } },
			{ "n", "k", actions.prev_entry, { desc = "Bring the cursor to the previous file entry" } },
			{ "n", "<up>", actions.prev_entry, { desc = "Bring the cursor to the previous file entry" } },
			{ "n", "<cr>", actions.select_entry, { desc = "Open the diff for the selected entry" } },
			{ "n", "o", actions.select_entry, { desc = "Open the diff for the selected entry" } },
			{ "n", "l", actions.select_entry, { desc = "Open the diff for the selected entry" } },
			{ "n", "<2-LeftMouse>", actions.select_entry, { desc = "Open the diff for the selected entry" } },
			{ "n", "-", actions.toggle_stage_entry, { desc = "Stage / unstage the selected entry" } },
			{ "n", "S", actions.stage_all, { desc = "Stage all entries" } },
			{ "n", "U", actions.unstage_all, { desc = "Unstage all entries" } },
			{ "n", "X", actions.restore_entry, { desc = "Restore entry to the state on the left side" } },
			{ "n", "L", actions.open_commit_log, { desc = "Open the commit log panel" } },
			{ "n", "zo", actions.open_fold, { desc = "Expand fold" } },
			{ "n", "h", actions.close_fold, { desc = "Collapse fold" } },
			{ "n", "zc", actions.close_fold, { desc = "Collapse fold" } },
			{ "n", "za", actions.toggle_fold, { desc = "Toggle fold" } },
			{ "n", "zR", actions.open_all_folds, { desc = "Expand all folds" } },
			{ "n", "zM", actions.close_all_folds, { desc = "Collapse all folds" } },
			{ "n", "<c-b>", actions.scroll_view(-0.25), { desc = "Scroll the view up" } },
			{ "n", "<c-f>", actions.scroll_view(0.25), { desc = "Scroll the view down" } },
			{ "n", "<tab>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
			{ "n", "<s-tab>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
			{ "n", "gf", actions.goto_file_edit, { desc = "Open the file in the previous tabpage" } },
			{ "n", "<C-w><C-f>", actions.goto_file_split, { desc = "Open the file in a new split" } },
			{ "n", "<C-w>gf", actions.goto_file_tab, { desc = "Open the file in a new tabpage" } },
			{ "n", "i", actions.listing_style, { desc = "Toggle between 'list' and 'tree' views" } },
			{ "n", "f", actions.toggle_flatten_dirs, { desc = "Flatten empty subdirectories in tree listing style" } },
			{ "n", "R", actions.refresh_files, { desc = "Update stats and entries in the file list" } },
			{ "n", "<leader>e", actions.focus_files, { desc = "Bring focus to the file panel" } },
			{ "n", "<leader>b", actions.toggle_files, { desc = "Toggle the file panel." } },
			{ "n", "g<C-x>", actions.cycle_layout, { desc = "Cycle available layouts" } },
			{ "n", "[x", actions.prev_conflict, { desc = "Go to the previous conflict" } },
			{ "n", "]x", actions.next_conflict, { desc = "Go to the next conflict" } },
			{ "n", "g?", actions.help("file_panel"), { desc = "Open the help panel" } },
			{ "n", "<leader>cO", actions.conflict_choose_all("ours"), { desc = "Choose the OURS version of a conflict for the whole file" } },
			{ "n", "<leader>cT", actions.conflict_choose_all("theirs"), { desc = "Choose the THEIRS version of a conflict for the whole file" } },
			{ "n", "<leader>cB", actions.conflict_choose_all("base"), { desc = "Choose the BASE version of a conflict for the whole file" } },
			{ "n", "<leader>cA", actions.conflict_choose_all("all"), { desc = "Choose all the versions of a conflict for the whole file" } },
			{ "n", "dX", actions.conflict_choose_all("none"), { desc = "Delete the conflict region for the whole file" } },
		},
		file_history_panel = {
			{ "n", "g!", actions.options, { desc = "Open the option panel" } },
			{ "n", "<C-A-d>", actions.open_in_diffview, { desc = "Open the entry under the cursor in a diffview" } },
			{ "n", "y", actions.copy_hash, { desc = "Copy the commit hash of the entry under the cursor" } },
			{ "n", "L", actions.open_commit_log, { desc = "Show commit details" } },
			{ "n", "zR", actions.open_all_folds, { desc = "Expand all folds" } },
			{ "n", "zM", actions.close_all_folds, { desc = "Collapse all folds" } },
			{ "n", "j", actions.next_entry, { desc = "Bring the cursor to the next file entry" } },
			{ "n", "<down>", actions.next_entry, { desc = "Bring the cursor to the next file entry" } },
			{ "n", "k", actions.prev_entry, { desc = "Bring the cursor to the previous file entry." } },
			{ "n", "<up>", actions.prev_entry, { desc = "Bring the cursor to the previous file entry." } },
			{ "n", "<cr>", actions.select_entry, { desc = "Open the diff for the selected entry." } },
			{ "n", "o", actions.select_entry, { desc = "Open the diff for the selected entry." } },
			{ "n", "<2-LeftMouse>", actions.select_entry, { desc = "Open the diff for the selected entry." } },
			{ "n", "<c-b>", actions.scroll_view(-0.25), { desc = "Scroll the view up" } },
			{ "n", "<c-f>", actions.scroll_view(0.25), { desc = "Scroll the view down" } },
			{ "n", "<tab>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
			{ "n", "<s-tab>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
			{ "n", "gf", actions.goto_file_edit, { desc = "Open the file in the previous tabpage" } },
			{ "n", "<C-w><C-f>", actions.goto_file_split, { desc = "Open the file in a new split" } },
			{ "n", "<C-w>gf", actions.goto_file_tab, { desc = "Open the file in a new tabpage" } },
			{ "n", "<leader>e", actions.focus_files, { desc = "Bring focus to the file panel" } },
			{ "n", "<leader>b", actions.toggle_files, { desc = "Toggle the file panel" } },
			{ "n", "g<C-x>", actions.cycle_layout, { desc = "Cycle available layouts" } },
			{ "n", "g?", actions.help("file_history_panel"), { desc = "Open the help panel" } },
		},
		option_panel = {
			{ "n", "<tab>", actions.select_entry, { desc = "Change the current option" } },
			{ "n", "q", actions.close, { desc = "Close the panel" } },
			{ "n", "g?", actions.help("option_panel"), { desc = "Open the help panel" } },
		},
		help_panel = {
			{ "n", "q", actions.close, { desc = "Close help menu" } },
			{ "n", "<esc>", actions.close, { desc = "Close help menu" } },
		},
	}
end

return M
