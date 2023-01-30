local util = require "util"
local notify = require "util.notify"

---@class ColorsUtility
local M = {}

---@type boolean
M.light = nil

---@type {dark:string, light:string}
M.themes = {}

--- Set the theme for the given background setting. Use current background
--- setting if not provided.
---@param bg? string
function M.set(bg)
  return vim.cmd.colorscheme(M.themes[bg or vim.go.bg])
end

--- Returns the name of the theme configured for the given background, or
--- current background if not specified..
---@param bg? string
function M.get(bg)
  return M.themes[bg or vim.go.bg]
end

---@return "dark"|"light"
function M.bg_inverse()
  return vim.go.bg == "dark" and "light" or "dark"
end

--- Switch between the light and dark colorscheme.
function M.switch()
  M.set(M.bg_inverse())
  notify.info(("# Colorscheme: `%s`"):format(vim.g.colors_name))
end

--- Return true if a given RGB color is visually perceived to be light.
---@param hex string prefixed with "#" in the form "rrggbb"
---@return boolean light true if perceived to be a light color
---@see http://alienryderflex.com/hsp.html
function M.is_light(hex)
  assert(hex:sub(1, 1) == "#", "expected string prefixed with '#'")
  local digits = hex:sub(2)
  assert(#digits == 6, "expected 24-bit RGB hex code")
  local R = tonumber(digits:sub(1, 2), 16)
  local G = tonumber(digits:sub(3, 4), 16)
  local B = tonumber(digits:sub(5, 6), 16)
  -- Square both sides to avoid computing square root.
  return 16256 < (0.299*R*R + 0.587*G*G + 0.114*B*B)
end

local did_colorscheme = false
function M.plugin_init(plugin)
  if did_colorscheme then return end
  if M.light == nil then
    local colors = require("util.kitty").get_colors()
    M.light = M.is_light(colors.background)
    vim.go.bg = M.light and "light" or "dark"
  end
  local pat = plugin.pattern
  if M.light and M.themes.light:find(pat) then
    vim.cmd.colorscheme(M.themes.light)
    did_colorscheme = true
  elseif not M.light and M.themes.dark:find(pat) then
    vim.cmd.colorscheme(M.themes.dark)
    did_colorscheme = true
  end
end

--- Create autocmds during startup to set the colorscheme when the TUI or other
--- UI sets the `bg` option, or when lazy.nvim finishes loading.
---@param opts {light: boolean, themes:{dark:string, light:string}}
function M.setup(opts)
  if M.did_setup then
    return
  else
    M.did_setup = true
  end
  M.themes = opts.themes
  M.light = opts.light
end

return M
