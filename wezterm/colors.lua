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
function M.apply(config, colors)
  colors.tab_bar.background = colors.background
  config.colors = colors
  config.window_frame = config.window_frame or {}
  config.window_frame.active_titlebar_bg = colors.background
  config.window_frame.inactive_titlebar_bg = colors.background
  config.window_frame.active_titlebar_fg = colors.foreground
  config.window_frame.inactive_titlebar_fg = colors.foreground
  return config
end

local function config_colors_changed(window, _, name, value)
  if name ~= "CONFIG_COLORS" then
    return
  end
  local config = window:get_config_overrides() or {}
  local colors = M.get(value)
  M.apply(config, colors)
  window:set_config_overrides(config)
end

---@param config config
---@param schemes { light: string, dark: string }
function M.setup(config, schemes)
  M.dark = schemes.dark
  M.light = schemes.light

  local name, colors
  if M.is_gui_dark() then
    name = schemes.dark
    colors = M.get(schemes.dark)
  else
    name = schemes.light
    colors = M.get(schemes.light)
  end

  config.set_environment_variables = config.set_environment_variables or {}
  config.set_environment_variables.CONFIG_COLORS = name
  config.set_environment_variables.CONFIG_COLORS_DARK = schemes.dark
  config.set_environment_variables.CONFIG_COLORS_LIGHT = schemes.light

  M.apply(config, colors)

  wezterm.on("user-var-changed", config_colors_changed)
end

return M
