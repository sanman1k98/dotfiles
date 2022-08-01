local present, notify = pcall(require, 'notify')

if not present then
	return
end

-- change notify function globally

vim.notify = notify.setup {
	stages = 'fade',
}
