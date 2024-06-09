local M = {}

local function update_status(window)
  local date = wezterm.strftime "%a %x %I:%M  "

  local status = wezterm.format {
    { Attribute = { Intensity = "Bold" } },
    { Text = date },
  }

  window:set_right_status(status)
end

---@param tab_info TabInformation
---@return string title
local function format_tab_title(tab_info)
  return string.format("  %s  ", tab_info.tab_index + 1)
end

--- If there is one tab, then we return an empty string which effectively hides the tab.
---@param tab TabInformation TabInformation for the active tab.
---@param tabs TabInformation[] A list containing TabInformation for each of the tabs in the window.
---@param pane PaneInformation[] A list contain PaneInformation for each of the panes in the active tab.
---@param config table The effective configuration in the window.
---@param hover boolean `true` if the current tab is in the hover state.
---@return string title Text to use for the tab title.
local function format_tab_titles(tab, tabs, pane, config, hover)
  if #tabs > 1 then
    return format_tab_title(tab)
  else
    return ""
  end
end

---@param config config
function M.setup(config)
  config.use_fancy_tab_bar = false
  config.show_tab_index_in_tab_bar = false
  config.show_new_tab_button_in_tab_bar = false
  config.status_update_interval = 1000
  wezterm.on("update-status", update_status)
  wezterm.on("format-tab-title", format_tab_titles)
end

return M
