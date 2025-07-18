return {
  polish = function()
    vim.opt.clipboard = "unnamedplus"

    if vim.fn.has "wsl" == 1 then
      vim.api.nvim_create_autocmd("TextYankPost", {
        group = vim.api.nvim_create_augroup("Yank", { clear = true }),
        callback = function() vim.fn.system("clip.exe", vim.fn.getreg '"') end,
      })
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "AstroBufsUpdated",
      group = vim.api.nvim_create_augroup("auto_sort_tabline", { clear = true }),
      callback = function() require("astronvim.utils.buffer").sort("bufnr", true) end,
    })
  end,
}
