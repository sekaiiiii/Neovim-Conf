local config = require("config")

-- 设置 Leader（必须在任何键位映射之前）
vim.g.mapleader = config.leader_key
vim.g.maplocalleader = config.leader_key

-- 加载全局键位定义
require("keymaps.definitions")
