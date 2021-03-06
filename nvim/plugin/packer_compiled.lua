-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function("has", { "nvim-0.5" }) ~= 1 then
	vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
	return
end

vim.api.nvim_command("packadd packer.nvim")

local no_errors, error_msg = pcall(function()
	local time
	local profile_info
	local should_profile = false
	if should_profile then
		local hrtime = vim.loop.hrtime
		profile_info = {}
		time = function(chunk, start)
			if start then
				profile_info[chunk] = hrtime()
			else
				profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
			end
		end
	else
		time = function(chunk, start) end
	end

	local function save_profiles(threshold)
		local sorted_times = {}
		for chunk_name, time_taken in pairs(profile_info) do
			sorted_times[#sorted_times + 1] = { chunk_name, time_taken }
		end
		table.sort(sorted_times, function(a, b)
			return a[2] > b[2]
		end)
		local results = {}
		for i, elem in ipairs(sorted_times) do
			if not threshold or threshold and elem[2] > threshold then
				results[i] = elem[1] .. " took " .. elem[2] .. "ms"
			end
		end

		_G._packer = _G._packer or {}
		_G._packer.profile_output = results
	end

	time([[Luarocks path setup]], true)
	local package_path_str =
		"/Users/eduardomrocha/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/eduardomrocha/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/eduardomrocha/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/eduardomrocha/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
	local install_cpath_pattern = "/Users/eduardomrocha/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
	if not string.find(package.path, package_path_str, 1, true) then
		package.path = package.path .. ";" .. package_path_str
	end

	if not string.find(package.cpath, install_cpath_pattern, 1, true) then
		package.cpath = package.cpath .. ";" .. install_cpath_pattern
	end

	time([[Luarocks path setup]], false)
	time([[try_loadstring definition]], true)
	local function try_loadstring(s, component, name)
		local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
		if not success then
			vim.schedule(function()
				vim.api.nvim_notify(
					"packer.nvim: Error running " .. component .. " for " .. name .. ": " .. result,
					vim.log.levels.ERROR,
					{}
				)
			end)
		end
		return result
	end

	time([[try_loadstring definition]], false)
	time([[Defining packer_plugins]], true)
	_G.packer_plugins = {
		LuaSnip = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/LuaSnip",
			url = "https://github.com/L3MON4D3/LuaSnip",
		},
		["Navigator.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/Navigator.nvim",
			url = "https://github.com/numToStr/Navigator.nvim",
		},
		["auto-session"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/auto-session",
			url = "https://github.com/rmagatti/auto-session",
		},
		["bufdelete.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/bufdelete.nvim",
			url = "https://github.com/famiu/bufdelete.nvim",
		},
		["bufferline.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
			url = "https://github.com/akinsho/bufferline.nvim",
		},
		["cmp-buffer"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/cmp-buffer",
			url = "https://github.com/hrsh7th/cmp-buffer",
		},
		["cmp-calc"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/cmp-calc",
			url = "https://github.com/hrsh7th/cmp-calc",
		},
		["cmp-cmdline"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
			url = "https://github.com/hrsh7th/cmp-cmdline",
		},
		["cmp-git"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/cmp-git",
			url = "https://github.com/petertriho/cmp-git",
		},
		["cmp-look"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/cmp-look",
			url = "https://github.com/octaltree/cmp-look",
		},
		["cmp-nvim-lsp"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
			url = "https://github.com/hrsh7th/cmp-nvim-lsp",
		},
		["cmp-nvim-lua"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
			url = "https://github.com/hrsh7th/cmp-nvim-lua",
		},
		["cmp-path"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/cmp-path",
			url = "https://github.com/hrsh7th/cmp-path",
		},
		["cmp-treesitter"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/cmp-treesitter",
			url = "https://github.com/ray-x/cmp-treesitter",
		},
		cmp_luasnip = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
			url = "https://github.com/saadparwaiz1/cmp_luasnip",
		},
		["copilot.vim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/copilot.vim",
			url = "https://github.com/github/copilot.vim",
		},
		["dashboard-nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/dashboard-nvim",
			url = "https://github.com/glepnir/dashboard-nvim",
		},
		["filetype.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/filetype.nvim",
			url = "https://github.com/nathom/filetype.nvim",
		},
		["friendly-snippets"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/friendly-snippets",
			url = "https://github.com/rafamadriz/friendly-snippets",
		},
		["gitsigns.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
			url = "https://github.com/lewis6991/gitsigns.nvim",
		},
		["hop.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/hop.nvim",
			url = "https://github.com/phaazon/hop.nvim",
		},
		["impatient.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/impatient.nvim",
			url = "https://github.com/lewis6991/impatient.nvim",
		},
		["indent-blankline.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
			url = "https://github.com/lukas-reineke/indent-blankline.nvim",
		},
		["lsp-colors.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim",
			url = "https://github.com/folke/lsp-colors.nvim",
		},
		["lsp_signature.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
			url = "https://github.com/ray-x/lsp_signature.nvim",
		},
		["lspkind-nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
			url = "https://github.com/onsails/lspkind-nvim",
		},
		["lspsaga.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
			url = "https://github.com/glepnir/lspsaga.nvim",
		},
		["lualine.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/lualine.nvim",
			url = "https://github.com/nvim-lualine/lualine.nvim",
		},
		["null-ls.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
			url = "https://github.com/jose-elias-alvarez/null-ls.nvim",
		},
		["nvim-autopairs"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
			url = "https://github.com/windwp/nvim-autopairs",
		},
		["nvim-cmp"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/nvim-cmp",
			url = "https://github.com/hrsh7th/nvim-cmp",
		},
		["nvim-comment"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/nvim-comment",
			url = "https://github.com/terrortylor/nvim-comment",
		},
		["nvim-lsp-installer"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
			url = "https://github.com/williamboman/nvim-lsp-installer",
		},
		["nvim-lspconfig"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
			url = "https://github.com/neovim/nvim-lspconfig",
		},
		["nvim-tree.lua"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
			url = "https://github.com/kyazdani42/nvim-tree.lua",
		},
		["nvim-treesitter"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
			url = "https://github.com/nvim-treesitter/nvim-treesitter",
		},
		["nvim-ts-autotag"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
			url = "https://github.com/windwp/nvim-ts-autotag",
		},
		["nvim-ts-rainbow"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
			url = "https://github.com/p00f/nvim-ts-rainbow",
		},
		["nvim-web-devicons"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
			url = "https://github.com/kyazdani42/nvim-web-devicons",
		},
		["onedarkpro.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/onedarkpro.nvim",
			url = "https://github.com/olimorris/onedarkpro.nvim",
		},
		["packer.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/packer.nvim",
			url = "https://github.com/wbthomason/packer.nvim",
		},
		["plenary.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/plenary.nvim",
			url = "https://github.com/nvim-lua/plenary.nvim",
		},
		["session-lens"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/session-lens",
			url = "https://github.com/rmagatti/session-lens",
		},
		["surround.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/surround.nvim",
			url = "https://github.com/ur4ltz/surround.nvim",
		},
		["symbols-outline.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/symbols-outline.nvim",
			url = "https://github.com/simrat39/symbols-outline.nvim",
		},
		["telescope.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/telescope.nvim",
			url = "https://github.com/nvim-telescope/telescope.nvim",
		},
		["trouble.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/trouble.nvim",
			url = "https://github.com/folke/trouble.nvim",
		},
		["twilight.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/twilight.nvim",
			url = "https://github.com/folke/twilight.nvim",
		},
		["vim-hexokinase"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/vim-hexokinase",
			url = "https://github.com/rrethy/vim-hexokinase",
		},
		["vim-pydocstring"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/vim-pydocstring",
			url = "https://github.com/heavenshell/vim-pydocstring",
		},
		["which-key.nvim"] = {
			loaded = true,
			path = "/Users/eduardomrocha/.local/share/nvim/site/pack/packer/start/which-key.nvim",
			url = "https://github.com/folke/which-key.nvim",
		},
	}

	time([[Defining packer_plugins]], false)
	if should_profile then
		save_profiles()
	end
end)

if not no_errors then
	error_msg = error_msg:gsub('"', '\\"')
	vim.api.nvim_command(
		'echohl ErrorMsg | echom "Error in packer_compiled: '
			.. error_msg
			.. '" | echom "Please check your config for correctness" | echohl None'
	)
end
