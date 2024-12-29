local M = {}

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { { "prettier" } },
		css = { { "prettier" } },
		scss = { { "prettier" } },
		less = { { "prettier" } },
		vue = { { "prettier" } },
		jsx = { { "prettier" } },
	},
})

function M.format(...)
	return require("conform").format(...)
end

return M
