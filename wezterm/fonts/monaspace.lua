local wezterm = require "wezterm"

local M = {}

function M.setup(config)
  config.font_size = 14
  config.line_height = 1.7

  config.font = wezterm.font {
    family = "Monaspace Argon",
    weight = "Medium",
  }

  config.font_rules = {
    -- Use Radon for unbolded italics.
    {
      italic = true,
      intensity = "Normal",
      font = wezterm.font {
        family = "Monaspace Radon",
        weight = "Medium",
        italic = false,
      },
    },
    -- Use ArrowType's Recursive font for bold and bold italics.
    {
      italic = true,
      intensity = "Bold",
      font = wezterm.font {
        family = "Rec Mono Semicasual",
        weight = "Bold",
        italic = true,
      },
    },
    {
      intensity = "Bold",
      font = wezterm.font {
        family = "Rec Mono Semicasual",
        weight = "Bold",
      },
    },
  }
end

return M
