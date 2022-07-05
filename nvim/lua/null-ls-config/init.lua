local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local on_attach = function(client)
	if client.resolved_capabilities.document_formatting then
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end
end

local sources = {
	-- formmating
	formatting.stylelint, -- css, scss, less, sass
	formatting.mix, -- elixir
	formatting.golines, -- golang
	formatting.tidy, -- html
	formatting.eslint_d, -- javascript, typescript
	formatting.fixjson, -- json
	formatting.stylua, -- lua
	formatting.markdownlint, -- markdown
	formatting.black.with({ extra_args = { "--fast" } }), -- python
	formatting.isort.with({ extra_args = { "--line-width", "88" } }), -- python
	formatting.prettierd.with({
		filetypes = {
			"yaml",
			"graphql",
		},
	}),
	-- diagnostics
	diagnostics.stylelint, -- css, scss, less, sass
	diagnostics.hadolint, -- dockerfile
	diagnostics.credo, -- elixir
	diagnostics.revive, -- golang
	diagnostics.tidy, -- html
	diagnostics.eslint_d, -- javascript, typescript
	diagnostics.jsonlint, -- json
	diagnostics.luacheck, -- lua
	diagnostics.markdownlint, -- markdown
	diagnostics.flake8.with({ extra_args = { "--max-complexity", "10", "--max-line-length", "88", "--ignore=E203" } }), -- python
	diagnostics.pydocstyle, -- python
	diagnostics.mypy, -- python
	diagnostics.vulture, -- python
	diagnostics.yamllint, -- yaml
}

null_ls.setup({ sources = sources, on_attach = on_attach })
