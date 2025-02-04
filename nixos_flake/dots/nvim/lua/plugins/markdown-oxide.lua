-- NOTE: markdown-oxide based markdown workflow, as opposed to obsidian.nvim

-- temporarily disable
if true then
  return {}
end

local M = {

  {
    "OXY2DEV/markview.nvim",
    -- lazy = false, -- Recommended
    ft = { "markdown", "norg", "rmd", "org" }, -- If you decide to lazy-load anyway
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      modes = { "n", "i", "no", "c" }, -- Change these modes to what you need
      hybrid_modes = { "n", "i" }, -- Uses this feature on
      callbacks = {
        on_enable = function(_, win)
          vim.wo[win].conceallevel = 2
          vim.wo[win].concealcursor = "nc"
        end,
      },

      checkboxes = { enable = true },
      links = {
        -- inline_links = {
        --   hl = "@markup.link.label.markdown_inline", -- markown?
        --   icon = " ",
        --   icon_hl = "@markup.link",
        -- },
        images = {
          hl = "@markup.link.label.markdown_inline",
          icon = " ",
          icon_hl = "@markup.link",
        },
      },
      code_blocks = {
        style = "language",
        hl = "CodeBlock",
        pad_amount = 0,
      },
      list_items = {
        shift_width = 1,
        marker_minus = { text = "●", hl = "@markup.list.markdown" },
        marker_plus = { text = "●", hl = "@markup.list.markdown" },
        marker_star = { text = "●", hl = "@markup.list.markdown" },
        marker_dot = {},
      },
      inline_codes = { enable = true },
      headings = {
        enable = true,
        -- style = "simple",
        shift_width = 1,
        shift_char = " ", -- maybe # ?

        heading_1 = { style = "simple", hl = "Headline1" },
        heading_2 = { style = "simple", hl = "Headline2" },
        heading_3 = { style = "simple", hl = "Headline3" },
        heading_4 = { style = "simple", hl = "Headline4" },
        heading_5 = { style = "simple", hl = "Headline5" },
        heading_6 = { style = "simple", hl = "Headline6" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint-cli2" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        ["markdown-toc"] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find("<!%-%- toc %-%->") then
                return true
              end
            end
          end,
        },
        ["markdownlint-cli2"] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
      },
      formatters_by_ft = {
        ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
        ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
      },
    },
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = { "hrsh7th/cmp-nvim-lsp" },
  --   opts = {
  --     servers = {
  --       markdown_oxide = {},
  --     },
  --   },
  -- },

  {
    "Feel-ix-343/markdown-oxide",
    -- config = function()
    --   require("markdown-oxide").setup()
    -- end,
    --
    config = function(_, opts)
      -- NOTE: Modify lspconfig
      -- An example nvim-lspconfig capabilities setting
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
      -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
      capabilities.workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      }

      -- util = require("lazyvim.util")
      -- local on_attach = util.on_attach()

      -- TODO: this
      require("lspconfig").markdown_oxide.setup({
        capabilities = capabilities, -- again, ensure that capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
        -- on_attach = on_attach        -- configure your on attach config
      })
    end,
    -- keys = {
    --   { "n", "<leader>mo", ":MarkdownOxide<CR>", desc = "MarkdownOxide" },
    -- },
  },
}

return M
