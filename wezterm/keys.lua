local wezterm = require "wezterm"

local M = {}

-- TODO: create some custom keymaps
function M.setup(config)
  config.enable_kitty_keyboard = true
end

return M
