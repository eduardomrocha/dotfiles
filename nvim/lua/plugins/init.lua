return require("packer").startup(function()
	use("wbthomason/packer.nvim")
	use("olimorris/onedarkpro.nvim")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({
		"akinsho/bufferline.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	})
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
	})
	use("windwp/nvim-ts-autotag")
	use("p00f/nvim-ts-rainbow")
	use("windwp/nvim-autopairs")
	use("folke/which-key.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		requires = "nvim-lua/plenary.nvim",
	})
	use("numToStr/Navigator.nvim")
	use("terrortylor/nvim-comment")

	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-calc")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-cmdline")
	use("octaltree/cmp-look")
	use("ray-x/cmp-treesitter")
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("onsails/lspkind-nvim")
	use("petertriho/cmp-git")
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
	})
	-- use 'tami5/lspsaga.nvim'
	use("rafamadriz/friendly-snippets")
	use("github/copilot.vim")
	use("nathom/filetype.nvim")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("ray-x/lsp_signature.nvim")
	use("folke/twilight.nvim")
	use({
		"lewis6991/gitsigns.nvim",
		requires = "nvim-lua/plenary.nvim",
	})
	use({
		"rrethy/vim-hexokinase",
		run = "make hexokinase",
	})
	use("folke/lsp-colors.nvim")
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	})
	use("ur4ltz/surround.nvim")
	use("simrat39/symbols-outline.nvim")
	use("famiu/bufdelete.nvim")
	use({
		"phaazon/hop.nvim",
		branch = "v1",
	})
	use("rmagatti/auto-session")
	use({
		"rmagatti/session-lens",
		requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
	})
	use({
		"heavenshell/vim-pydocstring",
		run = "make install",
	})
	use("glepnir/dashboard-nvim")
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
end)
