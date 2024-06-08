local wezterm = require "wezterm"

local M = {}

-- TODO: ensure Wezterm's TERM definition.
M.TERMINFO_DIRS = wezterm.home_dir .. "/.local/share/terminfo"

function M.setup(config)
  config.set_environment_variables = {
    TERMINFO_DIRS = M.TERMINFO_DIRS,
  }
  config.term = "wezterm"
end

return M
