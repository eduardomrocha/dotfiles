require("lualine").setup({
	options = { theme = "onedark" },
	extensions = { "nvim-tree" },
	sections = {
		lualine_b = {
			"branch",
			"diff",
			{
				"diagnostics",
				symbols = { error = " ", warn = " ", hint = " ", info = " " },
			},
		},
		lualine_c = { require("auto-session-library").current_session_name },
	},
})
