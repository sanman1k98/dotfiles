vim.cmd.packadd "github-nvim-theme"

local loaded, gh = pcall(require, "github-theme")

if not loaded then
  return
end

gh.setup {
  theme_style = "dark_default",
  hide_inactive_statusline = false,
  hide_end_of_buffer = false,
  sidebars = {
    "qf",
    "terminal",
    "packer",
    "NvimTree",
  },
}
