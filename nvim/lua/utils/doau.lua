local doau

local api = {}
api.exec_autocmds = vim.api.nvim_exec_autocmds



doau = {}

do local mt = {}
  mt.__call = function(_, event, opts)
    api.exec_autocmds(event, opts)
  end

  setmetatable(doau, mt)
end


doau.user = {}

do local mt = {}
  mt.__call = function(_, custom_event, opts)
    opts = opts or {}
    opts.pattern = custom_event
    api.exec_autocmds("User", opts)
  end

  mt.__index = function(_, custom_event)
    local cb = function(t)
      local opts = {}
      opts.pattern = custom_event
      opts.data = t
      api.exec_autocmds("User", opts)
    end
    return cb
  end

  setmetatable(doau.user, mt)
end



return doau
