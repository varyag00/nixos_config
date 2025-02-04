-- TODO: toggle terminal on C-` keymap

-- NOTE: This is functionally idnetical to the "lazyvim.plugins.extras.lang.markdown" extra, but configured to my liking
-- diffs:
-- - added obsidian.nvim
-- - modified markdown.nvim config
-- - removed markdown-preview (uses browser)

-- -- temporarily disable
-- if true then return {} end

-- local preset = require("markview.presets")

local M = {
  -- SECTION: obsidian.nvim
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    -- event = {
    --   "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Sync/ObsidianVault/**.md",
    --   "BufNewFile " .. vim.fn.expand("~") .. "/Documents/Sync/ObsidianVault/**.md",
    -- },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
      "epwalsh/pomo.nvim",
    },
    keys = {
      -- Add these only if filetype is md (ft = "markdown")
      {
        "<localleader>/",
        "<cmd>ObsidianSearch<cr>",
        desc = "Obsidian Grep (Vault)",
        ft = "markdown",
      },
      {
        "<localleader>.",
        "<cmd>ObsidianQuickSwitch<cr>",
        desc = "Obsidian Find Files",
        ft = "markdown",
      },
      {
        "<localleader>O",
        "<cmd>ObsidianOpen<cr>",
        desc = "Open Obsidian.md",
        ft = "markdown",
      },
      {
        "<localleader>j",
        "<cmd>ObsidianDailies<cr>",
        desc = "Open Obsidian Daily Notes",
        ft = "markdown",
      },
      {
        "<localleader>n",
        "<cmd>ObsidianNew<cr>",
        desc = "Create new Obsidian Document",
        ft = "markdown",
      },
      {
        "<localleader>N",
        "<cmd>ObsidianNewFromTemplate<cr>",
        desc = "Create new Obsidian Document from Template",
        ft = "markdown",
      },
      {
        "<localleader>p",
        "<cmd>ObsidianPasteImg<cr>",
        desc = "Obsidian Paste Image",
        ft = "markdown",
      },
      {
        "<localleader>r",
        "<cmd>ObsidianRename<cr>",
        desc = "Obsidian Rename current note",
        ft = "markdown",
      },
      {
        "<localleader>R",
        "<cmd>ObsidianLinks<cr>",
        desc = "See Obsidian Links",
        ft = "markdown",
      },
      {
        "<localleader>t",
        "<cmd>ObsidianTemplate<cr>",
        desc = "Insert Obsidian Template into file",
        ft = "markdown",
      },
      {
        "<localleader>T",
        "<cmd>ObsidianTags<cr>",
        desc = "Search Obsidian Tags",
        ft = "markdown",
      },
      {
        "<localleader>#",
        "<cmd>ObsidianTags<cr>",
        desc = "Search Obsidian Tags",
        ft = "markdown",
      },
      -- visual maps
      {
        "<localleader>i",
        "<cmd>ObsidianLink<cr>",
        mode = { "v" },
        desc = "Obsidian Link",
        ft = "markdown",
      },
      {
        "<localleader>l",
        "<cmd>ObsidianLink<cr>",
        mode = { "v" },
        desc = "Obsidian Link",
        ft = "markdown",
      },
      {
        "<localleader>L",
        "<cmd>ObsidianLinkNew<cr>",
        mode = { "v" },
        desc = "Obsidian Link (New Note)",
        ft = "markdown",
      },
    },
    opts = {
      completion = {
        nvim_cmp = false,
        min_chars = 2,
      },
      new_notes_location = "current_dir",
      preferred_link_style = "wiki", -- or "markdown"
      wiki_link_func = "prepend_note_path",
      disable_frontmatter = false,
      -- configured per-vault below
      -- daily_notes = { },
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
        end

        local out = { id = note.id, aliases = note.aliases, tags = note.tags }
        -- local out = { id = note.metadata.id or note.id, aliases = note.aliases, tags = note.tags }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,
      -- NOTE: disable random ID generation for note filenames
      note_id_func = function(title)
        local suffix = ""
        if title == nil then
          -- if title is nil, prompt the user for a note ID
          local utils = require("obsidian.util")
          suffix = utils.input("Enter note ID: ") or ""
        else
          suffix = title
        end
        -- sanity check the title
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        return suffix
      end,
      -- default value:
      -- note_id_func = function(title)
      --   -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      --   -- In this case a note with the title 'My new note' will be given an ID that looks
      --   -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      --   local suffix = ""
      --   if title ~= nil then
      --     -- If title is given, transform it into valid file name.
      --     suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      --   else
      --     -- If title is nil, just add 4 random uppercase letters to the suffix.
      --     for _ = 1, 4 do
      --       suffix = suffix .. string.char(math.random(65, 90))
      --     end
      --   end
      --   return tostring(os.time()) .. "-" .. suffix
      -- end,
      workspaces = {
        {
          name = "work-notes",
          path = "~/work/work-notes/",
          overrides = {
            daily_notes = {
              folder = "journal/",
              date_format = "%Y-%m-%d",
              default_tags = { "type/nvim-daily", "source/nvim" },
            },
            templates = {
              folder = "templates",
              -- Custom template vars
              substitutions = {
                daily_title = function()
                  return os.date("%Y-%m-%d %A")
                end,
                date_with_time = function()
                  return os.date("%Y-%m-%d, %H:%M:%S")
                end,
              },
            },
            attachments = {
              img_folder = "notes/images",
            },
          },
        },
        {
          name = "personal-notes",
          path = "~/obsidian/obsidian_tasks/",
          overrides = {
            notes_subdir = "notes/",
            daily_notes = {
              folder = "journal/",
              template = "templates/daily-nvim.md",
              date_format = "%Y-%m-%d",
              alias_format = "%Y-%m-%d", -- default alias
              default_tags = { "type/nvim-daily", "source/nvim" },
              -- NOTE: add extra frontmatter (including additiona tags and aliases) to the daily-nvim.md template.
              -- It will be merged with the default frontmatter declared here
            },
            templates = {
              folder = "templates",
              -- Custom template vars
              substitutions = {
                daily_title = function()
                  return os.date("%Y-%m-%d %A")
                end,
                date_with_time = function()
                  return os.date("%Y-%m-%d, %H:%M:%S")
                end,
              },
            },
            attachments = {
              img_folder = "notes/images",
            },
          },
        },
        { name = "test", path = "~/obsidian-nvim-test/" },
        -- NOTE: enable obsidian.nvim outside of vaults/workspaces
        -- (see README: https://github.com/epwalsh/obsidian.nvim?tab=readme-ov-file#usage-outside-of-a-workspace-or-vault)
        {
          name = "no-vault",
          path = function()
            -- alternatively use the CWD:
            -- return assert(vim.fn.getcwd())

            -- dir of current file
            return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
          end,
          overrides = {
            notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
            new_notes_location = "current_dir",
            templates = {
              folder = vim.NIL,
            },
            disable_frontmatter = true,
          },
        },
      },
      ui = {
        enable = false,
        -- enable = true,
        -- TODO: remove to add the remaining icons
        checkboxes = {
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          ["/"] = { char = "󰜺", hl_group = "ObsidianTilde" },
          ["-"] = { char = "󰥔", hl_group = "ObsidianTodo" }, -- TODO: maybe Done?
        },
      },
    },
    -- FIXME: this is a workaround for missing blink.nvim completion
    -- > see: https://github.com/epwalsh/obsidian.nvim/issues/770
    -- > see: below for new required blink.cmp sources
    config = function(_, opts)
      require("obsidian").setup(opts)

      -- HACK: fix error, disable completion.nvim_cmp option, manually register sources for blink.cmp below
      local cmp = require("cmp")
      cmp.register_source("obsidian", require("cmp_obsidian").new())
      cmp.register_source("obsidian_new", require("cmp_obsidian_new").new())
      cmp.register_source("obsidian_tags", require("cmp_obsidian_tags").new())
    end,
  },
  -- workaround for the same issue https://github.com/epwalsh/obsidian.nvim/issues/770#issuecomment-2557300925
  {
    "saghen/blink.cmp",
    dependencies = { "saghen/blink.compat" },
    opts = {
      sources = {
        default = { "obsidian", "obsidian_new", "obsidian_tags" },
        providers = {
          obsidian = {
            name = "obsidian",
            module = "blink.compat.source",
          },
          obsidian_new = {
            name = "obsidian_new",
            module = "blink.compat.source",
          },
          obsidian_tags = {
            name = "obsidian_tags",
            module = "blink.compat.source",
          },
        },
      },
    },
  },
  -- END_SECTION: obsidian.nvim
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        -- TODO: disable long line rule,
        -- https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file
        -- https://github.com/DavidAnson/markdownlint-cli2
        -- https://github.com/DavidAnson/markdownlint/blob/v0.32.1/README.md#configuration
        -- https://github.com/DavidAnson/markdownlint/blob/v0.32.1/README.md#rules--aliases
        markdown = { "markdownlint-cli2" },
      },
      -- Disable some annoying rules
      linters = {
        ["markdownlint-cli2"] = {
          -- FIXME: enabling this correctly configures linting, but completely breaks formatting
          --  same goes for directly adding the .markdownlint-cli2.yaml file to a markdown project dir.
          --  perhaps try markdownlint-cli and configure from CLI instead (the original)
          -- NOTE: file MUST be named ".markdownlint-cli2.yaml" (or the json equivalent)
          -- args = { "--config", os.getenv("HOME") .. "/.config/lsp/config.markdownlint-cli2.yaml", "--" },
          args = { "--config", os.getenv("HOME") .. "/.config/lsp/config.markdownlint-cli2.yaml", "--" },
          markdownlint = {
            args = {
              -- TODO: extract configuration to file
              "--disable",
              "MD004", -- ul-style
              -- "--disable",
              -- "MD012", -- no-multiple-blanks
              "--disable",
              "MD013", -- line-length
              "--disable",
              "MD032", -- blanks-around-lists
              "--",
            },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        ["markdownlint-cli2"] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
        markdownlint = {
          -- TODO: extract configuration to file
          args = {
            "--disable",
            "MD004", -- ul-style
            -- "--disable",
            -- "MD012", -- no-multiple-blanks
            "--disable",
            "MD013", -- line-length
            "--disable",
            "MD032", -- blanks-around-lists
            -- "--", -- for stdin = true
            "--fix", -- format
            "$FILENAME",
          },
          stdin = false,
        },
      },
      formatters_by_ft = {
        ["markdown"] = { "markdownlint" },
        ["markdown.mdx"] = { "prettier", "markdownlint-cli2" },
      },
    },
  },

  -- {
  --   "MeanderingProgrammer/markdown.nvim",
  --   opts = {
  --     file_types = { "markdown", "norg", "rmd", "org" },
  --     code = {
  --       sign = false,
  --       width = "block",
  --       right_pad = 1,
  --     },
  --     -- NOTE: overridden from the extra's default
  --     heading = {
  --       sign = true, -- perhaps disable
  --       icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
  --     },
  --     bullet = {
  --       enabled = true,
  --       icons = { '●', '○', '◆', '◇' },
  --       left_pad = 0,
  --       right_pad = 0,
  --       highlight = 'RenderMarkdownBullet',
  --     },
  --     checkbox = {
  --       enabled = true,
  --       unchecked = { icon = '󰄱', highlight = 'RenderMarkdownUnchecked' },
  --       checked = { icon = '󰱒', highlight = 'RenderMarkdownChecked' },
  --       custom = {
  --         -- todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo' },
  --         -- canceled = { raw = '[/]', rendered = '󰜺 ', highlight = 'RenderMarkdownError' },
  --         todo = { raw = '[-]', rendered = '󰥔', highlight = 'RenderMarkdownTodo' },
  --         canceled = { raw = '[/]', rendered = '󰜺', highlight = 'RenderMarkdownError' },
  --       },
  --     },
  --   },
  --   ft = { "markdown", "norg", "rmd", "org" },
  --   config = function(_, opts)
  --     require("render-markdown").setup(opts)
  --     LazyVim.toggle.map("<leader>um", {
  --       name = "Render Markdown",
  --       get = function()
  --         return require("render-markdown.state").enabled
  --       end,
  --       set = function(enabled)
  --         local m = require("render-markdown")
  --         if enabled then
  --           m.enable()
  --         else
  --           m.disable()
  --         end
  --       end,
  --     })
  --   end,
  -- },

  -- NOTE: stopped using this because I prefer obsidian.nvim + marksman.nvim + markdown.nvim
  -- {
  --   "Feel-ix-343/markdown-oxide",
  --   -- config = function()
  --   --   require("markdown-oxide").setup()
  --   -- end,
  --   config = function(_, opts)
  --     -- An example nvim-lspconfig capabilities setting
  --     local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
  --
  --     -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
  --     -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
  --     capabilities.workspace = {
  --       didChangeWatchedFiles = {
  --         dynamicRegistration = true,
  --       },
  --     }
  --
  --     -- local on_attach = require("lazyvim.util").on_attach()
  --
  --     -- TODO: this
  --     require("lspconfig").markdown_oxide.setup({
  --       capabilities = capabilities, -- again, ensure that capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
  --       -- on_attach = on_attach        -- configure your on attach config
  --
  --     })
  --   end,
  --   -- keys = {
  --   --   { "n", "<leader>mo", ":MarkdownOxide<CR>", desc = "MarkdownOxide" },
  --   -- },
  -- },
}
return M
