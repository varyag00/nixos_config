local Util = require("lazyvim.util")

local M = {
  -- NOTE: for nix configuration, disable mason-lspconfig to prevent LSP server download errors
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  { "williamboman/mason.nvim", enabled = false },

  -- add more treesitter parsers (extend the default)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },
  {
    -- extending the aerial lazy extra
    "stevearc/aerial.nvim",
    opts = {
      on_attach = function(bufnr)
        -- extend default aerial keybindings
        vim.keymap.set("n", "[[", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "]]", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    },
  },

  -- SECTION: neogit
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
    },
    opts = {
      integrations = {
        diffview = true,
        telescope = true,
      },
      mappings = {
        popup = {
          ["p"] = "PullPopup",
          ["F"] = "PullPopup",
        },
      },
    },
    keys = {
      -- NOTE: decide kind={ tab, floating }
      { "<leader>gg", "<cmd>cd %:h<cr><cmd> Neogit kind=tab<cr>", desc = "Magit Status (current file)" },
      -- BUG:: these didn't work, despite being in the docs
      -- BUG: Also, neogit seems to behave strangely when invoked directly via lua
      -- local function open_neogit_in_current_dir()
      --   -- Get the current buffer's file path
      --   local filepath = vim.api.nvim_buf_get_name(0)
      --     -- Check if the file exists
      --   if filepath == "" then
      --       print("No file is currently open.")
      --       return
      --   end
      --   -- Get the directory of the file
      --   local dir = vim.fn.fnamemodify(filepath, ":h")
      --   -- Open Neogit in the specified directory
      --   require('neogit').open({ cwd = dir })
      -- end
      -- -- Create a command to call the function
      -- vim.api.nvim_create_user_command('NeogitCurrentDir', open_neogit_in_current_dir, {})

      -- remap default lazygit keybindings
      {
        "<leader>gt",
        function()
          Util.terminal({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false })
        end,
        desc = "Lazygit (cwd)",
      },
      {
        "<leader>gT",
        function()
          Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false })
        end,
        desc = "Lazygit (root dir)",
      },
    },

    -- NOTE: `config = true` call `neogit.setup(opts)` by default, so if you want to override with a
    -- function (`config = function() ... end`), you must include `require('neogit').setup({YOUR OPTS})`
    config = true,
    -- enabled = vim.g.vscode ~= nil,
    vscode = false,
  },
  -- END_SECTION: neogit
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>wo", ":ZenMode<cr>", desc = "Zen Mode" },
    },
  },
  -- it ain't elisp, but it's something. fennel seems interesting (compile lisp to lua): https://fennel-lang.org
  -- NOTE: migrated to lua-console
  -- {
  --   "rafcamlet/nvim-luapad",
  --   keys = {
  --     { "<leader>cb", ":Luapad<cr>", desc = "Lua Scratch buffer" },
  --   },
  --   -- last release is pretty old
  --   version = false,
  -- },
  -- NOTE: choose either this + navic extra in lazy.lua, OR dropbar
  -- {
  --   "SmiteshP/nvim-navbuddy",
  --   dependencies = {
  --     "neovim/nvim-lspconfig",
  --     "SmiteshP/nvim-navic",
  --     "MunifTanjim/nui.nvim",
  --   },
  --   keys = {
  --     { "<leader>c.", "<cmd>Navbuddy<cr>", desc = "Navbuddy" },
  --     { "<leader>.", "<cmd>Navbuddy<cr>", desc = "Navbuddy" },
  --   },
  --   config = function()
  --     local navbuddy = require("nvim-navbuddy")
  --     navbuddy.setup({
  --       window = {
  --         border = "single",
  --       },
  --       lsp = { auto_attach = true },
  --     })
  --   end,
  -- },

  -- BUG: seems broken; perhaps must be loaded elsewhere?
  -- {
  --   "nvim-telescope/telescope-frecency.nvim",
  --   config = function()
  --     require("telescope").load_extension("frecency")
  --   end,
  --   keys = {
  --     -- NOTE: decide kind={ tab, floating }
  --     { "<leader>f/", "<cmd>Telescope frecency<cr>", desc = "Telescope Frecency" },
  --   },
  -- },
  -- {
  --   "lukas-reineke/headlines.nvim",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   opts = {
  --     markdown = {
  --       -- NOTE: needed for https://github.com/lukas-reineke/headlines.nvim/issues/41
  --       fat_headline_lower_string = "▔",
  --     },
  --   },
  -- },

  -- -- extend nvim-cmp
  -- {
  --   "hrsh7th/nvim-cmp",
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --     -- add a border to nvim-cmp
  --     local win_opt = {
  --       col_offset = 0,
  --       side_padding = 1,
  --       -- not needed:
  --       -- winhighlight = "Normal:PopMenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
  --     }
  --
  --     -- BUG: table.insert doesn't work, so for now I have to overrride entire opts.mappings
  --     -- table.insert(opts.mapping, { ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) })
  --     -- table.insert(opts.mapping, { ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) })
  --     opts.mapping = cmp.mapping.preset.insert({
  --       -- add C-j, C-k, tab, S-tab
  --       ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  --       ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  --       ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  --       ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  --       -- NOTE: rest below is lazyvim default mapping, see https://github.com/LazyVim/LazyVim/blob/68ff818a5bb7549f90b05e412b76fe448f605ffb/lua/lazyvim/plugins/coding.lua#L57
  --       ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  --       ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  --       ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --       ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --       ["<C-Space>"] = cmp.mapping.complete(),
  --       ["<C-e>"] = cmp.mapping.abort(),
  --       ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --       ["<S-CR>"] = cmp.mapping.confirm({
  --         behavior = cmp.ConfirmBehavior.Replace,
  --         select = true,
  --       }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --       ["<C-CR>"] = function(fallback)
  --         cmp.abort()
  --         fallback()
  --       end,
  --     })
  --     opts.window = {
  --       completion = cmp.config.window.bordered(win_opt),
  --       documentation = cmp.config.window.bordered(win_opt),
  --     }
  --   end,
  -- },
  {
    "yarospace/lua-console.nvim",
    lazy = true,
    keys = {
      {
        "<leader>cb",
        function()
          require("lua-console").toggle_console()
        end,
        desc = "Lua Console",
      },
    },
    opts = {
      external_evaluators = {
        python = {
          cmd = { "python3", "-c" },
          env = { PYTHONPATH = "~/projects" },
          timeout = 100000,
          -- formatter = function(result) do_something; return result end,
        },
      },
    },
  },
}

