require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
			},
		},
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
	},
})

vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_width = 25
