_G.wezterm = require "wezterm"

local terminfo = require "terminfo"
local window = require "window"
local tab_bar = require "tab_bar"
local colors = require "colors"
local keys = require "keys"
local fonts = require "fonts"

local config = wezterm.config_builder()

terminfo.setup(config)
window.setup(config)
tab_bar.setup(config)
keys.setup(config)

colors.setup(config, {
  dark = "carbonfox",
  light = "dawnfox",
})

local Monaspace, Recursive = fonts.Monaspace, fonts.Recursive

config.font = wezterm.font(Monaspace.Argon)
config.font_size = 14
config.line_height = 1.7
config.cursor_thickness = 3

config.font_rules = {
  -- Recursive Mono for half intensities
  {
    italic = false,
    intensity = "Half",
    font = wezterm.font(Recursive.Semicasual),
  },
  {
    italic = true,
    intensity = "Half",
    font = wezterm.font(Recursive.SemicasualItalic),
  },
  -- Monaspace Radon for a handwritten style.
  {
    italic = true,
    intensity = "Normal",
    font = wezterm.font(Monaspace.Radon),
  },
  -- Recursive Mono for a semi-casual, brush-painted style.
  {
    italic = false,
    intensity = "Bold",
    font = wezterm.font(Recursive.SemicasualBold),
  },
  {
    italic = true,
    intensity = "Bold",
    font = wezterm.font(Recursive.SemicasualBoldItalic),
  },
}

return config
