local M = {}
local util = require "util"

M.pp = vim.pretty_print

function M.d(...)
  if _G.DEBUG == false then return end
  local here = debug.getinfo(1, "S")
  local level = 2
  local info = debug.getinfo(level, "S")
  while info and info.source == here.source do
    level = level + 1
    info = debug.getinfo(level, "S")
  end
  info = info or here
  local source = info.source:sub(2)
  source = vim.loop.fs_realpath(source) or source
  source = vim.fn.fnamemodify(source, ":~:.")..":"..info.linedefined
  local stuff = vim.deepcopy({...})
  for _, o in pairs(stuff) do
    util.info(vim.inspect(o))
  end
end

return function()
  for k, v in pairs(M) do
    _G[k] = v
  end
end
