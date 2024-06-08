local wezterm = require "wezterm"
local terminfo = require "terminfo"
local window = require "window"
local tab_bar = require "tab_bar"
local keys = require "keys"
local fonts = require "fonts"

local config = wezterm.config_builder()

terminfo.setup(config)
window.setup(config)
tab_bar.setup(config)
keys.setup(config)

local Monaspace, Recursive = fonts.Monaspace, fonts.Recursive

config.font = Monaspace.Argon
config.font_size = 14
config.line_height = 1.7

config.font_rules = {
  {
    italic = false,
    intensity = "Half",
    font = Monaspace.ArgonLighter,
  },
  -- Monaspace Radon for a handwritten style.
  {
    italic = true,
    intensity = "Normal",
    font = Monaspace.Radon,
  },
  {
    italic = true,
    intensity = "Half",
    font = Monaspace.RadonLighter,
  },
  -- Recursive Mono for a semi-casual, brush-painted style.
  {
    italic = false,
    intensity = "Bold",
    font = Recursive.SemicasualBold,
  },
  {
    italic = true,
    intensity = "Bold",
    font = Recursive.SemicasualBoldItalic,
  },
}

if wezterm.gui.get_appearance():find("Dark") then
  config.color_scheme = "carbonfox"
else
  config.color_scheme = "dawnfox"
end

return config
