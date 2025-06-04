-- -- temporarily disable
-- if true then return {} end

-- TODO: make edgy less jumpy
--  - remove neo-tree buffers
--  - remove neoo-tree git status
local M = {
  -- treesitter-based navigation
  -- BUG: breaks nvim-cmp (and blink.nvim) prev/next... https://github.com/aaronik/treewalker.nvim/issues/3
  --
  {
    "aaronik/treewalker.nvim",
    opts = {
      highlight = false,
    },
    keys = {
      { "<C-S-K>", "<cmd>Treewalker Up<cr>", { silent = true } },
      { "<C-S-J>", "<cmd>Treewalker Down<cr>", { silent = true } },

      -- { "<Esc>[1;6K", "<cmd>Treewalker Up<cr>", { silent = true } },
      -- { "'<Esc>[1;6J'", "<cmd>Treewalker Down<cr>", { silent = true } },
      -- { "<Esc>[1;6H", "<cmd>Treewalker Left<cr>", { silent = true } },
      -- { "<Esc>[1;6L", "<cmd>Treewalker Right<cr>", { silent = true } },

      { "<S-Up>", "<cmd>Treewalker Up<cr>", { silent = true } },
      { "<S-Down>", "<cmd>Treewalker Down<cr>", { silent = true } },
      { "<S-Left>", "<cmd>Treewalker Left<cr>", { silent = true } },
      { "<S-Right>", "<cmd>Treewalker Right<cr>", { silent = true } },

      -- BUG: these don't work; perhaps due to key being intercepted at wezterm or zellij level
      { "<S-Up>", "<cmd>Treewalker SwapUp<cr>", mode = "v", { silent = true } },
      { "<S-Down>", "<cmd>Treewalker SwapDown<cr>", mode = "v", { silent = true } },
      { "<S-Left>", "<cmd>Treewalker SwapLeft<cr>", mode = "v", { silent = true } },
      { "<S-Right>", "<cmd>Treewalker SwapRight<cr>", mode = "v", { silent = true } },
      -- { "<C-S-Up>", "<cmd>Treewalker SwapUp<cr>", { noremap = true, silent = true } },
      -- { "<C-S-Down>", "<cmd>Treewalker SwapDown<cr>", { noremap = true, silent = true } },
      -- { "<C-S-Left>", "<cmd>Treewalker SwapLeft<cr>", { noremap = true, silent = true } },
      -- { "<C-S-Right>", "<cmd>Treewalker SwapRight<cr>", { noremap = true, silent = true } },
      { "<leader>cwj", "<cmd>Treewalker SwapDown<cr>", { silent = true } },
      { "<leader>cwk", "<cmd>Treewalker SwapUp<cr>", { silent = true } },
      { "<leader>cwh", "<cmd>Treewalker SwapLeft<cr>", { silent = true } },
      { "<leader>cwl", "<cmd>Treewalker SwapRight<cr>", { silent = true } },
    },
  },
  -- -- seems nice, but requires a bit of setup to be useful
  -- {
  --   "OXY2DEV/foldtext.nvim",
  --   lazy = false,
  --   -- enabled = false,
  -- },
  -- Smooth cursor movement.
  -- {
  --   "sphamba/smear-cursor.nvim",
  --   opts = {},
  -- },
  -- Smooth scrolling.
  -- {
  --   "karb94/neoscroll.nvim",
  --   config = function()
  --     require("neoscroll").setup({})
  --   end,
  -- },
  --
  -- TODO: deep dive into oil.nvim; for now it's just annoying on startup
  -- {
  --   'stevearc/oil.nvim',
  --   opts = {},
  --   -- Optional dependencies
  --   -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
  --   dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  -- },

  -- {
  --   "tris203/precognition.nvim",
  --   --event = "VeryLazy",
  --   opts = {
  --     -- startVisible = true,
  --     -- showBlankVirtLine = true,
  --     -- highlightColor = { link = "Comment" },
  --     -- hints = {
  --     --      Caret = { text = "^", prio = 2 },
  --     --      Dollar = { text = "$", prio = 1 },
  --     --      MatchingPair = { text = "%", prio = 5 },
  --     --      Zero = { text = "0", prio = 1 },
  --     --      w = { text = "w", prio = 10 },
  --     --      b = { text = "b", prio = 9 },
  --     --      e = { text = "e", prio = 8 },
  --     --      W = { text = "W", prio = 7 },
  --     --      B = { text = "B", prio = 6 },
  --     --      E = { text = "E", prio = 5 },
  --     -- },
  --     -- gutterHints = {
  --     --     G = { text = "G", prio = 10 },
  --     --     gg = { text = "gg", prio = 9 },
  --     --     PrevParagraph = { text = "{", prio = 8 },
  --     --     NextParagraph = { text = "}", prio = 8 },
  --     -- },
  --     -- disabled_fts = {
  --     --     "startify",
  --     -- },
  --   },
  -- },
}
return M
