local opt = vim.opt_local

opt.spell = true
opt.tabstop = 2
opt.expandtab = true

-- Allow comments to start with 2 or 3 dashes for annotating. Makes formatting
-- descriptions with `gw` easier.
opt.comments = {
  ":---",
  ":--",
}
