local present1, cmp = pcall(require, 'cmp')
local present2, luasnip = pcall(require, 'luasnip')

if not (present1 or present2) then
	return
end

vim.opt.completeopt = "menuone,noselect"

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources {
		{name = 'nvim_lsp'},
		{name = 'luasnip'},
		{name = 'buffer'},
		{name = 'path'}
	}
}
