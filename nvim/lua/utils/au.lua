local au
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local del_aug = vim.api.nvim_del_augroup_by_name

local get_aug_id = function(name)
  local list = vim.api.nvim_get_autocmds { group = name }
  return list[1].group    -- "group" key contains ID
end



au = {}
au.group = {}


do
  local mt = {}

  mt.__index = function(_, name)
    return get_aug_id(name)
  end

  mt.__newindex = function(_, name, create)
    if create then return augroup(name)
    else return del_aug(name) end
  end

  setmetatable(au.group, mt)
end


do
  local mt = {}

  mt.__call = function(_, ...)
    return autocmd(...)
  end

  setmetatable(au, mt)
end


au.user = function(pattern, callback)
end
