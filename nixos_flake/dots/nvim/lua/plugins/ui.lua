-- -- temporarily disable
-- if true then return {} end

-- TODO: make edgy less jumpy
--  - remove neo-tree buffers
--  - remove neoo-tree git status
local M = {
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
