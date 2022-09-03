-- Emulating the Ex command with the following form.
-- :au[tocmd] [group] {event} {aupat} [++once] [++nested] {cmd}
local au = {}

local managed_augroups = {}     -- mapping of group names to group IDs
local managed_autocmds = {}     -- list of autocmds; see ":h nvim_get_autocmds()"

local api = {}
api.new_autocmd = vim.api.nvim_create_autocmd
api.del_autocmd = vim.api.nvim_del_autocmd

api.new_augroup = vim.api.nvim_create_augroup
api.del_augroup = vim.api.nvim_del_augroup_by_name

api.get_autocmds = vim.api.nvim_get_autocmds
api.clear_autocmds = vim.api.nvim_clear_autocmds
api.exec_autocmds = vim.api.nvim_exec_autocmds



do -- create, get, and delete autocommand/groups
  function au:get(opts)
    if not opts then return managed_autocmds end
    local id = opts.id
    opts.id = nil
    local matches = api.get_autocmds(opts)
    if id == nil then return matches end
    for _, a in ipairs(matches) do
      if a.id == id then return a end
    end
    return nil
  end

  function au:add(event, opts)
    local id = api.new_autocmd(event, opts)
    local a = au:get {
      group = opts.group,
      event = event,
      pattern = opts.pattern,
      id = id               -- passing the ID returns a single dict
    }
    table.insert(managed_autocmds, a)
    return id
  end

  function au:del(x)
    if type(x) == "number" then
      local au_id = x
      for i = #managed_autocmds, 1, -1 do         -- iterate backwards
        if managed_autocmds[i].id == au_id then
          table.remove(managed_autocmds, i)       -- table.remove shifts the rest of the list
          api.del_autocmd(au_id)
          return
        end
      end
      api.del_autocmd(au_id)
      return
    elseif type(x) == "string" then
      local aug_name = x
      for _, a in ipairs(managed_autocmds) do
        if a.group_name == aug_name then au:del(a.id) end
      end
      managed_augroups[aug_name] = nil
      api.del_augroup(aug_name)
      return
    end
  end

  function au:clear(opts)
    -- TODO: vim.validate parameters
    if opts.pattern and opts.buffer then
      error('Cannot use "pattern" and "buffer" key simultaneously', 2)
    end

    -- Go through each of the managed_autocmds and don't remove them if they
    -- don't match the specified opts.
    for i = #managed_autocmds, 1, -1 do
      local a = managed_autocmds[i]
      if opts.buffer and a.buffer ~= opts.buffer then goto continue end
      if opts.group and a.group_name ~= opts.group then goto continue end
      if opts.event then
        if type(opts.event) == "string" then opts.event = { opts.event } end
        local match = false
        for _, e in ipairs(opts.event) do
          if e == a.event then match = true; break end
        end
        if not match then goto continue end
      end
      if opts.pattern then
        if type(opts.pattern) == "string" then opts.pattern = { opts.pattern } end
        local match = false
        for _, p in ipairs(opts.pattern) do
          if p == a.pattern then match = true; break end
        end
        if not match then goto continue end
      end
      table.remove(managed_autocmds, i)
      ::continue::
    end
    api.clear_autocmds(opts)
  end

  function au:group(name, opts)
    managed_augroups[name] = api.new_augroup(name, opts)
    return managed_augroups[name]
  end

  function au:exec(event, opts)
    api.exec_autocmds(event, opts)
  end
end


do -- custom augroups
  local au_mt = {}

  function au_mt:__index(key_as_group)
    local grp_tbl, grp_mt = {}, {}

    function grp_tbl:get(opts)
      opts = opts or {}
      opts.group = key_as_group
      return au:get(opts)
    end

    function grp_tbl:del()
      au:del(key_as_group)
    end

    function grp_tbl:new(opts)
      return au:group(key_as_group, opts)
    end

    function grp_tbl:clear(opts)
      opts = opts or {}
      opts.group = key_as_group
      au:clear(opts)
    end

    function grp_tbl:id()
      return managed_augroups[key_as_group]
    end

    if not managed_augroups[key_as_group] then return grp_tbl end

    function grp_mt:__index(key_as_event)
      local evnt_tbl, evnt_mt = {}, {}

      function evnt_tbl:get(pat)
        local opts = {
          group = key_as_group,
          event = key_as_event,
          pattern = pat,
        }
        return au:get(opts)
      end

      function evnt_tbl:clear(opts)
        opts = opts or {}
        opts.group = key_as_group
        opts.event = key_as_event
        au:clear(opts)
      end

      function evnt_tbl:add(opts)
        if not opts then error() end
        opts.group = key_as_group
        opts.callback = opts[1] or opts.callback
        return au:add(key_as_event, opts)
      end

      function evnt_tbl:__call(opts)
        opts = opts or {}
        opts.group = key_as_group
        opts.event = key_as_event
        au:exec(key_as_event, opts)
      end

      function evnt_mt:__index(key_as_pattern)
        local pat_tbl, pat_mt = {}, {}

        function pat_tbl:get(opts)
          opts = opts or {}
          opts.group = key_as_group
          opts.event = key_as_event
          opts.pattern = key_as_pattern
          return au:get(opts)
        end

        function pat_tbl:clear(opts)
          opts = opts or {}
          if opts.buffer then error('Cannot use "buffer" key when specifying "pattern"', 2) end
          opts.group = key_as_group
          opts.event = key_as_event
          opts.pattern = key_as_pattern
          au:clear(opts)
        end

        function pat_tbl:add(opts)
          if not opts then error() end
          if opts.buffer then error('Cannot use "buffer" key when specifying "pattern"', 2) end
          opts.group = key_as_group
          opts.pattern = key_as_pattern
          opts.callback = opts[1] or opts.callback
          return au:add(key_as_event, opts)
        end

        function pat_mt:__call(data, opts)
          opts = opts or {}
          if opts.buffer then error('Cannot use "buffer" key when specifying "pattern"', 2) end
          opts.group = key_as_group
          opts.pattern = key_as_pattern
          opts.data = data
          au:exec(key_as_event, opts)
        end

        return setmetatable(pat_tbl, pat_mt)
      end

      return setmetatable(evnt_tbl, evnt_mt)
    end

    return setmetatable(grp_tbl, grp_mt)
  end

  setmetatable(au, au_mt)
end
