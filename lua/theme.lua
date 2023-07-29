local colorscheme = "github_dark_high_contrast"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("ColorScheme Error: " .. colorscheme .. " can't find")
  return
end

require("github-theme").setup({
  options = {
    transparent = true,
  },
})
