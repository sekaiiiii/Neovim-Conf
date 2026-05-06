local ls = require("luasnip")
local config = require("config")
local types = require("luasnip.util.types")

-- custom snippets
require("luasnip.loaders.from_lua").load({
	paths = config.config_path .. "/lua/cmp/snippets/lua",
})
require("luasnip.loaders.from_vscode").lazy_load({
	paths = config.config_path .. "/lua/cmp/snippets/vscode",
})

require("luasnip.loaders.from_vscode").lazy_load()

ls.config.set_config({
	history = true,
	update_events = "TextChanged,TextChangedI",
	enable_autosnippets = true,
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "<--", "Error" } },
			},
		},
	},
})

-- 注意：LuaSnip 的键位映射已集中到 lua/keymaps/definitions.lua
