-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.bars-and-lines.statuscol-nvim" },
  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
  { import = "astrocommunity.code-runner.sniprun" },
  { import = "astrocommunity.color.twilight-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python.ruff" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.quickfix.nvim-bqf" },
  { import = "astrocommunity.recipes.heirline-vscode-winbar" },
  { import = "astrocommunity.test.neotest" },
  { import = "astrocommunity.utility.neodim" },
  {
    "nanotee/sqls.nvim",
    enabled = false,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_filter(function(v)
        return v ~= "sqls"
      end, opts.ensure_installed or {})
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_filter(function(v)
        return v ~= "sqls"
      end, opts.ensure_installed or {})
    end,
  },
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      opts.config = opts.config or {}
      opts.config.sqls = {}
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        sql = { "sqlfluff" },
      },
      formatters = {
        sqlfluff = {
          require_cwd = false,
          args = { "--dialect", "postgres" },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      local ok, lint = pcall(require, "lint")
      if ok and lint.linters.sqlfluff then
        lint.linters.sqlfluff.args = { "--dialect", "postgres", "lint", "--format", "json", "-" }
      end
      return opts
    end,
  },
  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      colorcolumn = "120",
    },
  },
  {
    "folke/trouble.nvim",
    opts = {
      use_diagnostic_signs = true,
    },
  },
  {
    "zbirenbaum/neodim",
    event = "LspAttach",
    config = function()
      require("neodim").setup {
        alpha = 0.75,
        blend_color = "#000000",
        update_in_insert = {
          enable = true,
          delay = 100,
        },
        hide = {
          virtual_text = true,
          signs = true,
          underline = true,
        },
      }
    end,
  },
}
