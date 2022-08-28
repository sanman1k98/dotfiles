-- This module creates an augroup for every entry in the "group_names" list, and
-- each augroup name gets prefixed with "user_". Returns a table with keys that
-- are the names of the created augroups, and values with their correspoding ID.

local M = {}

local aug = vim.api.nvim_create_augroup

local augroup_names = {
  "cursorline_toggler",   -- toggle cursorline when entering and exiting windows
  "on_yank_highlighter",  -- highlight on yank
  "config_reloader",      -- reload user config files when certain buffers get written
  "plugin_register",      -- re-register plugins with Paq when changed
}

for _, name in ipairs(augroup_names) do
  name = "user_" .. name
  M[name] = aug(name)
end

return M
