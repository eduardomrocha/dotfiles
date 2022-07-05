vim.cmd("filetype plugin indent on")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[autocmd BufWritePre * :%s/\s\+$//e]])
vim.cmd([[set shortmess+=c]])
vim.cmd([[set formatoptions-=cro]])
vim.opt.hidden = true
vim.opt.whichwrap = "b,s,<,>,[,],h,l"
vim.opt.pumheight = 10
vim.o.fileencoding = "uft-8"
vim.opt.encoding = "utf-8"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.conceallevel = 0
vim.opt.showtabline = 2
vim.opt.showmode = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.timeoutlen = 100
vim.opt.clipboard = "unnamedplus"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5
vim.opt.mouse = "a"
vim.opt.wrap = false
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.fileformat = "unix"
vim.opt.relativenumber = true
vim.opt.showmatch = true
vim.opt.wildmenu = true
vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 99
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.list = true
vim.opt.listchars:append("eol:↴")
vim.opt.fillchars:append("vert:│")

vim.cmd([[
  au BufNewFile,BufRead *.py
      \ set tabstop=4 |
      \ set softtabstop=4 |
      \ set shiftwidth=4 |
      \ set textwidth=88 |
]])

vim.g.Hexokinase_ftEnabled = { "scss", "css", "html", "javascript", "javascriptreact", "typescript", "typescriptreact" }
