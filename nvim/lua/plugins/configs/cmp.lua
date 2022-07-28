local present1, cmp = pcall(require, 'cmp')
local present2, luasnip = pcall(require, 'luasnip')

if not (present1 or present2) then
	return
end

vim.opt.completeopt = "menuone,noselect"

-- copied from NvChad plugins.configs.cmp module
local function border(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert {
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<CR>'] = cmp.mapping.confirm{ select = true },
		['<C-e>'] = cmp.mapping.abort(),
	},

	sources = cmp.config.sources {
		{name = 'nvim_lsp'},
		{name = 'luasnip'},
		{name = 'buffer'},
		{name = 'path'}
	}
}
