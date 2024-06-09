local Recursive = require "fonts.recursive"

local M = {}

---@param config config
function M.setup(config)
  config.initial_cols = 120
  config.initial_rows = 24

  -- Disable titlebar but enable resizable border
  config.window_decorations = "RESIZE"
  config.native_macos_fullscreen_mode = true

  config.window_padding = {
    left = "3cell",
    right = "3cell",
    top = "0",
    bottom = "1cell",
  }

  config.window_frame = {
    font = wezterm.font(Recursive.SemicasualBold),
    font_size = 16,
  }
end

return M
