local opt = vim.opt
local g = vim.g

-- disable formatting on save
g.autoformat = false

-- characters to display whitespace
opt.listchars = {
  trail          = "~",    -- trailing whitespace
  eol            = "↲",    -- end of line
  space          = "⋅",    -- a single <space>
  leadmultispace = "⋅⋅⋅•", -- used cyclically to show multiple consecutive leading spaces; overrides "space"
  tab            = "  ",  -- 3 chars `xyz` to show a <tab>; `z` is always used, `x` is prepended, `y` is used as many times as can fit
}

