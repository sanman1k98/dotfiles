local M = {}
local util = require "util"

M.pp = vim.pretty_print

-- from folk/dot
local function get_location()
  local info = debug.getinfo(3, "S")
  local src = info.source:sub(2)
  src = vim.loop.fs_realpath(src) or src
  return vim.fn.fnamemodify(src, ":~:.")..":"..info.linedefined
end

local function dump(...)
  local stuff = {...}
  stuff = #stuff == 1 and stuff[1] or stuff
  local msg = vim.inspect(vim.deepcopy(stuff))
  local loc = get_location()
  return (function()
    util.notify(msg, vim.log.levels.INFO, {
      title = ("$MYVIMRC : %s"):format(loc),
      on_open = function(win)
        vim.wo[win].conceallevel = 3
        vim.wo[win].concealcursor = ""
        vim.wo[win].spell = false
        local buf = vim.api.nvim_win_get_buf(win)
        if not pcall(vim.treesitter.start, buf, "lua") then
          vim.bo[buf].filetype = "lua"
        end
      end,
    })
  end)
end

function M.d(...)
  dump(...)()
end

function M.dd(...)
  vim.schedule(dump(...))
end

local function set_globals()
  for k, v in pairs(M) do
    _G[k] = v
  end
end

set_globals()
