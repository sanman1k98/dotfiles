local M = {}

local shared_features = {
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

M.Argon = {
  family = "Monaspace Argon",
  style = "Normal",
  weight = "DemiBold",
  harfbuzz_features = shared_features,
}

M.ArgonLighter = {
  family = "Monaspace Argon",
  style = "Normal",
  weight = "ExtraLight",
  harfbuzz_features = shared_features,
}

M.Radon = {
  family = "Monaspace Radon",
  style = "Normal",
  weight = "DemiBold",
  harfbuzz_features = shared_features,
}

M.RadonLighter = {
  family = "Monaspace Radon",
  style = "Normal",
  weight = "ExtraLight",
  harfbuzz_features = shared_features,
}

return M
