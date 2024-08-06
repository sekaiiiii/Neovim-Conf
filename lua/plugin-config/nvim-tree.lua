local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	vim.notify("Plugin Error: can't find nvim-tree plugin")
	return
end

local function nvim_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "<A-r>", api.node.run.system)
	-- s run system
	vim.keymap.set("n", "s", "<Plug>(leap-forward-to)", opts("leap"))
	-- S search
	vim.keymap.set("n", "S", "<Plug>(leap-backward-to)", opts("leap"))
end

nvim_tree.setup({
	on_attach = nvim_on_attach,
	hijack_cursor = false,
	auto_reload_on_write = true,
	disable_netrw = false,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,
	root_dirs = {},
	prefer_startup_root = false,
	sync_root_with_cwd = false,
	reload_on_bufenter = false,
	respect_buf_cwd = false,
	select_prompts = false,
	sort = {
		sorter = "name",
		folders_first = true,
		files_first = false,
	},
	view = {
		centralize_selection = true,
		cursorline = true,
		debounce_delay = 15,
		side = "left",
		preserve_window_proportions = false,
		number = false,
		relativenumber = true,
		signcolumn = "yes",
		width = 35,
		float = {
			enable = false,
			quit_on_focus_loss = true,
			open_win_config = {
				relative = "editor",
				border = "rounded",
				width = 100,
				height = 100,
				row = 0.5,
				col = 0.5,
			},
		},
	},
	renderer = {
		add_trailing = false,
		group_empty = false,
		full_name = false,
		root_folder_label = ":~:s?$?/..?",
		indent_width = 1,
		special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
		symlink_destination = true,
		highlight_git = "none",
		highlight_diagnostics = "none",
		highlight_opened_files = "none",
		highlight_modified = "none",
		highlight_bookmarks = "none",
		highlight_clipboard = "name",
		indent_markers = {
			enable = false,
			inline_arrows = true,
			icons = {
				corner = "└",
				edge = "│",
				item = "│",
				bottom = "─",
				none = " ",
			},
		},
		icons = {
			web_devicons = {
				file = {
					enable = true,
					color = true,
				},
				folder = {
					enable = false,
					color = true,
				},
			},
			git_placement = "before",
			modified_placement = "after",
			diagnostics_placement = "signcolumn",
			bookmarks_placement = "signcolumn",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
				modified = true,
				diagnostics = true,
				bookmarks = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				bookmark = "󰆤",
				modified = "●",
				folder = {
					arrow_closed = "",
					arrow_open = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	update_focused_file = {
		enable = false,
		update_root = false,
		ignore_list = {},
	},
	system_open = {
		cmd = "",
		args = {},
	},
	git = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = true,
		disable_for_dirs = {},
		timeout = 2000,
		cygwin_support = false,
	},
	diagnostics = {
		enable = false,
		show_on_dirs = false,
		show_on_open_dirs = true,
		debounce_delay = 100,
		severity = {
			min = vim.diagnostic.severity.HINT,
			max = vim.diagnostic.severity.ERROR,
		},
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	modified = {
		enable = false,
		show_on_dirs = true,
		show_on_open_dirs = true,
	},
	filters = {
		git_ignored = true,
		dotfiles = false,
		git_clean = false,
		no_buffer = false,
		no_bookmark = false,
		custom = {},
		exclude = {},
	},
	live_filter = {
		prefix = "[FILTER]: ",
		always_show_folders = true,
	},
	filesystem_watchers = {
		enable = true,
		debounce_delay = 100,
		ignore_dirs = {},
	},
	actions = {
		use_system_clipboard = true,
		change_dir = {
			enable = true,
			global = false,
			restrict_above_cwd = false,
		},
		expand_all = {
			max_folder_discovery = 300,
			exclude = {},
		},
		file_popup = {
			open_win_config = {
				col = 1,
				row = 1,
				relative = "cursor",
				border = "shadow",
				style = "minimal",
			},
		},
		open_file = {
			quit_on_open = false,
			eject = true,
			resize_window = true,
			window_picker = {
				enable = true,
				picker = require("window-picker").pick_window,
			},
		},
		remove_file = {
			close_window = true,
		},
	},
	trash = {
		cmd = "gio trash",
	},
	tab = {
		sync = {
			open = false,
			close = false,
			ignore = {},
		},
	},
	notify = {
		threshold = vim.log.levels.INFO,
		absolute_path = true,
	},
	help = {
		sort_by = "key",
	},
	ui = {
		confirm = {
			remove = true,
			trash = true,
			default_yes = false,
		},
	},
	experimental = {},
	log = {
		enable = false,
		truncate = false,
		types = {
			all = false,
			config = false,
			copy_paste = false,
			dev = false,
			diagnostics = false,
			git = false,
			profile = false,
			watcher = false,
		},
	},
	-- END_DEFAULT_OPTS
})
