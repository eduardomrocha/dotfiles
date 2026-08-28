return {
  "Exafunction/windsurf.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  cond = function()
    for _, arg in ipairs(vim.fn.argv()) do
      if arg:match "COMMIT_EDITMSG" or arg:match "MERGE_MSG" or arg:match "git%-rebase%-todo" then return false end
    end
    return true
  end,
  config = function() require("codeium").setup {} end,
  event = "VeryLazy",
}
