-- NOTE: only {cmd, event, ft, keys, opts, dependencies} will be merged. Everything else will OVERRIDE the defaults
-- see docs: https://www.lazyvim.org/configuration/plugins#%EF%B8%8F-customizing-plugin-specs
M = {
  -- SECTION: folke/todo-comments
  {
    "folke/which-key.nvim",
    opts = {
      -- "classic": bottom of screen, out of the way
      -- "modern": border and nice hover
      -- "helix": vertical on the right
      preset = "modern"
    },
  },
  -- END_SECTION:
  -- SECTION: folke/todo-comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- extend default highlighted comments
    opts = {
      keywords = {
        -- icons: https://www.nerdfonts.com/cheat-sheet
        SECTION = { icon = "󱡠 ", color = "section", alt = { "END_SECTION", } },
        IDEA = { icon = " ", color = "info" },
        CRIT = { icon = " ", color = "critical", alt = { "CRITICAL", "IMPORTANT" } },
      },
      colors = {
        -- :h highlight-groups
        -- { highlight_group, fallback color }
        section = { "Comment", "#B5B4B4" },
        -- error or bright purple
        critical = { "ErrorMsg", "#CA33FF" },
      },
    },
  },
  -- END_SECTION:
}
return M
