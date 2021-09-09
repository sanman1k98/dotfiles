local set_keymap = vim.api.nvim_set_keymap

local function map(modes, lhs, rhs, args)
  args = args or {}
	-- assign args.noremap to 'true' if it is not already defined
  args.noremap = (args.noremap == nil and true) or args.noremap
  if type(modes) == 'string' then modes = {modes} end
  for _, mode in ipairs(modes) do set_keymap(mode, lhs, rhs, args) end
end

return {map = map}

