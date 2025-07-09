-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      null_ls.builtins.formatting.isort.with { extra_args = { "--line-width", "120" } },
      null_ls.builtins.diagnostics.mypy,
      require("none-ls.diagnostics.ruff").with {
        extra_args = {
          "--line-length",
          "120",
          "--select",
          "C90,I,E,W,PL", -- mccabe, isort, pycodestyle, pylint
        },
      },
    }
    return config -- return final config table
  end,
}
