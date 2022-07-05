local function t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Map leader key to space
vim.g.mapleader = " "

-- Map <ESC> to kj
vim.api.nvim_set_keymap("i", "kj", "<ESC>", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "kj", "<ESC>", { noremap = true, silent = false })

-- TAB in normal mode will move to next buffer
vim.api.nvim_set_keymap("n", "<TAB>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })

-- Shift+TAB in normal mode will move to previous buffer
vim.api.nvim_set_keymap("n", "<S-TAB>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })

-- Map : to ;
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true, silent = false })

-- Map J and K for scrolling in normal mode
vim.api.nvim_set_keymap("n", "J", "<C-e>", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "K", "<C-y>", { noremap = true, silent = false })

-- ESC will clear search highlights
vim.api.nvim_set_keymap("n", "<ESC>", ":nohlsearch<CR>", { noremap = true, silent = true })

-- Use CTRL+[hjkl] to navigate through splits
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = false })

-- Use ALT+hjkl to resize splits
vim.api.nvim_set_keymap("n", "<M-h>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-j>", ":resize +2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-k>", ":resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-l>", ":vertical resize +2<CR>", { noremap = true, silent = true })
-- MacOs version
vim.api.nvim_set_keymap("n", "˙", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "∆", ":resize +2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "˚", ":resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "¬", ":vertical resize +2<CR>", { noremap = true, silent = true })

-- vv to create vertical split
vim.api.nvim_set_keymap("n", "vv", "<C-w>v", { noremap = true, silent = false })

-- Better tabbing
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = false })
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = false })

-- Better nav for omnicomplete
vim.api.nvim_set_keymap("i", "<expr><C-j>", t("<C-n>"), { noremap = true, silent = false })
vim.api.nvim_set_keymap("i", "<expr><C-k>", t("<C-p>"), { noremap = true, silent = false })

-- Navigate between vim and tmux
vim.api.nvim_set_keymap("n", "<C-h>", "<CMD>lua require('Navigator').left()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<CMD>lua require('Navigator').up()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<CMD>lua require('Navigator').right()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<CMD>lua require('Navigator').down()<CR>", { noremap = true, silent = true })

-- Open and close lspsaga floating terminal
vim.api.nvim_set_keymap("n", "<M-t>", "<cmd>Lspsaga open_floaterm<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<M-t>", "<C-\\><C-n><cmd>Lspsaga close_floaterm<CR>", { noremap = true, silent = true })
-- MacOs config
vim.api.nvim_set_keymap("n", "†", "<cmd>Lspsaga open_floaterm<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "†", "<C-\\><C-n><cmd>Lspsaga close_floaterm<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", t("<C-p>"), "<cmd>Lspsaga diagnostic_jump_prev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", t("<C-n>"), "<cmd>Lspsaga diagnostic_jump_next<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", t("<C-_>"), "<Plug>(pydocstring)", { noremap = false, silent = true })

vim.api.nvim_set_keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<C-f>",
	"<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<C-d>",
	"<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "gs", "<cmd>Lspsaga signature_help<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>Lspsaga preview_definition<CR>", { noremap = true, silent = true })
