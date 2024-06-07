local wezterm = require "wezterm"

local M = {}

local shared_monaspace_features = {
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
}

local rec_mono_features = {
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
}

local MonaspaceArgon = wezterm.font {
  family = "Monaspace Argon",
  style = "Normal",
  weight = "Medium",
  harfbuzz_features = shared_monaspace_features,
}

local MonaspaceRadon = wezterm.font {
  family = "Monaspace Radon",
  style = "Normal",
  weight = "Medium",
  harfbuzz_features = shared_monaspace_features,
}

local RecMonoSemicasualBold = wezterm.font {
  family = "Rec Mono Semicasual",
  style = "Normal",
  weight = "Bold",
  harfbuzz_features = rec_mono_features,
}

local RecMonoSemicasualBoldItalic = wezterm.font {
  family = "Rec Mono Semicasual",
  style = "Italic",
  weight = "Bold",
  harfbuzz_features = rec_mono_features,
}

function M.setup(config)
  config.font_size = 14
  config.line_height = 1.7

  config.font = MonaspaceArgon

  config.font_rules = {
    -- Use Radon for handwritten italics.
    {
      italic = true,
      intensity = "Normal",
      font = MonaspaceRadon,
    },
    -- Use ArrowType's Recursive Mono for bold.
    {
      italic = false,
      intensity = "Bold",
      font = RecMonoSemicasualBold,
    },
    {
      italic = true,
      intensity = "Bold",
      font = RecMonoSemicasualBoldItalic,
    },
  }
end

return M
