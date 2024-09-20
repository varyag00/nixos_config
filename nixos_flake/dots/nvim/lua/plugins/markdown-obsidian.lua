-- TODO: toggle terminal on C-` keymap

-- NOTE: This is functionally idnetical to the "lazyvim.plugins.extras.lang.markdown" extra, but configured to my liking
-- diffs:
-- - added obsidian.nvim
-- - modified markdown.nvim config
-- - removed markdown-preview (uses browser)

-- -- temporarily disable
-- if true then return {} end

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
        "<localleader>o",
        "",
        desc = "+Obsidian",
        ft = "markdown",
      },
      {
        "<localleader>o/",
        "<cmd>ObsidianSearch<cr>",
        desc = "Obsidian Grep (Vault)",
        ft = "markdown",
      },
      {
        "<localleader>o.",
        "<cmd>ObsidianQuickSwitch<cr>",
        desc = "Obsidian Find Files",
        ft = "markdown",
      },
      {
        "<localleader>oO",
        "<cmd>ObsidianOpen<cr>",
        desc = "Open Obsidian.md",
        ft = "markdown",
      },
      {
        "<localleader>oj",
        "<cmd>ObsidianDailies<cr>",
        desc = "Open Obsidian Daily Notes",
        ft = "markdown",
      },
      {
        "<localleader>on",
        "<cmd>ObsidianNew<cr>",
        desc = "Create new Obsidian Document",
        ft = "markdown",
      },
      {
        "<localleader>oN",
        "<cmd>ObsidianNewFromTemplate<cr>",
        desc = "Create new Obsidian Document from Template",
        ft = "markdown",
      },
      {
        "<localleader>op",
        "<cmd>ObsidianPasteImg<cr>",
        desc = "Obsidian Paste Image",
        ft = "markdown",
      },
      {
        "<localleader>or",
        "<cmd>ObsidianRename<cr>",
        desc = "Obsidian Rename current note",
        ft = "markdown",
      },
      {
        "<localleader>oR",
        "<cmd>ObsidianLinks<cr>",
        desc = "See Obsidian Links",
        ft = "markdown",
      },
      {
        "<localleader>ot",
        "<cmd>ObsidianTemplate<cr>",
        desc = "Insert Obsidian Template into file",
        ft = "markdown",
      },
      {
        "<localleader>oT",
        "<cmd>ObsidianTags<cr>",
        desc = "Search Obsidian Tags",
        ft = "markdown",
      },
      {
        "<localleader>o#",
        "<cmd>ObsidianTags<cr>",
        desc = "Search Obsidian Tags",
        ft = "markdown",
      },
      -- visual maps
      {
        "<localleader>ol",
        "<cmd>ObsidianLink<cr>",
        mode = { "n", "v" },
        desc = "Obsidian Link",
        ft = "markdown",
      },
      {
        "<localleader>oL",
        "<cmd>ObsidianLinkNew<cr>",
        mode = { "n", "v" },
        desc = "Obsidian Link (New Note)",
        ft = "markdown",
      },
    },
    opts = {
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
            }
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
            }
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
      -- TODO: try using obsidian's rendering but keeping markdown.nvim for something?
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
  },
  -- END_SECTION: obsidian.nvim
  -- SECTION: markview.nvim
  {
    "OXY2DEV/markview.nvim",
    -- lazy = false, -- Recommended
    ft = { "markdown", "norg", "rmd", "org" }, -- If you decide to lazy-load anyway
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      -- hybrid mode: normal and insert
      -- modes = { "n", "i", "no", "c" }, -- Change these modes to what you need
      -- hybrid_modes = { "n", "i" },     -- Uses this feature on
      -- callbacks = {
      --   on_enable = function(_, win)
      --     vim.wo[win].conceallevel = 2;
      --     vim.wo[win].concealcursor = "nc";
      --   end
      -- },
      -- hybrd mode: normal only
      modes = { "n", "no", "c" }, -- Change these modes
      hybrid_modes = { "n" }, -- Uses this feature on
      callbacks = {
        on_enable = function(_, win)
          vim.wo[win].conceallevel = 2
          vim.wo[win].concealcursor = "c"
        end,
      },
      -- links = {
      --   -- inline_links = {
      --   hyperlinks = {
      --     hl = "@markup.link.label.markdown_inline", -- markown?
      --     icon = " ",
      --     icon_hl = "@markup.link",
      --   },
      --   images = {
      --     hl = "@markup.link.label.markdown_inline",
      --     icon = " ",
      --     icon_hl = "@markup.link",
      --   },
      --   },
      --  },
      checkboxes = {
        enable = true,
        checked = { text = "", hl = "MarkviewCheckboxChecked" },
        unchecked = { text = "☐", hl = "MarkviewListItemStar" }, -- blue instead of red
        -- BUG: using "pending" as "canceled" since pending matches [-] even when disabled
        -- pending = {},
        pending = { text = "󰜺", hl = "MarkviewCheckboxUnchecked" }, -- uses [-];
        custom = {
          -- See above BUG
          -- { match = "-", text = "󰜺", hl = "MarkviewCheckboxUnchecked" }, -- canceled [-]
          { match = "/", text = "󰥔", hl = "MarkviewCheckboxPending" }, -- pending [/]
        },
      },
      list_items = {
        enable = true,
        -- colours from folke's dots
        marker_minus = { add_padding = false, text = "●", hl = "@markup.list.markdown" },
        marker_plus = { add_padding = false, text = "○", hl = "@markup.list.markdown" },
        marker_star = { add_padding = false, text = "◆", hl = "@markup.list.markdown" },
        --  numbered list, so no text replacement
        marker_dot = { add_padding = false, hl = "@markup.list.markdown" },
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
      inline_codes = { enable = true },
      headings = {
        enable = true,
        shift_width = 1,
        shift_char = " ",
        heading_1 = { icon = "🔗 ", style = "icon", hl = "Headline1" },
        heading_2 = { icon = "🔗 ", style = "icon", hl = "Headline2" },
        heading_3 = { icon = "🔗 ", style = "icon", hl = "Headline3" },
        heading_4 = { icon = "🔗 ", style = "icon", hl = "Headline4" },
        heading_5 = { icon = "🔗 ", style = "icon", hl = "Headline5" },
        heading_6 = { icon = "🔗 ", style = "icon", hl = "Headline6" },
      },
    },
    -- config = function(_, opts)
    --   require("markview").setup(opts)
    --   LazyVim.toggle.map("<leader>um", {
    --     name = "Render Markdown",
    --     get = function()
    --       return require("render-markdown.state").enabled
    --     end,
    --     set = function(enabled)
    --       local m = require("render-markdown")
    --       if enabled then
    --         m.enable()
    --       else
    --         m.disable()
    --       end
    --     end,
    --   })
    -- end,
    keys = {
      { "n", "<leader>um", ":MarkviewToggle<CR>", desc = "Render Markdown", ft = { "markdown", "norg", "rmd", "org" } },
    },
  },
  -- END_SECTION: markview.nvim
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
          -- args = { "--config", os.getenv("HOME") .. "/.config/lsp/.markdownlint-cli2.yaml", "--" },
        },
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
