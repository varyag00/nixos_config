-- NOTE: only {cmd, event, ft, keys, opts, dependencies} will be merged. Everything else will OVERRIDE the defaults
-- see docs: https://www.lazyvim.org/configuration/plugins#%EF%B8%8F-customizing-plugin-specs
M = {
  -- SECTION: folke/snacks
  {
    "folke/snacks.nvim",
    opts = {
      indent = {
        enabled = true,
        only_scope = true,
        only_current = true,
      },
      -- BUG: breaks G and gg
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 15, total = 250 },
          easing = "linear",
        },
        -- what buffers to animate
        filter = function(buf)
          return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false
        end,
      },
      picker = {
        win = {
          input = {
            keys = {
              -- default C-up and C-down conflict with macos defaults
              ["<C-p>"] = { "history_back", mode = { "i", "n" } },
              ["<C-n>"] = { "history_forward", mode = { "i", "n" } },
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader>fz",
        function()
          Snacks.picker.zoxide()
        end,
        desc = "Zoxide Files",
      },
    },
  },

  -- -- TODO: remove if using snacks picker
  -- -- Add history to fzf-lua prompts; cycle through history with C-n & C-p
  -- {
  --   "ibhagwan/fzf-lua",
  --   opts = {
  --     -- NOTE: cycle history with C-n|p
  --     -- fzf_opts = {
  --     --   ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
  --     -- },
  --     files = {
  --       fzf_opts = {
  --         ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-files-history",
  --       },
  --     },
  --     grep = {
  --       fzf_opts = {
  --         ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-grep-history",
  --       },
  --     },
  --   },
  -- },
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",

    -- -- use a release tag to download pre-built binaries
    -- version = "v0.*",
    -- -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- -- build = 'cargo build --release',
    -- -- If you use nix, you can build from source using latest nightly rust with:
    -- -- build = 'nix run .#build-plugin',
    --
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- see the "default configuration" section below for full documentation on how to define
      -- your own keymap.
      keymap = {
        preset = "enter",
        ["<C-j>"] = { "select_next", "fallback" },
        -- BUG: for now, must remove nvim-lspconfig C-k (signature help); use gK instead
        -- > see https://github.com/LazyVim/LazyVim/discussions/5131
        ["<C-k>"] = { "select_prev", "fallback" },
      },

      -- appearance = {
      --   -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      --   -- Useful for when your theme doesn't support blink.cmp
      --   -- will be removed in a future release
      --   use_nvim_cmp_as_default = true,
      --   -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      --   -- Adjusts spacing to ensure icons are aligned
      --   nerd_font_variant = "mono",
      -- },
      --
      -- -- default list of enabled providers defined so that you can extend it
      -- -- elsewhere in your config, without redefining it, via `opts_extend`
      -- sources = {
      --   default = { "lsp", "path", "snippets", "buffer" },
      --   -- optionally disable cmdline completions
      --   -- cmdline = {},
      -- },

      -- experimental signature help support
      -- signature = { enabled = true }
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" },
  },

  -- BUG: See blink.cmp BUG above
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<C-k>", false, mode = { "i" } }
    end,
  },
  -- END_SECTION:
  -- SECTION: folke/which-key
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
      highlight = {
        -- default is multiline_pattern = "^.",
        -- NOTE: match all comment lines starting with " >" followed by text
        multiline_pattern = "^>.",
        -- TODO: test
        -- more test
        -- TODO: test
        -- > fsdfds
        -- TODO: test
        --> fsdfds
        -- TODO: test
        -- | fsdfds
      },
    },
  },
  -- END_SECTION:
  -- SECTION: edgy.nvim
  -- TODO: try disabling this to see if it's really needed
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
