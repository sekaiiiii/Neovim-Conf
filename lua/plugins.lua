local table = require("util.table")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local lazyOptions = {}

local themePlugins = {
	{ "savq/melange-nvim" },
	{ "folke/tokyonight.nvim" },
	{ "projekt0n/github-nvim-theme" },
	{ "EdenEast/nightfox.nvim" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "navarasu/onedark.nvim" },
}

local cmpPlugins = {
	-- 补全引擎
	{ "hrsh7th/nvim-cmp" },
	-- Snippet 引擎
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },
	-- 补全源
	{ "hrsh7th/cmp-vsnip" },
	{ "hrsh7th/cmp-nvim-lsp" }, -- { name = nvim_lsp }
	{ "hrsh7th/cmp-buffer" }, -- { name = 'buffer' },
	{ "hrsh7th/cmp-path" }, -- { name = 'path' }
	{ "hrsh7th/cmp-cmdline" }, -- { name = 'cmdline' }
	{ "hrsh7th/cmp-nvim-lsp-signature-help" }, -- { name = 'nvim_lsp_signature_help' }
	-- 常见编程语言代码段
	{ "rafamadriz/friendly-snippets" },
	-- UI增强
	{ "onsails/lspkind-nvim" },
}

local lspPlugins = {
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig" },
	{ "neovim/nvim-lspconfig" },
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("plugin-config.lspsaga")
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
}

local basicPlugins = {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		},
		config = function()
			require("plugin-config.nvim-tree")
		end,
	},
	{
		"rmagatti/auto-session",
		config = function()
			require("plugin-config.auto-session")
		end,
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugin-config.alpha")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("plugin-config.lualine")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("plugin-config.bufferline")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugin-config.telescope")
		end,
	},
	{
		"ggandor/leap.nvim",
		config = function()
			require("plugin-config.leap")
		end,
	},
	{
		"ggandor/flit.nvim",
		config = function()
			require("plugin-config.flit")
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("plugin-config.comment")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("plugin-config.toggleterm")
		end,
	},
	{
		"kylechui/nvim-surround",
		config = function()
			require("plugin-config.nvim-surround")
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("plugin-config.nvim-autopairs")
		end,
	},
	{ "famiu/bufdelete.nvim" }, -- theme
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"p00f/nvim-ts-rainbow",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/nvim-treesitter-refactor",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("plugin-config.nvim-treesitter")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugin-config.gitsigns")
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		config = function()
			require("plugin-config.git-conflict")
		end,
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			require("plugin-config.diffview")
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		config = function()
			require("plugin-config.nvim-ufo")
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("plugin-config.symbols-outline")
		end,
	},
	{
		"folke/edgy.nvim",
		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,
		config = function()
			require("plugin-config.edgy")
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("plugin-config.noice")
		end,
	},
	{
		"s1n7ax/nvim-window-picker",
		lazy = true,
		event = { "WinNew" },
		config = function()
			require("plugin-config.window-picker")
		end,
	},
	{
		"anuvyklack/windows.nvim",
		lazy = true,
		cmd = { "WindowsMaximize", "WindowsMaximizeVertically", "WindowsMaximizeHorizontally", "WindowsEqualize" },
		dependencies = {
			"anuvyklack/middleclass",
		},
		config = function()
			require("plugin-config.windows")
		end,
	},
	{
		"nathom/filetype.nvim",
		lazy = true,
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("plugin-config.filetype")
		end,
	},
	{
		"folke/todo-comments.nvim",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("plugin-config.todo-comments")
		end,
	},
	{
		"windwp/nvim-spectre",
		lazy = true,
		cmd = { "Spectre" },
		config = function()
			require("plugin-config.spectre")
		end,
	},
	{
		"folke/trouble.nvim",
		lazy = true,
		cmd = { "TroubleToggle", "Trouble", "TroubleRefresh" },
		config = function()
			require("plugin-config.trouble")
		end,
	},
	{
		"rmagatti/goto-preview",
		lazy = true,
		keys = { "gp" },
		config = function()
			require("plugin-config.goto-preview")
		end,
	},
	{
		"ethanholz/nvim-lastplace",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("plugin-config.nvim-lastplace")
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		lazy = true,
		event = { "WinNew" },
		config = function()
			require("plugin-config.nvim-bqf")
		end,
	},
	{
		"chentoast/marks.nvim",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("plugin-config.marks")
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		opts = {},
		config = function()
			require("plugin-config.conform")
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("plugin-config.nvim-ts-autotag")
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		config = function()
			require("plugin-config.img-clip")
		end,
	},
	{
		"keaising/im-select.nvim",
		config = function()
			require("plugin-config.im-select")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("plugin-config.nvim-dap")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("dapui").setup()
		end,
	},
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			require("plugin-config.chatgpt")
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"folke/trouble.nvim", -- optional
			"nvim-telescope/telescope.nvim",
		},
	},
}

local plugins = table.merge_tables(themePlugins, cmpPlugins, lspPlugins, basicPlugins)

require("lazy").setup(plugins, lazyOptions)