if vim.fn.has("nvim-0.10") == 1 then
  table.insert(
    M,
    -- TODO: choose ONE of: dropbar, aerial.nvim (lvim extra), OR navbuddy + navic (lvim extra), NOT all of them...
    {
      "Bekaboo/dropbar.nvim",
      event = "LazyFile",
      -- optional, but required for fuzzy finder support
      dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
      },
      -- NOTE: config from https://github.com/LazyVim/LazyVim/pull/3235
      keys = {
        {
          "<leader>cD",
          function()
            require("dropbar.api").pick()
          end,
          desc = "Winbar pick",
        },
        {
          "<leader>.",
          function()
            -- TODO: fix that this can't navigate up the hierarchy (beyond where it started) with "h"
            require("dropbar.api").select_next_context()
          end,
          desc = "Winbar nav",
        },
        {
          "<leader>c.",
          function()
            -- TODO: fix that this can't navigate up the hierarchy (beyond where it started) with "h"
            require("dropbar.api").select_next_context()
          end,
          desc = "Winbar nav",
        },
      },
      opts = function()
        local menu_utils = require("dropbar.utils.menu")

        -- Closes all the windows in the current dropbar.
        local function close()
          local menu = menu_utils.get_current()
          while menu and menu.prev_menu do
            menu = menu.prev_menu
          end
          if menu then
            menu:close()
          end
        end

        return {
          menu = {
            -- can be distracting, but I like having it on
            -- preview = false,
            quick_navigation = true,
            keymaps = {
              -- Navigate back to the parent menu.
              ["h"] = "<C-w>q",
              -- Expands the entry if possible.
              ["l"] = function()
                local menu = menu_utils.get_current()
                if not menu then
                  return
                end
                local row = vim.api.nvim_win_get_cursor(menu.win)[1]
                local component = menu.entries[row]:first_clickable()
                if component then
                  menu:click_on(component, nil, 1, "l")
                end
              end,
              ["q"] = close,
              ["<esc>"] = close,
              -- NOTE: added by me
              -- fuzzy search buffer default is i
              ["/"] = function()
                local menu = menu_utils.get_current()
                if not menu then
                  return
                end
                menu:fuzzy_find_open()
              end,
            },
          },
        }
      end,
    }
  )
end

return M
