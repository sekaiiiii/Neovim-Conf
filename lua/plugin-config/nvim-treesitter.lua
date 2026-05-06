local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  vim.notify("Plugin Error: can't find nvim-treesitter plugin")
  return
end

local formattedTextCorrlation = { "json", "yaml" }
local gitCorrlation = { "gitignore", "gitcommit", "git_config", "git_rebase" }
local frontEndCorrlation = {
  "html",
  "css",
  "scss",
  "vue",
  "javascript",
  "tsx",
  "jsdoc",
}
local backEndCorrlation = { "sql", "bash" }
local pythonCorrlation = { "python" }
local luaCorrlation = { "lua" }
local markdownCorrlation = { "markdown" }
local dockerCorrlation = { "dockerfile" }
local otherCorrlation = { "markdown_inline", "regex" }

local ensure_install_array = _G.concatArray(
  formattedTextCorrlation,
  gitCorrlation,
  frontEndCorrlation,
  backEndCorrlation,
  luaCorrlation,
  pythonCorrlation,
  markdownCorrlation,
  dockerCorrlation,
  otherCorrlation
)
treesitter.setup({
  ensure_installed = ensure_install_array,
  auto_install = true,
  sync_install = false,
  -- 启用代码高亮模块
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  -- 启用增量选择模块
  incremental_selection = (function()
    local km = require("keymaps.plugins").treesitter().incremental_selection
    return { enable = true, keymaps = km.keymaps }
  end)(),
  -- 启用代码缩进模块 (=)
  indent = { enable = true },
  -- nvim-treesitter/nvim-treesitter-refactor
  refactor = {
    highlight_definitions = {
      enable = true,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = true,
    },
    highlight_current_scope = { enable = false },
  },
  -- nvim-treesitter/nvim-treesitter-textobjects
  textobjects = require("keymaps.plugins").treesitter().textobjects,
})
