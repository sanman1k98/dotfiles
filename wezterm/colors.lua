---@class colors
local M = {}

function M.is_gui_dark()
  return wezterm.gui.get_appearance() == "Dark" and true or false
end

--- Get the color palette for the given colorscheme.
---@param scheme string
---@return Palette
function M.get_palette(scheme)
  local palette = wezterm.color.get_builtin_schemes()[scheme]
  if not palette then
    wezterm.log_err(string.format("Colorscheme '%s' not found", scheme))
    palette = wezterm.color.get_default_colors()
  end
  do -- customizations
    palette.tab_bar.background = "rgba(0 0 0 0)"
  end
  return palette
end

---@param config config
---@param name string
---@param palette Palette
function M.define_scheme(config, name, palette)
  config.color_schemes = config.color_schemes or {}
  config.color_schemes[name] = palette
  return config
end

---@param config config
---@param palette Palette
function M.apply_palette(config, palette)
  local frame = config.window_frame or {}
  frame.active_titlebar_bg = palette.background
  frame.inactive_titlebar_bg = palette.background
  frame.active_titlebar_fg = palette.foreground
  frame.inactive_titlebar_fg = palette.foreground

  local base_layer = {
    source = { Color = palette.background },
    opacity = 0.90,
    height = "100%",
    width = "100%",
  }

  config.window_frame = frame
  config.background = { base_layer }
  config.macos_window_background_blur = 70

  return config
end

---@param window Window
---@param user_var string
---@param scheme string
local function config_colors_changed(window, _, user_var, scheme)
  if user_var ~= "CONFIG_COLORS" then
    return
  end

  STATE.COLOR_SCHEME = scheme
  local config = window:effective_config()
  local overrides = window:get_config_overrides() or {}
  local color_schemes = config.color_schemes or {}
  local palette = color_schemes[scheme]

  if not palette then
    palette = M.get_palette(scheme)
    M.define_scheme(overrides, scheme, palette)
  end

  -- local env = config.set_environment_variables or {}
  -- env.CONFIG_COLORS = scheme
  -- overrides.set_environment_variables = env

  overrides.color_scheme = scheme
  M.apply_palette(overrides, palette)
  -- Reload current window's config with updated colors
  window:set_config_overrides(overrides)
  -- PERF: reloading all windows slows down current window colors.
  wezterm.sleep_ms(350)
  -- HACK: force override `config.set_environment_variables`.
  -- Spawning a new tab in the current window will not have a shell spawned
  -- with the new `config.set_environment_variables` applied unless we
  -- explicity re-evaluate the config for all windows.
  wezterm.reload_configuration()
end

---@param config config
---@param schemes { light: string, dark: string } Colorscheme names.
function M.setup(config, schemes)
  local env = config.set_environment_variables or {}
  local scheme = STATE.COLOR_SCHEME

  if not scheme then
    scheme = M.is_gui_dark() and schemes.dark or schemes.light
    STATE.COLOR_SCHEME = scheme
  end

  M.define_scheme(config, schemes.light, M.get_palette(schemes.light))
  M.define_scheme(config, schemes.dark, M.get_palette(schemes.dark))
  M.apply_palette(config, config.color_schemes[scheme])
  config.color_scheme = scheme

  env.CONFIG_COLORS_LIGHT = schemes.light
  env.CONFIG_COLORS_DARK = schemes.dark
  env.CONFIG_COLORS = scheme
  config.set_environment_variables = env

  wezterm.on("user-var-changed", config_colors_changed)
end

return M
