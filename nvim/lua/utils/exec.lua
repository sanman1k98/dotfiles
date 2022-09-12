local exec

local api = {}
api.exec_autocmds = vim.api.nvim_exec_autocmds



exec = {}
exec.au = {}

do local mt = {}
  mt.__call = function(_, event, opts)
    api.exec_autocmds(event, opts)
  end

  setmetatable(exec.au, mt)
end


exec.au.user = {}

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

  setmetatable(exec.au.user, mt)
end



return exec
