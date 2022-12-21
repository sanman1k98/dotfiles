local auto = require "luauto"
local autocmd, augroup = auto.cmd, auto.group


-- highlight on yank
autocmd.TextYankPost(function()
  vim.highlight.on_yank()
end)


-- highlight current cursor location
local cul = function(toggle)
  return function() vim.opt_local.cul = toggle end
end

augroup.cursorline(function(au)
  au:clear()
  au.WinEnter(cul(true))
  au.WinLeave(cul(false))
  au.FileType["mason"](cul(false))
end)


-- manage plugins
autocmd.VimEnter(function()
  require "plugins"
  return true
end)
