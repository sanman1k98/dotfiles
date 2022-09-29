local map = {}

map.modes = {
  [1] = "n",        -- Normal
  [2] = "s",        -- Select
  [3] = "x",        -- Visual
  [4] = "o",        -- Operator-pending
  [5] = "i",        -- Insert
  [6] = "c",        -- Command-line
  [7] = "t",        -- Terminal
}

do
  local m = {}

  m.n, m.normal            = map.modes[1], map.modes[1]
  m.s, m.select            = map.modes[2], map.modes[2]
  m.x, m.visual            = map.modes[3], map.modes[3]
  m.o, m.operator_pending  = map.modes[4], map.modes[4]
  m.i, m.insert            = map.modes[5], map.modes[5]
  m.c, m.command_line      = map.modes[6], map.modes[6]
  m.t, m.terminal          = map.modes[7], map.modes[7]

  m[""]  = {
    m.normal,
    m.select,
    m.visual,
    m.operator_pending,
  }

  m["v"] = {
    m.select,
    m.visual,
  }

  m["!"] = {
    m.insert,
    m.command_line,
  }

  local mt = {}

  function mt:__call(tbl)
    tbl = tbl or map.modes
    local iter = function()
      for k, v in pairs(tbl) do
        if type(k) == "number" then   -- tbl is a list
          if type(v) == "table" then  -- assume maparg()-like dict
            assert(type(v.mode) == "string" and #v.mode <= 1)
            coroutine.yield(v.mode)
          else
            assert(type(v) == "string")
            coroutine.yield(v)
          end
        else
          coroutine.yield(k)
        end
      end
    end
    return coroutine.wrap(function() iter() end)
  end

  mt.__index = m

  setmetatable(map.modes, mt)
end

-- returns the mode, lhs, and info given a table
function map.iter(tbl)
  local iter = function()
    for k, v in pairs(tbl) do
      if type(k) == "number" then   -- tbl is a list of maparg()-like dicts
        if type(v) == "table" then
          local mode, lhs, info = v.mode, v.lhs, v
          assert(type(mode) == "string" and #mode == 1)
          coroutine.yield(mode, lhs, info)
        else
          assert(type(v) == "string")
          local mode = v
          if #mode > 1 then
            mode = map.modes[mode]
            assert(mode ~= nil)
          end
          coroutine.yield(mode)
        end
      else
        assert(type(k) == "string")
        local mode = k
        if #mode > 1 then
          mode = map.modes[mode]
          assert(mode ~= nil)
        end
        for lhs, info in pairs(v) do
          if type(lhs) == "string" then
            assert(type(info) == "table")
            coroutine.yield(mode, lhs, info)
          else
            assert(type(info) == "string")
            lhs = info
            coroutine.yield(mode, lhs)
          end
        end
      end
    end
  end
  return coroutine.wrap(function() iter() end)
end

function map.args(tbl)
  local iter = function(t)
    for mode, lhs, info in map.iter(t) do
      local rhs = info[1]
      local opts = info.opts or {}
      opts.desc, opts.buffer = info.desc, info.buffer
      coroutine.yield(mode, lhs, rhs, opts)
    end
  end
  return coroutine.wrap(function() iter(tbl) end)
end

function map.get(tbl, buf)
  vim.validate {
    tbl = { tbl, "t" },
    buf = { buf, {"b", "n"}, true },
  }
  local api_get = vim.api.nvim_get_keymap
  if buf then
    buf = buf == true and 0 or buf
    api_get = function(m)
      return vim.api.nvim_buf_get_keymap(buf, m)
    end
  end
  local tmplist, in_tmplist = {}, {}
  for mode in map.iter(tbl) do
    if not in_tmplist[mode] then
      vim.list_extend(tmplist, api_get(mode))
      in_tmplist[mode] = true
      if type(map.modes[mode]) == "table" then
        for _, m in ipairs(map.modes[mode]) do
          in_tmplist[m] = true
        end
      end
    end
  end
  local mappings = {}
  for mode, lhs in map.iter(tbl) do
    for tmpmode, tmplhs, tmpinfo in map.iter(tmplist) do
      if tmpmode == mode or type(map.modes[mode]) == "table" and vim.tbl_contains(map.modes[mode], tmpmode) then
        if not lhs or tmplhs == vim.api.nvim_replace_termcodes(lhs, true, true, true) then
          table.insert(mappings, tmpinfo)
        end
      end
    end
  end
  return mappings
end

-- TODO: better error messages
function map.set(tbl, buf)
  for mode, lhs, rhs, opts in map.args(tbl) do
    opts.buffer = opts.buffer or buf
    if not opts.desc then
      local m = string.format("No description supplied for keymap %q in mode %q.", lhs, mode)
      vim.notify(m, vim.log.levels.WARN)
    end
    local set, errmsg = pcall(vim.keymap.set, mode, lhs, rhs, opts)
    if not set then
      local m = string.format("Error setting keymap %q in mode %q:\n%s", lhs, mode, errmsg)
      vim.notify(m, vim.log.levels.ERROR)
      goto continue
    end
    ::continue::
  end
end

function map.del(tbl, buf)
  for mode, lhs, info in map.iter(tbl) do
    local opts = { buffer = info.buffer or buf } 
    vim.keymap.del(mode, lhs, opts)
  end
end

return map
