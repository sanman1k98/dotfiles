local M = {}

M.date_format = "%a %m/%d %I:%M"

local styles = {
  info = {
    { Foreground = { AnsiColor = "Fuchsia" } },
    { Attribute = { Intensity = "Half" } },
  },
  danger = {
    { Attribute = { Intensity = "Bold" } },
    { Background = { AnsiColor = "Red" } },
    { Foreground = { AnsiColor = "Black" } },
  },
  hover = {
    { Background = { AnsiColor = "Green" } },
    { Foreground = { AnsiColor = "White" } },
  },
  none = {},
}

local c = {}

function c:__index(k)
  return function(str)
    local items = {}
    for _, v in ipairs(styles[k]) do
      table.insert(items, v)
    end
    table.insert(items, { Text = str })
    table.insert(items, "ResetAttributes")
    return wezterm.format(items)
  end
end

setmetatable(c, c)

local function update_status(window, pane)
  local debug = pane:get_title() == "Debug"
  local date_format = M.date_format .. (debug and ":%S" or "")
  local text = string.format("  %s  ", wezterm.strftime(date_format))

  if not debug then
    window:set_left_status("")
    return window:set_right_status(c.info(text))
  end

  window:set_left_status(c.danger("  DEBUG OVERLAY  "))
  window:set_right_status(c.danger(text))
end

---@param tab_info TabInformation
---@param hover boolean
---@return string | table title
local function format_tab_title(tab_info, hover)
  local title = string.format("  %s  ", tab_info.tab_index + 1)
  if hover then
    return {
      { Background = { AnsiColor = "Green" } },
      { Foreground = { AnsiColor = "White" } },
      { Text = title },
    }
  else
    return {
      { Text = title },
    }
  end
end

--- If there is one tab, then we return an empty string which effectively hides the tab.
---@param tab TabInformation TabInformation for the active tab.
---@param tabs TabInformation[] A list containing TabInformation for each of the tabs in the window.
---@param pane PaneInformation[] A list contain PaneInformation for each of the panes in the active tab.
---@param config table The effective configuration in the window.
---@param hover boolean `true` if the current tab is in the hover state.
---@return string | table title Text or a list of `FormatTable`.
local function format_tab_titles(tab, tabs, pane, config, hover)
  if #tabs == 1 then
    return ""
  end
  return format_tab_title(tab, hover)
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
