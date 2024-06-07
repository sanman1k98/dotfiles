local wezterm = require "wezterm"

local M = {}

function M.setup(config)
  config.font_size = 14
  config.line_height = 1.7

  config.font = wezterm.font {
    family = "Monaspace Argon",
    style = "Normal",
    weight = "Medium",
    harfbuzz_features = {
      -- Texture healing
      "calt=1",
      -- Customized spacing of repeating characters
      "liga=1",
      -- Code ligatures
      "ss01=1",
      "ss02=1",
      "ss03=1",
      "ss04=1",
      "ss05=1",
      "ss06=1",
      "ss07=1",
      "ss08=1",
      "ss09=1",
    },
  }

  config.font_rules = {
    -- Use Radon for handwritten italics.
    {
      italic = true,
      intensity = "Normal",
      font = wezterm.font {
        family = "Monaspace Radon",
        -- Radon's normal style letterforms are already slightly sloped.
        style = "Normal",
        weight = "Medium",
        harfbuzz_features = {
          -- Texture healing
          "calt=1",
          -- Customized spacing of repeating characters
          "liga=1",
          -- Coding ligatures
          "ss01=1",
          "ss02=1",
          "ss03=1",
          "ss04=1",
          "ss05=1",
          "ss06=1",
          "ss07=1",
          "ss08=1",
          "ss09=1",
        },
      },
    },
    -- Use ArrowType's Recursive Mono font for bold.
    {
      italic = true,
      intensity = "Bold",
      font = wezterm.font {
        family = "Rec Mono Semicasual",
        weight = "Bold",
        italic = true,
        harfbuzz_features = {
          -- Code ligtures
          "dlig=1",
          -- Single-story 'a'
          "ss01=1",
          -- Single-story 'g'
          "ss02=1",
          -- Simplified 'f'
          "ss03=1",
          -- Simplified 'i'
          "ss04=1",
          -- Simplified 'l'
          "ss05=1",
          -- Simplified 'r'
          "ss06=1",
          -- Simplified italic diagonals
          "ss07=1",
          -- No-serif 'L' & 'Z'
          "ss08=1",
          -- Simplified six & nine
          "ss09=1",
          -- Dotted zero
          "ss10=1",
          -- Simplified one
          "ss11=1",
          -- Simplified mono 'at'
          "ss12=1",
          -- Uppercase punctuation
          "case=1"
        },
      },
    },
    {
      intensity = "Bold",
      font = wezterm.font {
        family = "Rec Mono Semicasual",
        weight = "Bold",
        harfbuzz_features = {
          -- Code ligtures
          "dlig=1",
          -- Single-story 'a'
          "ss01=1",
          -- Single-story 'g'
          "ss02=1",
          -- Simplified 'f'
          "ss03=1",
          -- Simplified 'i'
          "ss04=1",
          -- Simplified 'l'
          "ss05=1",
          -- Simplified 'r'
          "ss06=1",
          -- Simplified italic diagonals
          "ss07=1",
          -- No-serif 'L' & 'Z'
          "ss08=1",
          -- Simplified six & nine
          "ss09=1",
          -- Dotted zero
          "ss10=1",
          -- Simplified one
          "ss11=1",
          -- Simplified mono 'at'
          "ss12=1",
          -- Uppercase punctuation
          "case=1"
        },
      },
    },
  }
end

return M
