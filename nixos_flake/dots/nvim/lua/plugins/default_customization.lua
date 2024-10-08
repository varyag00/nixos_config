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
      preset = "modern",
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
        SECTION = { icon = "󱡠 ", color = "section", alt = { "END_SECTION" } },
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
  -- SECTION: edgy.nvim
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = {
      bottom = {
        -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
        {
          ft = "toggleterm",
          size = { height = 0.4 },
          -- exclude floating windows
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        {
          ft = "lazyterm",
          title = "LazyTerm",
          size = { height = 0.4 },
          filter = function(buf)
            return not vim.b[buf].lazyterm_cmd
          end,
        },
        "Trouble",
        { ft = "qf", title = "QuickFix" },
        {
          ft = "help",
          size = { height = 20 },
          -- only show help buffers
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
        },
        { ft = "spectre_panel", size = { height = 0.4 } },
      },
      left = {
        -- Neo-tree filesystem always takes half the screen height
        {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          size = { height = 0.5 },
        },
        -- NOTE: Hide neotree buffers and git status
        -- {
        --   title = "Neo-Tree Git",
        --   ft = "neo-tree",
        --   filter = function(buf)
        --     return vim.b[buf].neo_tree_source == "git_status"
        --   end,
        --   pinned = true,
        --   collapsed = true, -- show window as closed/collapsed on start
        --   open = "Neotree position=right git_status",
        -- },
        -- {
        --   title = "Neo-Tree Buffers",
        --   ft = "neo-tree",
        --   filter = function(buf)
        --     return vim.b[buf].neo_tree_source == "buffers"
        --   end,
        --   pinned = true,
        --   collapsed = true, -- show window as closed/collapsed on start
        --   open = "Neotree position=top buffers",
        -- },
        {
          title = function()
            local buf_name = vim.api.nvim_buf_get_name(0) or "[No Name]"
            return vim.fn.fnamemodify(buf_name, ":t")
          end,
          ft = "Outline",
          pinned = true,
          open = "SymbolsOutlineOpen",
        },
        -- any other neo-tree windows
        "neo-tree",
      },
    },
  },
}
return M
