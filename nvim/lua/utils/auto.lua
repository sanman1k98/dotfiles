local au

local managed_augroups = {}     -- mapping of group names to group IDs
local managed_autocmds = {}     -- list of autocmds; see ":h nvim_get_autocmds()"

local api = {}
api.new_autocmd = vim.api.nvim_create_autocmd
api.del_autocmd = vim.api.nvim_del_autocmd
api.clear_autocmds = vim.api.nvim_clear_autocmds

api.new_augroup = vim.api.nvim_create_augroup
api.del_augroup = vim.api.nvim_del_augroup_by_name

api.exec_autocmds = vim.api.nvim_exec_autocmds
api.get_autocmds = vim.api.nvim_get_autocmds



au = {}             -- wrapper around API functions to create, get, and delete, autocmds
au.get = function(opts, id)
  local matches = api.get_autocmds(opts)
  if id == nil then return matches end
  for _, a in ipairs(matches) do
    if a[id] == id then return a end
  end
  -- error "Cannot find the autocmd we just created wtf"
end

au.new = function(event, opts)
  local id = api.new_autocmd(event, opts)
  local a = au.get({
    group = opts.group,
    event = event,
    pattern = opts.pattern,
  }, id) -- passing the ID returns a single dict
  table.insert(managed_autocmds, a)
  return id
end

au.del = function(id)
  for i = #managed_autocmds, 1, -1 do         -- iterate backwards
    if managed_autocmds[i].id == id then
      table.remove(managed_autocmds, i)       -- table.remove shifts the rest of the list
      return api.del_autocmd(id)
    end
  end
  return api.del_autocmd(id)
end




do local mt = {}
  mt.__call = function(_, event, opts)
    return au.new(event, opts)
  end

  setmetatable(au, mt)
end


au.group = {}       -- indexable by group name to create, clear, and get IDs of augroups
do local mt = {}
  local del_managed = function(name)
    for _, a in ipairs(managed_autocmds) do
      if a.group_name == name then au.del(a.id) end
    end
    managed_augroups[name] = nil
    return api.del_augroup(name)
  end

  mt.__index = function(_, name)
    if not managed_augroups[name] then
      managed_augroups[name] = api.new_augroup(name, {})
    end
    return {
      id = managed_augroups[name],
      name = name,
      del = del_managed(name)
    }
  end

  mt.__newindex = function(_, name, value)
    if value == nil then
      del_managed(name)
    end
  end

  setmetatable(au.group, mt)
end


au.user = {}        -- indexable by user event name to add callbacks to matching User events
do local mt = {}
  mt.__call = function(_, custom_event, opts)
    opts = opts or {}
    opts.pattern = custom_event
    au.new("User", opts)
  end

  mt.__index = function(_, custom_event)
    return function(callback, opts)
      opts = opts or {}
      opts.callback = callback
      opts.pattern = custom_event
      au.new("User", opts)
    end
  end

  setmetatable(au.user, mt)
end



return au
