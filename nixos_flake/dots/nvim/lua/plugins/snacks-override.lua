-- NOTE: only {cmd, event, ft, keys, opts, dependencies} will be merged. Everything else will OVERRIDE the defaults
-- see docs: https://www.lazyvim.org/configuration/plugins#%EF%B8%8F-customizing-plugin-specs
M = {
  -- SECTION: folke/snacks
  {
    "folke/snacks.nvim",
    opts = {
      -- -- these two might not be needed with lazy extra
      -- priority = 1000,
      -- lazy = false,
      indent = {
        enabled = true,
        only_scope = true,
        only_current = true,
      },
      dashboard = {
        -- Useful examples:
        --  Advanced: https://github.com/folke/snacks.nvim/blob/main/docs/dashboard.md#advanced
        --  Github Issues: https://github.com/folke/snacks.nvim/blob/main/docs/dashboard.md#github

        -- sections = {
        --   { section = "header" },
        --   { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        --   { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        --   { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        --   { section = "startup" },
        -- },

        sections = {
          { section = "header" },
          -- added
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
          --
          {
            pane = 2,
            section = "terminal",
            cmd = "colorscript -e square",
            height = 5,
            padding = 1,
          },
          -- { section = "keys", gap = 1, padding = 1 },
          {
            pane = 2,
            icon = " ",
            desc = "Browse Repo",
            padding = 1,
            key = "b",
            action = function()
              Snacks.gitbrowse()
            end,
          },
          function()
            local in_git = Snacks.git.get_root() ~= nil
            local cmds = {
              {
                title = "Notifications",
                cmd = "gh notify -s -a -n5",
                action = function()
                  vim.ui.open("https://github.com/notifications")
                end,
                key = "n",
                icon = " ",
                height = 5,
                enabled = true,
              },
              -- {
              --   title = "Open Issues",
              --   cmd = "gh issue list -L 3",
              --   key = "i",
              --   action = function()
              --     vim.fn.jobstart("gh issue list --web", { detach = true })
              --   end,
              --   icon = " ",
              --   height = 7,
              -- },
              {
                icon = " ",
                title = "Open PRs",
                cmd = "gh pr list -L 3",
                key = "P",
                action = function()
                  vim.fn.jobstart("gh pr list --web", { detach = true })
                end,
                height = 7,
              },
              -- NOTE: kinda meh; consider deleting
              {
                icon = " ",
                title = "Git Status",
                cmd = "git --no-pager diff --stat -B -M -C",
                height = 10,
              },
            }
            return vim.tbl_map(function(cmd)
              return vim.tbl_extend("force", {
                pane = 2,
                section = "terminal",
                enabled = in_git,
                padding = 1,
                ttl = 5 * 60,
                indent = 3,
              }, cmd)
            end, cmds)
          end,
          -- { section = "startup" },
        },
      },
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
        hidden = true, -- show hidden files
        ignored = true, -- show gitignored

        files = {
          hidden = true, -- show hidden files
          ignored = true, -- show gitignored
        },
        win = {
          input = {
            keys = {
              -- ["<Esc>"] = { "close", mode = { "n", "i" } },

              -- default C-up and C-down conflict with macos defaults
              ["<C-p>"] = { "history_back", mode = { "i", "n" } },
              ["<C-n>"] = { "history_forward", mode = { "i", "n" } },
              -- doesn't work...
              -- ["<a-H>"] = { "toggle_hidden", mode = { "i", "n" } },
              -- weird shortcuts, but whatever
              ["<a-O>"] = { "toggle_hidden", mode = { "i", "n" } },
              ["<a-I>"] = { "toggle_ignored", mode = { "i", "n" } },
            },
            list = {
              ["<a-O>"] = { "toggle_hidden", mode = { "i", "n" } },
              ["<a-I>"] = { "toggle_ignored", mode = { "i", "n" } },
            },
          },
        },
        sources = {
          explorer = {
            -- explorer config goes here, because explorer is just a picker in disguise
            hidden = true,
            ignored = true,

            win = {
              input = {
                keys = {
                  -- makes explorer not close on <Esc> in input (search, "i")
                  ["<Esc>"] = { "", mode = { "n" } },
                },
              },
              list = {
                keys = {
                  -- makes explorer not close on <Esc> in list view
                  ["<Esc>"] = { "", mode = { "n" } },
                },
              },
            },
          },
          lsp_symbols = {
            layout = { preset = "vscode", preview = "main" },
          },
          buffers = {
            layout = {
              -- preset = "ivy",
              --
              preset = "vscode",
              preview = true,
            },
            current = true,
            sort_lastused = true,
            nofile = false,
            win = {
              input = {
                keys = {
                  ["d"] = "bufdelete",
                  ["x"] = "bufdelete",
                  ["<c-x>"] = { "bufdelete", mode = { "n", "i" } },
                },
              },
              list = {
                keys = {
                  ["d"] = "bufdelete",
                  ["x"] = "bufdelete",
                },
              },
            },
          },
        },
      },
      explorer = {
        replace_netrw = true,
      },
      statuscolumn = {
        -- using defaults
      },
    },
    -- TODO: figure out how to fix use function here which-key
    keys = {
      {
        "<leader>fz",
        function()
          Snacks.picker.zoxide()
        end,
        desc = "Zoxide Files",
      },
      {
        "<leader>s>",
        function()
          Snacks.picker.lsp_symbols({ layout = { preset = "vscode", preview = "main" } })
        end,
        desc = "LSP Symbols",
      },
      {
        "g>",
        function()
          Snacks.picker.lsp_symbols({ layout = { preset = "vscode", preview = "main" } })
        end,
        desc = "LSP Symbols",
      },
    },
  },
  -- TUI which-key group
  {
    "folke/snacks.nvim",
    keys = require("which-key").add({
      {
        "<leader>T",
        "",
        icon = { icon = "", color = "blue" },
        desc = "+TUI",
        group = "TUIs",
        mode = { "n", "v" },
      },

      -- TUI toggles
      {
        "<leader>Tg",
        function()
          Snacks.terminal("lazygit")
        end,
        desc = "lazygit",
      },
      {
        "<leader>Td",
        function()
          Snacks.terminal("lazydocker")
        end,
        desc = "lazydocker",
      },
      {
        "<leader>Td",
        function()
          Snacks.terminal("lazysql")
        end,
        desc = "lazysql",
      },
      {
        "<leader>Tk",
        function()
          Snacks.terminal("k9s")
        end,
        desc = "k9s",
      },
    }),
  },
}
return M
