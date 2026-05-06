local status, cmp = pcall(require, "cmp")
if not status then
	return
end

local status, luasnip = pcall(require, "luasnip")
if not status then
	return
end

local mapping = require("keymaps.plugins").cmp(cmp, luasnip)

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	-- 指定 snippet 引擎 luasnip
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	-- 快捷键
	-- mapping = mapping,
	mapping = mapping,
	-- 来源
	sources = cmp.config.sources({
		{
			name = "luasnip",
			group_index = 1,
		},
		{
			name = "nvim_lsp",
			group_index = 1,
		},
		{
			name = "nvim_lsp_signature_help",
			group_index = 1,
		},
		{
			name = "buffer",
			group_index = 2,
		},
		{
			name = "path",
			group_index = 2,
		},
	}),

	-- 使用lspkind-nvim显示类型图标
	formatting = require("cmp.lspkind").formatting,
})

-- Use buffer source for `/`.
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { {
		name = "buffer",
	} },
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({ {
		name = "path",
	} }, { {
		name = "cmdline",
	} }),
})

cmp.setup.filetype({ "markdown", "help" }, {
	sources = { {
		name = "luasnip",
	}, {
		name = "buffer",
	}, {
		name = "path",
	} },
})

require("cmp.luasnip")
