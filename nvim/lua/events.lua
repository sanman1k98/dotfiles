local au = require "utils.auto"
local exec = require "utils.exec"
-- Indexing this table with an arbitrary key name returns a callback when
-- executed, triggers an user event with a pattern matching the key name.
local trigger = exec.au.user


do -- user config
  local files = {
    "/lua/keymaps.lua",
    "/lua/options.lua"
  }
  local pattern = vim.tbl_map(function(f)
    return vim.fn.stdpath("config") .. f
  end, files)

  au("BufWritePost", {
    group = au.group.user_config_reload.id,
    pattern = pattern,
    callback = trigger.config_changed       -- ":doau User config_changed"
  })
end

do -- highlight on yank
  au("TextYankPost", {
    group = au.group.user_highlight_on_yank.id,
    callback = trigger.on_yank
  })
end

do -- toggle cursorline
  au("WinEnter", {
    group = au.group.user_toggle_cursorline.id,
    callback = trigger.enter_window
  })
  au("WinLeave", {
    group = au.group.user_toggle_cursorline.id,
    callback = trigger.leave_window
  })
end



if not vim.opt.loadplugins:get() then return end



do -- re-register plugins
  local filename = vim.fn.stdpath("config") .. "/lua/plugins.lua"
  au("BufWritePost", {
    group = au.group.user_register_plugins.id,
    pattern = filename,
    callback = trigger.plugins_changed
  })
end



