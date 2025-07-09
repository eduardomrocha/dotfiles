return {
  "lewis6991/gitsigns.nvim",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 0,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      },
      current_line_blame_formatter = "<author>, <author_time:%d-%m-%Y> - <summary>",
    })
  end,
}
