return {
  "hrsh7th/nvim-cmp",
  keys = { ":", "/", "?" },
  dependencies = {
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-cmdline",
    "octaltree/cmp-look",
    "petertriho/cmp-git",
    "ray-x/cmp-treesitter",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },
  config = function(_, opts)
    local cmp = require "cmp"
    local lspkind = require "lspkind"

    opts = require("astrocore").extend_tbl(opts, {
      sources = cmp.config.sources {
        { name = "codeium", priority = 1000 },
        {
          name = "nvim_lsp",
          priority = 950,
          entry_filter = function(entry, context)
            local kind = entry:get_kind()

            local line = context.cursor_line
            local col = context.cursor.col
            local char_before_cursor = string.sub(line, col - 1, col - 1)

            if char_before_cursor == "." then
              if kind == 2 or kind == 5 then
                return true
              else
                return false
              end
            elseif string.match(line, "^%s*%w*$") then
              if kind == 3 or kind == 6 then
                return true
              else
                return false
              end
            end

            return true
          end,
        },
        { name = "nvim_lsp_signature_help", priority = 900 },
        { name = "luasnip", priority = 800 },
        { name = "buffer", priority = 700, keyword_length = 5 },
        { name = "path", priority = 600 },
        { name = "treesitter", priority = 500 },
        { name = "calc", priority = 400 },
        {
          name = "look",
          priority = 300,
          keyword_length = 3,
          option = { convert_case = true, loud = true },
        },
        { name = "nvim_lua", priority = 200 },
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format {
          mode = "symbol",
          maxwidth = 50,
          ellipsis_char = "...",
          symbol_map = {
            NONE = "",
            Comment = "",
            Array = "󰅪",
            Boolean = "⊨",
            Class = "",
            Constructor = "",
            Key = "󰌆",
            Namespace = "",
            Null = "NULL",
            Number = "#",
            Object = "⦿",
            Package = "󰏗",
            Property = "",
            Reference = "",
            Snippet = "",
            String = "𝓐",
            TypeParameter = "󰊄",
            Unit = "",
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Field = "󰜢",
            Variable = "",
            Interface = "",
            Module = "",
            Value = "󰎠",
            Enum = "",
            Color = "󰏘",
            File = "󰈙",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "פּ",
            Event = "",
            Operator = "󰆕",
            Copilot = "",
            Codeium = "",
          },
          menu = {
            nvim_lsp = "[LSP]",
            nvim_lsp_signature_help = "[Signature]",
            luasnip = "[Snippet]",
            path = "[Path]",
            buffer = "[Buffer]",
            look = "[Dict]",
            calc = "[Calc]",
            treesitter = "[Treesitter]",
            nvim_lua = "[Lua]",
            git = "[Git]",
            cmdline = "[Cmdline]",
            copilot = "[Copilot]",
            codeium = "[Codeium]",
          },
        },
      },
      experimental = {
        ghost_text = { hlgroup = "Comment" },
      },
    })
    print(opts)

    cmp.setup(opts)

    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" },
      }, {
        { name = "buffer" },
      }),
    })

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline("?", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}
