local M = {}

local map = require "utils.map"
local au = vim.api.nvim_create_autocmd

local packadd = function(list)
  for _, plugin in ipairs(list) do
    vim.cmd.packadd(plugin)
  end
end

local get_mode_and_lhs = function(keymaps)
  for mode, maplist in pairs(keymaps) do
    for lhs in pairs(maplist) do
      coroutine.yield(mode, lhs)
    end
  end
end

local trigger_keys = function(keymaps)
  return coroutine.wrap(function()
    get_mode_and_lhs(keymaps)
  end)
end

local feedkeys = function(lhs)
  local keys = vim.api.nvim_replace_termcodes(lhs, true, false, true)
  vim.api.nvim_feedkeys(keys, "m", false)
end

M.on_keys = function(keymaps, plugins, setup)
  map.validate_all(keymaps)
  for mode, lhs in trigger_keys(keymaps) do
    vim.keymap.set(mode, lhs, function()
      packadd(plugins)
      setup()
      local rhs = keymaps[mode][lhs][2]
      if type(rhs) == "function" then rhs()
      else vim.schedule(function() feedkeys(lhs) end) end
      map.clear_all(keymaps)
      map(keymaps)
    end)
  end
end

local validate = function(event, group, patterns)
  vim.validate {
    key1 = { event, "string" },
    key2 = { group, "number" },
    key3 = { patterns, function(x)
      return vim.tbl_islist(x) or type(x) == "string"
    end}
  }
end

M.on_event = function(args, plugins, setup)
  local event, group, patterns = args[1], args[2], args[3]
  validate(event, group, patterns)
  au(event, {
    group = group,
    pattern = patterns,
    callback = function()
      packadd(plugins)
      setup()
    end
  })
end

return M
