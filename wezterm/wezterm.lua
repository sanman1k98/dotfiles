local wezterm = require "wezterm"
local terminfo = require "terminfo"
local font = require "fonts.monaspace"
local window = require "window"
local tab_bar = require "tab_bar"

local config = wezterm.config_builder()

terminfo.setup(config)
font.setup(config)
window.setup(config)
tab_bar.setup(config)

config.enable_kitty_keyboard = true

if wezterm.gui.get_appearance():find("Dark") then
  config.color_scheme = "carbonfox"
else
  config.color_scheme = "dawnfox"
end

return config
