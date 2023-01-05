local auto = require "luauto"
local autocmd, augroup = auto.cmd, auto.group

autocmd.User.VeryLazy(function()
  require("util.map").loadall()
end)

autocmd.TextYankPost(function()
  vim.highlight.on_yank()
end)

local function set_cul(set)
  return (function()
    vim.opt_local.cul = set
  end)
end

local function cul_hl(set)
  return (function()
    vim.opt_local.culopt = set
  end)
end

augroup.cursorline(function(au)
  au:clear()
  -- enable cursorline for the active window
  au.WinEnter(set_cul(true))
  au.WinLeave(set_cul(false))
  -- only highlight the number in insert mode
  au.InsertEnter(cul_hl { "number" } )
  au.InsertLeave(cul_hl { "number", "line" } )  -- default
  -- disbale cursorline for these filetypes
  au.FileType[{
    "alpha",
    "mason",
    "TelescopePrompt",
  }](set_cul(false))
end)
