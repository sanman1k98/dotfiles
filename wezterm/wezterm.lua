local wezterm = require "wezterm"

local font = wezterm.font



local conf = {
  font = font "Cascadia Code PL",
  font_size = 14,
  line_height = 1.6,

  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,

  window_padding = {
    left = "40px",
    right = "40px",
    top = "40px",
    bottom = "40px",
  },

  color_scheme = "dawnfox",
}



return conf
