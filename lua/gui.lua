-- 字体名称
-- vim.g.font = 'CodeNewRoman Nerd Font Mono'
-- vim.g.font = 'ComicShannsMono Nerd Font'
-- vim.g.font = 'BlexMono Nerd Font Mono'
vim.g.font = "FiraCode Nerd Font"
-- vim.g.font = "Arimo Nerd Font"
-- vim.g.font = "Cousine Nerd Font Mono"
-- 字体大小
vim.g.fontSize = 12

if vim.g.neovide then
	vim.g.neovide_input_macos_option_key_is_meta = "only_left"
	vim.o.guifont = vim.g.font .. ":h" .. vim.g.fontSize
	vim.o.linespace = 1
	vim.g.neovide_transparency = 0.8
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	vim.g.neovide_floating_shadow = true
	vim.g.neovide_floating_z_height = 10
	vim.g.neovide_light_angle_degrees = 45
	vim.g.neovide_light_radius = 5
	vim.g.neovide_theme = "auto"
else
	if vim.fn.exists(":GuiFont") == 2 then
		local cmd = "GuiFont " .. vim.g.font .. ":h" .. vim.g.fontSize
		vim.api.nvim_command(cmd)
	end

	if vim.fn.exists(":GuiTabline") == 2 then
		local cmd = "GuiTabline 0"
		vim.api.nvim_command(cmd)
	end

	if vim.fn.exists(":GuiPopupmenu") == 2 then
		local cmd = "GuiPopupmenu 0"
		vim.api.nvim_command(cmd)
	end

	if vim.fn.exists(":GuiScrollBar") == 2 then
		local cmd = "GuiScrollBar 0"
		vim.api.nvim_command(cmd)
	end

	if vim.fn.exists(":GuiTreeviewHide") == 2 then
		local cmd = "GuiTreeviewHide"
		vim.api.nvim_command(cmd)
	end

	if vim.fn.exists(":GuiAdaptiveColor") == 2 then
		local cmd = "GuiAdaptiveColor 2"
		vim.api.nvim_command(cmd)
	end

	if vim.fn.exists(":GuiLinespace") == 2 then
		local cmd = "GuiLinespace 0.2"
		vim.api.nvim_command(cmd)
	end

	if vim.fn.exists(":GuiWindowOpacity") == 2 then
		local cmd = "GuiWindowOpacity 0.9"
		vim.api.nvim_command(cmd)
	end
end
