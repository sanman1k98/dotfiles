local gh = require "github-theme"

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
