local M = {}

local notifier = {}

notifier.backlog = {}

notifier.backend = function(...)
  table.insert(notifier.backlog, {...})
end

notifier.call = function(msg, lvl, opts)
  opts = opts or {}
  opts.title = opts.title or "$MYVIMRC"
  notifier.backend(msg, lvl, opts)
end

function notifier:setup()
  local checker = vim.loop.new_check()                  -- creates a new check handle
  local start = vim.loop.hrtime()
  checker:start(function()                              -- runs the given callback once per loop iteration
    if package.loaded.notify then
      self.backend = package.loaded.notify
    elseif (vim.loop.hrtime() - start) / 1e6 > 1000 then
      self.backend = vim.notify
    else
      return
    end
    checker:stop()                                      -- stop calling this callback
    vim.schedule(function()                             -- on the main loop,
      for _, item in ipairs(self.backlog) do            -- go through the backlog,
        self.call(unpack(item))                         -- notify user
      end
    end)
  end)
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

notifier:setup()

return setmetatable(M, {
  __call = function(_, ...) notifier.call(...) end,
})
