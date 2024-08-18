---@meta

---@class wezterm
---@field action { [string]: KeyAssignment }
---@field action_callback fun(cb: fun(win: Window, pane: Pane))
---@field config_builder fun(): config
---@field home_dir string
---@field strftime fun(str: string): string
---@field font fun(attrs: FontAttributes): ResolvedFont
---@field font_with_fallback fun(attrs: (string|FontAttributes)[]): ResolvedFont
---@field log_info fun(...)
---@field log_warn fun(...)
---@field log_err fun(...)
---@field reload_configuration function
---@field GLOBAL table<string, string | boolean | number | table | nil>
---@field sleep_ms fun(ms: integer)
---@field target_triple string
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
---@field get_appearance fun(): "Dark" | "Light" | "LightHighContrast" | "DarkHighContrast"
wezterm.gui = {}

---@class wezterm.mux
---@field get_window fun(id: integer): MuxWindow
wezterm.mux = {}

---@class wezterm.color
---@field get_builtin_schemes fun(): { [string]: Palette }
---@field get_default_colors fun(): Palette
wezterm.color = {}

---@class wezterm.action
---@field SpawnCommandInNewTab fun(args: SpawnCommand): KeyAssignment
---@field SpawnCommandInNewWindow fun(args: SpawnCommand): KeyAssignment
wezterm.action = {}

---@class config
---@field background BackgroundLayer[]
---@field font FontAttributes | string
---@field font_size number
---@field line_height number
---@field font_rules FontRule[]
---@field color_scheme string
---@field color_schemes { [string]: Palette | nil }
---@field term string
---@field set_environment_variables CustomEnvironmentVariables
---@field use_fancy_tab_bar boolean
---@field [string] any

---@class BackgroundSource
---@field Color? string

---@class BackgroundLayer
---@field source BackgroundSource
---@field opacity number
---@field height string | number
---@field width string | number

---@class CustomEnvironmentVariables
---@field CONFIG_COLORS string
---@field CONFIG_COLORS_DARK string
---@field CONFIG_COLORS_LIGHT string
---@field [string] string | nil

---@class KeyAssignment: function

---@class Palette
---@field background string
---@field foreground string
---@field tab_bar TabBarColors
---@field [string] string | { [string]: string }

---@class TabBarColors
---@field background string
---

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

---@class MuxWindow

---@class Window
---@field effective_config fun(self: Window): config
---@field get_config_overrides fun(self: Window): config
---@field set_config_overrides fun(self: Window, config: config): config
---@field perform_action fun(self: Window, key_assignment: KeyAssignment, pane: Pane)
---@field get_dimensions fun(self: Window): { pixel_width: number, pixel_height: number, dpi: number, is_full_screen: boolean }

---@class Pane
---@field get_user_vars fun(self: Pane): table<string, string>

---@class PaneInformation

---@class TabInformation
---@field tab_id string The identifier for this tab.
---@field tab_index integer The logical tab position within its containing window, with 0 indicating the leftmost tab.
---@field is_active boolean True if this tab is the active tab.
---@field active_pane PaneInformation The `PaneInformation` for the active pane in this tab.
---@field window_id string The identifier of the window that contains this tab.
---@field window_title string The title of the window that contains this tab.
---@field tab_title string? The title of this tab.

---@class SpawnCommand
---@field args? string[]
---@field set_environment_variables? { [string]: string }
---@field domain string
