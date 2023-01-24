local gh = require "github-theme"

gh.setup {
  theme_style = "light",
  hide_inactive_statusline = false,
  hide_end_of_buffer = false,
  sidebars = {
    "qf",
    "man",
    "help",
    "lazy",
    "terminal",
    "neo-tree",
  },
}
