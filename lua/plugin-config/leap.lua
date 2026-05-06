local status_ok, leap = pcall(require, "leap")
if not status_ok then
	vim.notify("Plugin Error: can't find leap plugin")
	return
end

leap.setup({})

-- 注意：leap 的全局键位映射已集中到 lua/keymaps/definitions.lua
-- 在 neo-tree 中会自动避让，由 neo-tree 的 buffer-local 映射接管
