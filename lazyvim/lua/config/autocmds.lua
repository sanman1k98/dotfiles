local function cul(set)
  return function()
    vim.opt_local.cul = set
  end
end

local function culopt(set)
  return function()
    vim.opt_local.culopt = set
  end
end

vim.augroup.cursorline(function(au, clear)
  clear()
  -- enable cursorline for the active window
  au.WinEnter(cul(true))
  au.WinLeave(cul(false))
  -- only highlight the number in insert mode
  au.InsertEnter(culopt({ "number" }))
  au.InsertLeave(culopt({ "number", "line" })) -- default
  -- disbale cursorline for these filetypes
  au.FileType[{
    "alpha",
    "mason",
    "TelescopePrompt",
  }](cul(false))
end)
