local M = {}

local notifier = {
  backlog = {},
  builtin = vim.notify,
}

function notifier.defer(...)
  table.insert(notifier.backlog, {...})
end

function notifier.init()
  vim.notify = notifier.defer                           -- set notifier to defer
  local checker = vim.loop.new_check()                  -- creates a new check handle
  local start = vim.loop.hrtime()
  checker:start(function()                              -- runs the given callback once per loop iteration
    local deferring = (vim.notify == notifier.defer)
    if deferring then
      if (vim.loop.hrtime() - start) / 1e6 > 1000 then
        vim.notify = notifier.builtin                   -- use the builtin notifier if it's been a sec
      else
        return                                          -- return, we'll call this next loop iteration
      end
    end
    checker:stop()                                      -- stop calling this callback
    vim.schedule(function()                             -- on the main loop,
      for _, item in ipairs(notifier.backlog) do        -- go through the backlog,
        vim.notify(unpack(item))                        -- notify user
      end
    end)
  end)
end

function M.info(msg, name)
  vim.notify(msg, vim.log.levels.INFO, {
    title = "$MYVIMRC: "..(name or ""),
  })
end

function M.warn(msg, name)
  vim.notify(msg, vim.log.levels.WARN, {
    title = "$MYVIMRC: "..(name or ""),
  })
end

function M.err(msg, name)
  vim.notify(msg, vim.log.levels.ERROR, {
    title = "$MYVIMRC: "..(name or ""),
  })
end

notifier.init()

return setmetatable(M, {
  __call = function(_, ...) vim.notify(...) end,
})
