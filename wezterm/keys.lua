local act = wezterm.action

local M = {}

M.keys = {
  { key = "UpArrow", mods = "SHIFT", action = act.ScrollToPrompt(-1) },
  { key = "DownArrow", mods = "SHIFT", action = act.ScrollToPrompt(1) },
}

---@param config config
function M.setup(config)
  config.enable_kitty_keyboard = true
  config.keys = M.keys
end

return M
