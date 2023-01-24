local util = require "util"
local notify = require "util.notify"

---@class ColorsUtility
local M = {}

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

--- Create autocmds during startup to set the colorscheme when the TUI or other
--- UI sets the `bg` option, or when lazy.nvim finishes loading.
---@param themes {dark:string, light:string}
function M.setup(themes)
  if M.did_setup then return end
  M.themes = themes
  local opts = { nested = true, once = true, }
  util.augroup.startup_colors(function(au)
    au.OptionSet.background(function() M.set() end, opts)
  end)
  M.did_setup = true
end

return M
