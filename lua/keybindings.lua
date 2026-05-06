-- 兼容旧引用：加载新的集中式键位系统并导出常量
-- 新项目请直接 require("keymaps.keys")
require("keymaps.init")

local keys = require("keymaps.keys")

-- 兼容旧命名（cmp/setup.lua、cmp/luasnip.lua 仍在引用）
local M = {}

M.cmp_keys = keys.cmp
M.snip_keys = keys.snip
M.lsp_keys = keys.lsp

return M
