return {
  "saghen/blink.cmp",

  version = "1.*",

  dependencies = {
    {
      "saghen/blink.compat",
      version = "2.*",
      lazy = true,
      opts = {},
    },

    { "hrsh7th/nvim-cmp", lazy = true }, -- required at runtime by cmp-look/cmp-git/cmp-treesitter via blink.compat

    "hrsh7th/cmp-calc",
    "octaltree/cmp-look",
    "petertriho/cmp-git",
    "ray-x/cmp-treesitter",
    "hrsh7th/cmp-nvim-lua",

    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",

    {
      "Exafunction/codeium.nvim",
      version = "v0.*",
      event = "InsertEnter",
      build = ":Codeium Auth",
      opts = {
        enable_cmp_source = true,
        virtual_text = {
          enabled = false,
        },
      },
    },
  },

  opts = function(_, opts)
    local function add_source(source)
      opts.sources.default = opts.sources.default or {}

      if not vim.tbl_contains(opts.sources.default, source) then table.insert(opts.sources.default, source) end
    end

    opts.sources = opts.sources or {}
    opts.sources.cmdline = nil
    opts.sources.providers = opts.sources.providers or {}

    add_source "lsp"
    add_source "path"
    add_source "snippets"
    add_source "buffer"

    add_source "codeium"

    add_source "treesitter"
    add_source "calc"
    add_source "look"

    opts.sources.providers = vim.tbl_deep_extend("force", opts.sources.providers, {

      codeium = {
        name = "Codeium",

        module = "codeium.blink",

        async = true,

        score_offset = 1000,
      },

      lsp = {
        name = "LSP",

        transform_items = function(ctx, items)
          local line = ctx.line
          local col = ctx.cursor[2]

          local char_before_cursor = ""
          if col > 0 then char_before_cursor = line:sub(col, col) end

          if char_before_cursor == "." then
            return vim.tbl_filter(function(item) return item.kind == 2 or item.kind == 5 end, items)
          end

          if line:match "^%s*%w*$" then
            return vim.tbl_filter(function(item) return item.kind == 3 or item.kind == 6 end, items)
          end

          return items
        end,

        score_offset = 950,
      },

      snippets = {
        name = "Snippet",

        module = "blink.cmp.sources.snippets",

        score_offset = 800,
      },

      buffer = {
        name = "Buffer",

        score_offset = 700,
        min_keyword_length = 5,
      },

      path = {
        name = "Path",

        score_offset = 600,
      },

      treesitter = {
        name = "Treesitter",
        module = "blink.compat.source",

        score_offset = 500,
      },

      calc = {
        name = "Calc",
        module = "blink.compat.source",

        score_offset = 400,
      },

      look = {
        name = "Dict",
        module = "blink.compat.source",

        score_offset = 300,

        opts = {
          convert_case = true,
          loud = true,
        },

        min_keyword_length = 3,
      },

      nvim_lua = {
        name = "Lua",
        module = "blink.compat.source",

        score_offset = 200,
      },

      git = {
        name = "Git",
        module = "blink.compat.source",
      },
    })

    opts.sources.per_filetype = opts.sources.per_filetype or {}

    opts.sources.per_filetype.lua = vim.tbl_deep_extend("force", opts.sources.per_filetype.lua or {}, {
      inherit_defaults = true,
      "nvim_lua",
    })

    opts.sources.per_filetype.gitcommit = {
      inherit_defaults = true,
      "git",
      "buffer",
    }

    opts.cmdline = opts.cmdline or {}
    opts.cmdline.enabled = true

    opts.cmdline.sources = function()
      local cmdtype = vim.fn.getcmdtype()

      if cmdtype == "/" or cmdtype == "?" then return { "buffer" } end

      if cmdtype == ":" then return { "path", "cmdline" } end

      return {}
    end

    opts.snippets = {
      preset = "luasnip",
    }

    opts.signature = {
      enabled = true,
    }

    opts.completion = opts.completion or {}
    opts.completion.menu = opts.completion.menu or {}
    opts.completion.menu.draw = opts.completion.menu.draw or {}

    opts.completion.menu.draw.columns = {
      { "kind_icon" },
      { "label", "label_description", gap = 1 },
      { "kind", "source_name", gap = 1 },
    }

    opts.completion.menu.draw.components = vim.tbl_deep_extend("force", opts.completion.menu.draw.components or {}, {
      source_name = {
        width = { max = 20 },
        text = function(ctx) return "[" .. ctx.source_name .. "]" end,
        highlight = "BlinkCmpSource",
      },
    })

    opts.completion.ghost_text = {
      enabled = true,
      show_with_selection = true,
      show_without_selection = true,
      show_with_menu = true,
      show_without_menu = true,
    }

    opts.completion.documentation = vim.tbl_deep_extend("force", opts.completion.documentation or {}, {
      auto_show = true,
      auto_show_delay_ms = 300,
    })

    opts.appearance = vim.tbl_deep_extend("force", opts.appearance or {}, {
      nerd_font_variant = "normal",

      kind_icons = {
        NONE = "",
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "",
        Class = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "󰎠",
        Enum = "",
        EnumMember = "",
        Keyword = "󰌋",
        Constant = "󰏿",
        Struct = "פּ",
        Event = "",
        Operator = "󰆕",
        Reference = "",
        TypeParameter = "󰊄",
        Snippet = "",
        String = "𝓐",
        Number = "#",
        Boolean = "⊨",
        Array = "󰅪",
        Object = "⦿",
        Key = "󰌆",
        Null = "NULL",
        Package = "󰏗",
        Color = "󰏘",
        File = "󰈙",
        Folder = "󰉋",

        Codeium = "",
      },
    })

    return opts
  end,
}
