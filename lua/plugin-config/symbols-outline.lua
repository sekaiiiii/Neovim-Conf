local status_ok, outline = pcall(require, "symbols-outline")
if not status_ok then
  vim.notify("Plugin Error: can't find symbols-outline plugin")
  return
end

local opts = {
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = false,
  position = "right",
  relative_width = true,
  width = 25,
  auto_close = false,
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  preview_bg_highlight = "Pmenu",
  autofold_depth = nil,
  auto_unfold_hover = true,
  fold_markers = { "", "" },
  wrap = false,
  keymaps = require("keymaps.plugins").symbols_outline(),
  lsp_blacklist = {},
  symbol_blacklist = {},
}

outline.setup(opts)
