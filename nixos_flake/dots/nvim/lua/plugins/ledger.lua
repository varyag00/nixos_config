-- NOTE: (h)ledger is plaintext accounting software that supports double-entry bookkeeping

-- enable/disable
-- if true then
--   return {}
-- end

local M = {
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = {
  --     ensure_installed = {
  --       "ledger",
  --     },
  --   },
  -- },
  -- NOTE: seems broken
  -- {
  --   -- compatible with hledger
  --   -- notable TUI alternative: https://github.com/siddhantac/puffin
  --   "wllfaria/ledger.nvim",
  --   -- tree sitter needs to be loaded before ledger.nvim loads
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   -- config = function()
  --   --   require("ledger").setup()
  --   -- end,
  --   opts = {
  --     {
  --       extensions = {
  --         "ledger",
  --         "hledger",
  --         "journal",
  --       },
  --       completion = {
  --         cmp = { enabled = true },
  --       },
  --       snippets = {
  --         cmp = { enabled = true },
  --         luasnip = { enabled = false },
  --         native = { enabled = false },
  --       },
  --       keymaps = {
  --         snippets = {
  --           new_posting = { "tt" },
  --           new_account = { "acc" },
  --           new_posting_today = { "td" },
  --           new_commodity = { "cm" },
  --         },
  --         reports = {},
  --       },
  --       diagnostics = {
  --         lsp_diagnostics = true,
  --         strict = false,
  --       },
  --     },
  --   },
  --   event = "BufRead",
  -- },
}
return M