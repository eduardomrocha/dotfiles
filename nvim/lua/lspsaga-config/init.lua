local saga = require("lspsaga")

saga.init_lsp_saga({
	code_action_icon = "",
	border_style = "rounded",
	code_action_num_shortcut = true,
	show_diagnostic_source = true,
	move_in_saga = { prev = "<C-k>", next = "<C-j>" },
	finder_action_keys = {
		quit = "<ESC>",
		scroll_up = "<C-d>",
	},
	code_action_keys = {
		quit = "<ESC>",
	},
	rename_action_quit = "<ESC>",
})
