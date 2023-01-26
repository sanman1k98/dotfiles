local opt = vim.opt_local

opt.tabstop = 2
opt.expandtab = true

-- Allow cmments to start with 2 or 3 dashes for annotating. Makes formatting
-- descriptions with `gw` easier.
opt.comments = {
  ":---",
  ":--",
}
