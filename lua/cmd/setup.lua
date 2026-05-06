local M = {}

function M.change_neo_tree_root_to_pwd()
	local cur_path = vim.fn.getcwd()
	vim.cmd("Neotree dir=" .. cur_path)
end

function M.change_pwd_to_neo_tree_root()
	local state = require("neo-tree.sources.manager").get_state("filesystem")
	local neo_tree_root = state and state.path
	if neo_tree_root then
		vim.api.nvim_command("cd " .. neo_tree_root)
	end
end

vim.api.nvim_create_user_command("NvimTreeUpdateRoot2Pwd", M.change_neo_tree_root_to_pwd, {})
vim.api.nvim_create_user_command("NvimTreeUpdatePwd2Root", M.change_pwd_to_neo_tree_root, {})

return M
