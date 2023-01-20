local util = require "util"
local a = util.api

-- from folke/dot

local M = {}

local notifier = {}

notifier.backlog = {}

---@diagnostic disable-next-line: duplicate-set-field
notifier.backend = function(...)
  table.insert(notifier.backlog, {...})
end

-- from folke/lazy.nvim/lua/lazy/util.lua
notifier.default_opts = {
  title = "$MYVIMRC",
  on_open = function(win)
    local buf = a.win_get_buf(win)
    vim.wo[win].conceallevel = 3
    vim.wo[win].concealcursor = "n"
    vim.wo[win].spell = false
    vim.bo[buf].filetype = "markdown"
    vim.treesitter.start(buf, "markdown")
  end,
}

notifier.call = function(msg, lvl, opts)
  opts = vim.tbl_deep_extend("force", notifier.default_opts, opts or {})
  notifier.backend(msg, lvl, opts)
end

function notifier:setup()
  local orig = vim.notify
  local check = vim.loop.new_check()                  -- creates a new check handle
  local timer = vim.loop.new_timer()
  local replay = function()
    timer:stop()
    check:stop()
    self.backend = vim.notify
    vim.schedule(function()                             -- on the main loop,
      for _, item in ipairs(self.backlog) do            -- go through the backlog,
        self.call(unpack(item))                         -- notify user
      end
    end)
  end
  check:start(function()                              -- runs the given callback once per loop iteration
    if vim.notify ~= orig then
      replay()
    end
  end)
  timer:start(1000, 0, replay)
end

function M.info(msg, name)
  notifier.call(msg, vim.log.levels.INFO, { title = name })
end

function M.warn(msg, name)
  notifier.call(msg, vim.log.levels.WARN, { title = name })
end

function M.err(msg, name)
  notifier.call(msg, vim.log.levels.ERROR, { title = name })
end

function M.setup()
  notifier:setup()
end

return setmetatable(M, {
  __call = function(_, ...) notifier.call(...) end,
})
