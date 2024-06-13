local act = wezterm.action

local M = {}

M.keys = {
}

---@param config config
function M.setup(config)
  config.enable_kitty_keyboard = true
  config.keys = M.keys
end

return M
