-- TODO: migrate markview here; config is too complex to have it in obisidian markdown config
-- local preset = require("markview.presets")
--
-- require("markview").setup({
--   markdown = { headings = preset.glow },
-- })

local M = {
  -- SECTION: markview.nvim
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Recommended; everything in this mod is already lazy-loaded
    ft = { "markdown", "norg", "rmd", "org" }, -- If you decide to lazy-load anyway
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      preview = {
        -- hybrid mode: normal only
        modes = { "n", "no", "c" }, -- Change these modes
        hybrid_modes = { "n" }, -- Uses this feature on
        callbacks = {
          on_enable = function(_, win)
            vim.wo[win].conceallevel = 2
            vim.wo[win].concealcursor = "c"
          end,
        },
      },

      markdown_inline = {
        enable = true,
        inline_codes = {
          enable = true,
          -- style = "simple",
          -- hl = "CodeBlock",
        },
        checkboxes = {
          enable = true,

          -- Options: https://www.nerdfonts.com/cheat-sheet
          -- Ideas:
          --  󰄾 task
          --  󰅂 task
          --   task
          --  > task
          --   task
          --  󰧚 task
          --  󰇘 task
          --  󰛂 task
          --   task
          --   task
          --   task
          -- checked = { text = " 󰗠", hl = "MarkviewCheckboxChecked", scope_hl = "MarkviewCheckboxChecked" },
          checked = { text = " ", hl = "MarkviewCheckboxChecked", scope_hl = "MarkviewCheckboxChecked" },
          -- unchecked = { text = " 󰄰", hl = "MarkviewCheckboxUnchecked", scope_hl = "MarkviewCheckboxUnchecked" },
          unchecked = { text = " ", hl = "MarkviewCheckboxUnchecked", scope_hl = "MarkviewCheckboxUnchecked" },
          -- ["/"] = { text = " 󰪡", hl = "MarkviewCheckboxPending", scope_hl = "MarkviewCheckboxPending" },
          -- ["/"] = { text = " 󱓻", hl = "MarkviewCheckboxPending", scope_hl = "MarkviewCheckboxPending" },
          ["/"] = { text = " ", hl = "MarkviewCheckboxPending", scope_hl = "MarkviewCheckboxPending" },
          -- ["-"] = { text = " ", hl = "MarkviewCheckboxCancelled", scope_hl = "MarkviewCheckboxStriked" },
          ["-"] = { text = " ", hl = "MarkviewCheckboxCancelled", scope_hl = "MarkviewCheckboxStriked" },
        },
      },

      markdown = {
        enable = true,
        list_items = {
          enable = true,
          -- TODO: play around with wrap
          -- wrap = false,

          -- marker_minus = { add_padding = false, text = "●", hl = "@markup.list.markdown", },
          marker_minus = {
            add_padding = false,
            text = "●",
            -- NOTE: default hl looks fine now
            -- hl = "@markup.list.markdown",
            -- BUG: conceal_on_checkboxes = false is what I want, but currently it clears all
            -- > formatting for corresponding list items
            -- conceal_on_checkboxes = false,
          },
          marker_plus = {
            add_padding = false,
            text = "○",
            -- hl = "@markup.list.markdown",
            -- conceal_on_checkboxes = false,
          },
          marker_star = {
            add_padding = false,
            text = "◆",
            -- hl = "@markup.list.markdown",
            -- conceal_on_checkboxes = false,
          },
          --  numbered list, so no text replacement
          marker_dot = {
            add_padding = false,
            -- hl = "@markup.list.markdown",
            -- conceal_on_checkboxes = false,
          },
          marker_parenthesis = {
            add_padding = false,
            -- hl = "@markup.list.markdown",
            -- conceal_on_checkboxes = false,
          },
        },
        code_blocks = {
          -- style = "language", -- wrapping issues
          -- min_width = 0,
          -- pad_amount = 0,
          -- style = "minimal", -- wrapping issues
          style = "simple",
          hl = "CodeBlock", -- "dark"
          -- hl = "CursorLine", -- "bright"
        },
      },
    },
    config = function(_, opts)
      require("markview").setup(opts)

      local presets = require("markview.presets")

      -- call setup() to set initial presets
      require("markview").setup({
        markdown = { headings = presets.headings.marker },
      })
      -- call setup() again to _modify_ presets
      require("markview").setup({
        markdown = {
          headings = {
            enable = true,
            shift_width = 1,
            shift_char = " ",
            heading_1 = { icon = "󰼏 " },
            heading_2 = { icon = "󰎨 " },
            heading_3 = { icon = "󰼑 " },
            heading_4 = { icon = "󰎲 " },
            heading_5 = { icon = "󰼓 " },
            heading_6 = { icon = "󰎴 " },
          },
        },
      })
      -- enable HeadingIncrease and HeadingDecrease cmds
      require("markview.extras.headings").setup()
    end,
    keys = {
      {
        mode = "n",
        "<leader>um",
        ":Markview toggle<CR>",
        desc = "Render Markdown",
        ft = { "markdown", "norg", "rmd", "org" },
      },
      {
        mode = "n",
        ">h",
        ":HeadingIncrease<CR>",
        desc = "Increase Heading",
        ft = { "markdown", "norg", "rmd", "org" },
      },
      {
        mode = "n",
        "<h",
        ":HeadingDecrease<CR>",
        desc = "Decrease Heading",
        ft = { "markdown", "norg", "rmd", "org" },
      },
    },
  },
}

return M
