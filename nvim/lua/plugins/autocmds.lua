local function autocmds()
  require("luauto").setup()

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

  -- close certain filetypes with `q`
  vim.autocmd.FileType[{
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "startuptime",
  }](function(e)
    vim.bo[e.buf].buflisted = false
    vim.keymap.set("n", "q", vim.cmd.close, { buffer = e.buf })
  end)

  vim.autocmd.TextYankPost(function()
    vim.highlight.on_yank()
  end)

  -- check if we need to reload the file
  vim.autocmd[{ "FocusGained", "TermClose", "TermLeave" }](function()
    vim.cmd.checktime()
  end)
end

return {
  dir = "~/Projects/luauto.nvim",
  lazy = false,
  init = autocmds,
}
