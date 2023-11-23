local wezterm = require "wezterm"
local config = wezterm.config_builder()

config.font = wezterm.font "Cascadia Code PL"
config.font_size = 14
config.line_height = 1.6

config.initial_cols = 120
config.initial_rows = 24

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- config.term = "wezterm"
config.enable_kitty_keyboard = true

config.window_padding = {
  left = "40px",
  right = "40px",
  top = "40px",
  bottom = "40px",
}

if wezterm.gui.get_appearance():find("Dark") then
  config.color_scheme = "carbonfox"
else
  config.color_scheme = "dawnfox"
end

return config
