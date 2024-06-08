local wezterm = require "wezterm"

local M = {}

local shared_features = {
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

M.family = "Rec Mono"

M.SemicasualBold = wezterm.font {
  family = "Rec Mono Semicasual",
  style = "Normal",
  weight = "Bold",
  harfbuzz_features = shared_features,
}

M.SemicasualBoldItalic = wezterm.font {
  family = "Rec Mono Semicasual",
  style = "Italic",
  weight = "Bold",
  harfbuzz_features = shared_features,
}

return M
