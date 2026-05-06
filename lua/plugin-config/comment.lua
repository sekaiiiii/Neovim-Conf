local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  vim.notify("Plugin Error: can't find Comment plugin")
  return
end

comment.setup(vim.tbl_extend("force", {
  padding = true,
  sticky = true,
  ignore = nil,
  pre_hook = nil,
  post_hook = nil,
}, require("keymaps.plugins").comment()))
