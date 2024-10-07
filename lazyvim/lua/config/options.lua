local opt = vim.opt
local g = vim.g

-- disable formatting on save
g.autoformat = false

-- enable displaying hidden characters
opt.list = true

-- characters to display whitespace
opt.listchars = {
  trail          = "~",    -- trailing whitespace
  eol            = "↲",    -- end of line
  multispace     = " ⋅ •", -- used cyclically to show multiple consecutive spaces; overrides "space"
  leadmultispace = "⋅⋅⋅•", -- used cyclically to show multiple consecutive leading spaces; overrides "multispace"
  tab            = "  ⠶",  -- 3 chars `xyz` to show a <tab>; `z` is always used, `x` is prepended, `y` is used as many times as can fit
}

-- lines to scroll with a mouse
opt.mousescroll = {
  "ver:1",    -- default: 3
  "hor:1",    -- default: 3
}

