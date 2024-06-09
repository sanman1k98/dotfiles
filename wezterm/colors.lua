---@class colors
---@field light string
---@field dark string
local M = {}

function M.is_gui_dark()
  return wezterm.gui.get_appearance():find("Dark") and true or false
end

--- 
---@param name string
---@return Colors
function M.get(name)
  return wezterm.color.get_builtin_schemes()[name]
end

--- Sets colors on the given `config` object.
---@param config config
---@param colors Colors
---@return config config Mutated `config` object.
function M.set(config, colors)
  colors.tab_bar.background = colors.background
  config.colors = colors
  config.window_frame = config.window_frame or {}
  config.window_frame.active_titlebar_bg = colors.background
  config.window_frame.inactive_titlebar_bg = colors.background
  config.window_frame.active_titlebar_fg = colors.foreground
  config.window_frame.inactive_titlebar_fg = colors.foreground
  return config
end

---@param config config
---@param schemes { light: string, dark: string }
function M.setup(config, schemes)
  M.dark = schemes.dark
  M.light = schemes.light
  local colors
  if M.is_gui_dark() then
    colors = M.get(schemes.dark)
  else
    colors = M.get(schemes.light)
  end
  M.set(config, colors)
end

return M
