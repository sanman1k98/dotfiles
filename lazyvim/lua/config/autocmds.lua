vim.augroup.cursorline(function(au)
  au:clear()

  local disabled = {
    "snacks_dashboard",
    "mason",
    "lazy",
    "fzf",
  }

  local function set_cul(v)
    ---@param args vim.api.keyset.create_autocmd.callback_args
    return function(args)
      vim.wo.cul = v and not vim.list_contains(disabled, vim.bo[args.buf].ft)
    end
  end

  local function set_culopt(v)
    return function()
      vim.wo.culopt = v
    end
  end

  -- enable cursorline for the active window
  au.WinEnter(set_cul(true))
  au.WinLeave(set_cul(false))
  -- only highlight the number in insert mode
  au.InsertEnter(set_culopt("number"))
  au.InsertLeave(set_culopt("number,line")) -- default
end)
