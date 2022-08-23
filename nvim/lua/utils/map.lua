-- TODO use `vim.validate` to validate the parameter specification.

--[[

This custom `map` function takes a table as an argument and and iterates
through its nested values to pass through the `vim.keymap.set` function.

The table should have the following shape:
{
	{ mode } = {
		{ lhs } = { { rhs }, { opts } },
		...
	},
	...
}

Each `mode` can contain multiple "mappings", and each mapping has a `lhs`
key. The value of each mapping is its `rhs` and optional `desc` string or
`opts` table.

The following is from `:h vim.keymap.set()`

{mode}  string|table Same mode short names as
        |nvim_set_keymap()|. Can also be list of modes to
        create mapping on multiple modes.
{lhs}   (string) Left-hand side |{lhs}| of the mapping.
{rhs}   string|function Right-hand side |{rhs}| of the
        mapping. Can also be a Lua function. If a Lua
        function and `opts.expr == true`, returning `nil`
        is equivalent to an empty string.
{opts}  string|table A description of the mapping or a table of
				|:map-arguments| such as "silent". In addition to the options
				listed in |nvim_set_keymap()|, this table also accepts the
				following keys:
        • buffer: (number or boolean) Add a mapping to the
          given buffer. When "true" or 0, use the current
          buffer.
        • replace_keycodes: (boolean, default true) When
          both this and expr is "true",
          |nvim_replace_termcodes()| is applied to the
          result of Lua expr maps.
        • remap: (boolean) Make the mapping recursive.
          This is the inverse of the "noremap" option from
          |nvim_set_keymap()|. Default `false`.


-- example table
{
	i = {										-- mode
		['kj'] = {						-- lhs
			'<esc>',						-- rhs
			'leave insert mode'	-- descripion
		},
	},

	n = {
		['<leader>ff'] = {		-- lhs
			function()
				require'telescope.builtins'.find_files()	-- rhs
			end,
			{ desc = 'fuzzy find files'}								-- opts
		}
	}
}

]]

return function(tb)
	for mode, mappings in pairs(tb) do
		for lhs, mapping in pairs(mappings) do

			local rhs, opts = mapping[1], mapping[2]
			if type(opts) == "string" then
				opts = { desc = mapping[2] }
			end

			vim.keymap.set(mode, lhs, rhs, opts)

		end
	end
end
