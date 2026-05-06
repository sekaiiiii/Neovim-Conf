local status_ok, autoSession = pcall(require, "auto-session")
if not status_ok then
  vim.notify("Plugin Error: can't find auto-session plugin")
  return
end

vim.o.sessionoptions =
"blank,buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions"

local function close_neo_tree() vim.cmd("Neotree close") end

autoSession.setup({
  log_level = "error",
  -- 打开这些目录里面的内容时，不加载会话
  auto_session_suppress_dirs = {},
  auto_session_enable_last_session = false,
  -- 保存session文件到data目录
  auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
  auto_session_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = false,
  auto_session_create_enabled = false,
  auto_session_use_git_branch = nil,
  -- the configs below are lua only
  bypass_session_save_file_types = nil,
  pre_save_cmds = { close_neo_tree },
  post_restore_cmds = {}
})
