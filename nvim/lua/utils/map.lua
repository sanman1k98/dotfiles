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

local M = {}

local _validate = vim.validate

local traverse = function(tb)
  local fn = function(t)
    for mode, maplist in pairs(t) do        -- each mode contains a list of mappings
      for lhs, mapargs in pairs(maplist) do  -- each pair in the list has a "lhs" and corresponding args
        local desc, rhs, opts = mapargs[1], mapargs[2], mapargs[3]
        if opts == nil then opts = { desc = desc }
        else opts.desc = desc end
        coroutine.yield(mode, lhs, rhs, opts)
      end
    end
  end
  return coroutine.wrap(function() fn(tb) end)
end

local validate_args = function(desc, rhs, opts)
  vim.validate {
    arg1 = { desc, "string" },
    arg2 = { rhs, {"string", "callable"} },
    arg3 = { opts, function(x)
      if x == nil then return true
      else
        return type(x) == "table" and x.desc == nil
      end
    end,
    "desc should be specified in the first position as a string for this mapping: "
  }
}
end


M.validate_all = function(tb)

  for mode, maplist in pairs(tb) do
    -- TODO: add some more validation logic
    _validate {
      mode = { mode, function(m)
        if type(m) ~= "string" then return false
        else return true end
      end
      }
    }

    for lhs, mapargs in pairs(maplist) do
      local desc, rhs, opts = mapargs[1], mapargs[2], mapargs[3]
      validate_args(desc, rhs, opts)
    end
  end

end


M.clear_all = function(keymaps)
  for mode, lhs in traverse(keymaps) do
    vim.keymap.del(mode, lhs)
  end
end


local map = function(tb)

	for mode, maplist in pairs(tb) do        -- each mode contains a list of mappings
		for lhs, mapargs in pairs(maplist) do  -- each pair in the list has a "lhs" and corresponding args

			local desc, rhs, opts = mapargs[1], mapargs[2], mapargs[3]
      validate_args(desc, rhs, opts)

      if opts == nil then
        opts = { desc = desc }
      else
        opts.desc = desc
      end

			vim.keymap.set(mode, lhs, rhs, opts)

		end
	end
end

return setmetatable(M, {
  __call = function(self, args)
    map(args)
    return self
  end
})
