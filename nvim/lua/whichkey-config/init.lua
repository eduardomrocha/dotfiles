local wk = require("which-key")
local mappings = {
	a = { ":NvimTreeToggle<CR>", "Open File Tree" },
	ca = { ":Lspsaga code_action<CR>", "Code Action" },
	d = { ":Bdelete<CR>", "Close File" },
	D = { ":Bdelete!<CR>", "Close File!" },
	f = { ":Telescope find_files find_command=rg,--hidden,--files<CR>", "Find File" },
	F = { ":Telescope buffers<CR>", "Find Buffer" },
	gp = { ":Telescope live_grep<CR>", "Live Grep" },
	hw = { ":HopWord<CR>", "Hop to Word" },
	hl = { ":HopLine<CR>", "Hop to Line" },
	hc = { ":HopChar2<CR>", "Hop to 2Char" },
	K = { ":Lspsaga hover_doc<CR>", "Hover Doc" },
	ls = { ":RestoreSession<CR>", "Load Session" },
	q = { ":q<CR>", "Quit" },
	rt = { ":NvimTreeRefresh<CR>", "Refresh File Tree" },
	rf = { ":lua vim.lsp.buf.formatting_sync()<CR>", "Run Formatter" },
	sd = { ":Lspsaga show_line_diagnostics<CR>", "Show Line Diagnostics" },
	ss = { ":SaveSession<CR>", "Save Session" },
	sf = { ":Telescope session-lens search_session<CR>", "Find Session" },
	sc = { ":Copilot disable<CR>", "Stop Copilot" },
	sl = { ":LspStop<CR>", "Stop LSP" },
	tw = { ":Twilight<CR>", "Twilight" },
	tt = { ":TroubleToggle<CR>", "Trouble" },
	ts = { ":SymbolsOutline<CR>", "Symbols Outline" },
	w = { ":w!<CR>", "Save File" },
	_ = { ":PydocstringFormat<CR>", "Pydocstring Format" },
	["1"] = { "<Cmd>BufferLineGoToBuffer 1<CR>", "Jumps to buffer 1" },
	["2"] = { "<Cmd>BufferLineGoToBuffer 2<CR>", "Jumps to buffer 2" },
	["3"] = { "<Cmd>BufferLineGoToBuffer 3<CR>", "Jumps to buffer 3" },
	["4"] = { "<Cmd>BufferLineGoToBuffer 4<CR>", "Jumps to buffer 4" },
	["5"] = { "<Cmd>BufferLineGoToBuffer 5<CR>", "Jumps to buffer 5" },
	["6"] = { "<Cmd>BufferLineGoToBuffer 6<CR>", "Jumps to buffer 6" },
	["7"] = { "<Cmd>BufferLineGoToBuffer 7<CR>", "Jumps to buffer 7" },
	["8"] = { "<Cmd>BufferLineGoToBuffer 8<CR>", "Jumps to buffer 8" },
	["9"] = { "<Cmd>BufferLineGoToBuffer 9<CR>", "Jumps to buffer 9" },
}
local opts = {
	prefix = "<leader>",
	silent = true,
	noremap = true,
}

wk.register(mappings, opts)
wk.register({
	ca = { ":<C-U>Lspsaga range_code_action<CR>", "Range Code Action" },
}, {
	mode = "v",
	prefix = "<leader>",
	silent = true,
	noremap = true,
})
