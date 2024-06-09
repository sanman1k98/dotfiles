local act = wezterm.action

local M = {}

M.keys = {
  -- SHIFT-CMD-l activates the debug overlay
  { key = "l", mods = "SHIFT|SUPER", action = act.ShowDebugOverlay },
}

---@param config config
function M.setup(config)
  config.enable_kitty_keyboard = true
  config.keys = M.keys
end

return M
