local present, cmp = pcall(require, 'cmp')

if not present then
	return
end

vim.opt.completeopt = "menuone,noselect"

cmp.setup {
	window = {
		completion = cmp.config.window.bordered(),
		documenation = cmp.config.window.bordered(),
	},

	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert {
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<CR>'] = cmp.mapping.confirm{ select = true },
		['<C-e>'] = cmp.mapping.abort(),
	},

	sources = cmp.config.sources {
		{name = 'nvim_lsp'},
		{name = 'buffer'},
		{name = 'luasnip'},
		{name = 'path'}
	}
}

