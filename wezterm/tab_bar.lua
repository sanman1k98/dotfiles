local wezterm = require "wezterm"

local M = {}

local function update_status(window)
  local date = wezterm.strftime "%a %x %I:%M "

  local status = wezterm.format {
    { Attribute = { Intensity = "Bold" } },
    { Text = date },
  }

  window:set_right_status(status)
end

function M.setup(config)
  config.use_fancy_tab_bar = false
  config.hide_tab_bar_if_only_one_tab = true
  config.status_update_interval = 1000
  wezterm.on("update-status", update_status)
end

return M
