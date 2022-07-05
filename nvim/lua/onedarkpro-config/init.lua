local onedarkpro = require("onedarkpro")

onedarkpro.setup({
	-- The theme to be used. Can be either `onedark` or `onelight`. Leave blank to let `vim.o.background` dictate
	theme = function()
		if vim.o.background == "dark" then
			return "onedark"
		else
			return "onelight"
		end
	end,
	colors = {}, -- Override default colors
	hlgroups = {}, -- Override default highlight groups
	styles = {
		strings = "NONE", -- Style that is applied to strings
		comments = "italic", -- Style that is applied to comments
		keywords = "bold,italic", -- Style that is applied to keywords
		functions = "bold", -- Style that is applied to functions
		variables = "NONE", -- Style that is applied to variables
	},
	options = {
		bold = true, -- Use the themes opinionated bold styles?
		italic = true, -- Use the themes opinionated italic styles?
		underline = true, -- Use the themes opinionated underline styles?
		undercurl = true, -- Use the themes opinionated undercurl styles?
		transparent = false, -- Use a transparent background?
		cursorline = true, -- Use cursorline highlighting?
	},
})

onedarkpro.load()
