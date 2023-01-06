local function autocmds()
  -- TODO: refactor into `require("luauto").setup()`
  local auto = require "luauto"
  _G.vim.autocmd = auto.cmd
  _G.vim.augroup = auto.group

  -- vim.autocmd.User.VeryLazy(function()
  --   require("util.map").loadall()
  -- end)

  vim.autocmd.TextYankPost(function()
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

  vim.augroup.cursorline(function(au)
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
end

return {
  dir = "~/Projects/luauto.nvim",
  lazy = false,
  init = autocmds,
}
