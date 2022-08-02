local present, tree = pcall(require, "nvim-tree")

if not present then
	return
end

tree.setup {
	view = {
		width = 25,
		hide_root_folder = true,
		adaptive_size = true
	},

	renderer = {
		icons = {
			git_placement = "after"
		},
		group_empty = true,
		special_files = {}
	},

	actions = {
		open_file = {
			quit_on_open = true
		}
	}
}
