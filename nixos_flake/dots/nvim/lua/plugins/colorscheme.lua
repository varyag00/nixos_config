local M = {
  -- {
  --   "catppuccin/nvim",
  --   lazy = true,
  --   name = "catppuccin",
  --   opts = {
  --     flavour = "macchiato",
  --     term_colors = false,
  --     dim_inactive = {
  --       enabled = true,
  --     },
  --     -- see :h highlight-groups and :h highlight-args
  --     -- styles = {
  --     --   -- comments = { "italic" },
  --     --   -- conditionals = {},
  --     --   booleans = { "bold" },
  --     --   numbers = { "bold" },
  --     --   -- variables = {},
  --     --   keywords = { "bold" },
  --     --   operators = { "bold" },
  --     --   -- strings = {},
  --     -- },
  --     integrations = {
  --       aerial = true,
  --       alpha = true,
  --       cmp = true,
  --       dashboard = true,
  --       headlines = true,
  --       flash = true,
  --       grug_far = true,
  --       gitsigns = true,
  --       illuminate = true,
  --       indent_blankline = { enabled = true },
  --       lsp_trouble = true,
  --       markdown = true,
  --       mason = true,
  --       mini = true,
  --       native_lsp = {
  --         enabled = true,
  --         underlines = {
  --           errors = { "undercurl" },
  --           hints = { "undercurl" },
  --           warnings = { "undercurl" },
  --           information = { "undercurl" },
  --         },
  --       },
  --       navic = { enabled = true, custom_bg = "lualine" },
  --       neotest = true,
  --       neogit = true,
  --       noice = true,
  --       notify = true,
  --       neotree = true,
  --       semantic_tokens = true,
  --       telescope = true,
  --       treesitter = true,
  --       treesitter_context = true,
  --       which_key = true,
  --     },
  --   },
  -- },
  {
    "catppuccin/nvim",
    opts = {
      flavour = "macchiato",
      term_colors = true,
      integrations = {
        neogit = true,
      },
    }
  },
  -- Configure LazyVim to load catppuccin-macchiato: https://github.com/catppuccin/nvim#usage
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      -- colorscheme = "catppuccin-macchiato",
      -- colorscheme = "tokyonight-storm",
    },
  },
}

return M
