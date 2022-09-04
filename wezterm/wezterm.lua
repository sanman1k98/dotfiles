local wezterm = require "wezterm"

local font = wezterm.font



local conf = {
  font = font "Cascadia Code PL",
  font_size = 13,
  line_height = 1.3,

  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,

  color_scheme = "Catppuccin Mocha",
}



return conf
