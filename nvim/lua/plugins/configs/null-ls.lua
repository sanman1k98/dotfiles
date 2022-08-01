local present, nls = pcall(require, 'null-ls')

if not present then
	return
end

nls.setup {
	sources = {
		nls.builtins.formatting.stylua,
		nls.builtins.code_actions.gitsigns,
	}
}
