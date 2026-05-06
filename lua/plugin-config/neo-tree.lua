local status_ok, neo_tree = pcall(require, "neo-tree")
if not status_ok then
	vim.notify("Plugin Error: can't find neo-tree plugin")
	return
end

neo_tree.setup({
	close_if_last_window = false,
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = false,
	sort_case_insensitive = true,
	default_component_configs = {
		container = {
			enable_character_fade = true,
		},
		indent = {
			indent_size = 2,
			padding = 1,
			with_markers = false,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "",
			folder_empty_open = "",
			default = "",
			highlight = "NeoTreeFileIcon",
		},
		modified = {
			symbol = "●",
			highlight = "NeoTreeModified",
		},
		name = {
			trailing_slash = false,
			use_git_status_colors = true,
			highlight = "NeoTreeFileName",
		},
		git_status = {
			symbols = {
				added = "✚",
				modified = "",
				deleted = "✖",
				renamed = "󰁕",
				untracked = "",
				ignored = "",
				unstaged = "󰄱",
				staged = "",
				conflict = "",
			},
		},
	},
	window = {
		position = "left",
		width = 35,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = require("keymaps.plugins").neotree_window(),
	},
	filesystem = {
		filtered_items = {
			visible = false,
			hide_dotfiles = false,
			hide_gitignored = true,
		},
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false,
		},
		group_empty_dirs = false,
		hijack_netrw_behavior = "open_default",
		use_libuv_file_watcher = true,
		window = {
			mappings = require("keymaps.plugins").neotree_filesystem(),
		},
	},
	buffers = {
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false,
		},
	},
	git_status = {
		window = {
			mappings = require("keymaps.plugins").neotree_git_status(),
		},
	},
	event_handlers = {
		{
			event = "neo_tree_buffer_enter",
			handler = function()
				vim.opt_local.relativenumber = true
			end,
		},
	},
})
