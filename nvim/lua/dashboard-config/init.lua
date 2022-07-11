-- vim.g.dashboard_default_executive = "telescope"
local db = require("dashboard")

db.custom_header = {
	"                                                       ",
	"                                                       ",
	"                                                       ",
	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
	"                                                       ",
	"                                                       ",
	"                                                       ",
}

db.custom_center = {
	{
		icon = "   ",
		desc = "Load Session            ",
		action = "Telescope session-lens search_session",
		shortcut = "SPC s f",
	},
	{
		icon = "   ",
		desc = "Find File               ",
		action = "Telescope find_files find_command=rg,--hidden,--files",
		shortcut = "SPC f  ",
	},
	{
		icon = "   ",
		desc = "Find Text               ",
		action = "Telescope live_grep",
		shortcut = "SPC g p",
	},
	{
		icon = "   ",
		desc = "Open Personal dotfiles  ",
		action = "edit " .. os.getenv("HOME") .. "/dotfiles",
		shortcut = "       ",
	},
}

local plugins_count = vim.fn.len(vim.fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1))
db.custom_footer = {
	"                                                ",
	"🎉 neovim loaded " .. plugins_count .. " plugins",
}
