local M = {}

function M.setup(config)
  config.initial_cols = 120
  config.initial_rows = 24

  -- Disable titlebar but enable resizable border
  config.window_decorations = "RESIZE"
  config.native_macos_fullscreen_mode = true

  config.window_padding = {
    left = "40pt",
    right = "40pt",
    top = "40pt",
    bottom = "40pt",
  }
end

return M
