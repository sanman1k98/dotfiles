---@meta

---@class wezterm
---@field action { [string]: Action }
---@field config_builder fun(): config
---@field home_dir string
---@field strftime fun(str: string): string
---@field font fun(attrs: FontAttributes): ResolvedFont
_G.wezterm = {}

---@vararg string|table
---@return string
function wezterm.format(...)
  return ""
end

---@param event string
---@param cb fun(window: Window, pane: Pane)
function wezterm.on(event, cb)
end

---@class wezterm.gui
---@field get_appearance fun(): string
wezterm.gui = {}

---@class wezterm.color
---@field get_builtin_schemes fun(): { [string]: Colors }
wezterm.color = {}

---@class config
---@field font FontAttributes | string
---@field font_size number
---@field line_height number
---@field font_rules FontRule[]
---@field color_scheme string
---@field term string
---@field set_environment_variables table
---@field use_fancy_tab_bar boolean
---@field [string] any

---@class Action: function

---@class Colors
---@field background string
---@field foreground string
---@field [string] any

---@class FontRule
---@field italic? boolean
---@field intensity? "Half"|"Normal"|"Bold"
---@field font ResolvedFont

---@class FontAttributes
---@field family string
---@field style string
---@field weight string
---@field harfbuzz_features string[]

---@class ResolvedFont: string

---@class PaneInformation

---@class TabInformation
---@field tab_id string The identifier for this tab.
---@field tab_index integer The logical tab position within its containing window, with 0 indicating the leftmost tab.
---@field is_active boolean True if this tab is the active tab.
---@field active_pane PaneInformation The `PaneInformation` for the active pane in this tab.
---@field window_id string The identifier of the window that contains this tab.
---@field window_title string The title of the window that contains this tab.
---@field tab_title string? The title of this tab.
