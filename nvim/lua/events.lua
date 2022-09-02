local au = require "utils.au"
local doau = require "utils.doau"



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
    callback = doau.user.config_changed
  })
end

do -- highlight on yank
  au("TextYankPost", {
    group = au.group.user_highlight_on_yank.id,
    callback = doau.user.on_yank
  })
end

do -- toggle cursorline
  au("WinEnter", {
    group = au.group.user_toggle_cursorline.id,
    callback = doau.user.enter_window
  })
  au("WinLeave", {
    group = au.group.user_toggle_cursorline.id,
    callback = doau.user.leave_window
  })
end



if not vim.opt.loadplugins:get() then return end



do -- re-register plugins
  local filename = vim.fn.stdpath("config") .. "/lua/plugins.lua"
  au("BufWritePost", {
    group = au.group.user_register_plugins.id,
    pattern = filename,
    callback = doau.user.plugins_changed
  })
end



