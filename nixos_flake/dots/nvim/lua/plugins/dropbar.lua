local M = {}
-- works for 0.11, etc. as well
if vim.fn.has("nvim-0.10") == 1 then
  table.insert(M, {
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
        "g.",
        function()
          require("dropbar.api").select_next_context()
        end,
        desc = "Winbar nav",
      },
      {
        "<leader>c.",
        function()
          require("dropbar.api").select_next_context()
        end,
        desc = "Winbar nav",
      },
    },
    opts = function()
      -- from: https://github.com/Bekaboo/dropbar.nvim/issues/160#issuecomment-2119196889
      local open_item_and_close_menu = function()
        local utils = require("dropbar.utils")
        local menu = utils.menu.get_current()
        if not menu then
          return
        end

        local cursor = vim.api.nvim_win_get_cursor(menu.win)
        local entry = menu.entries[cursor[1]]
        -- stolen from https://github.com/Bekaboo/dropbar.nvim/issues/66
        local component = entry:first_clickable(entry.padding.left + entry.components[1]:bytewidth())
        if component then
          menu:click_on(component, nil, 1, "l")
        end
      end

      return {
        menu = {
          -- can be distracting, but I like having it on
          -- preview = false,
          quick_navigation = true,

          keymaps = {
            ["h"] = function()
              local utils = require("dropbar.utils")
              local menu = utils.menu.get_current()
              if not menu then
                return
              end
              if menu.prev_menu then
                menu:close()
              else
                local bar = require("dropbar.utils.bar").get({ win = menu.prev_win })
                local barComponents = bar.components[1]._.bar.components
                for _, component in ipairs(barComponents) do
                  if component.menu then
                    local idx = component._.bar_idx
                    menu:close()
                    require("dropbar.api").pick(idx - 1)
                  end
                end
              end
            end,
            ["l"] = function()
              local utils = require("dropbar.utils")
              local menu = utils.menu.get_current()
              if not menu then
                return
              end
              local cursor = vim.api.nvim_win_get_cursor(menu.win)
              local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
              if component then
                menu:click_on(component, nil, 1, "l")
              end
            end,
            ["<CR>"] = open_item_and_close_menu,
            ["o"] = open_item_and_close_menu,
          },

          -- keymaps = {
          --   -- Navigate back to the parent menu.
          --   ["h"] = "<C-w>q",
          --   -- Expands the entry if possible.
          --   ["l"] = function()
          --     local menu = menu_utils.get_current()
          --     if not menu then
          --       return
          --     end
          --     local row = vim.api.nvim_win_get_cursor(menu.win)[1]
          --     local component = menu.entries[row]:first_clickable()
          --     if component then
          --       menu:click_on(component, nil, 1, "l")
          --     end
          --   end,
          --   ["q"] = close,
          --   ["<esc>"] = close,
          --   -- NOTE: added by me
          --   -- fuzzy search buffer default is i
          --   ["/"] = function()
          --     local menu = menu_utils.get_current()
          --     if not menu then
          --       return
          --     end
          --     menu:fuzzy_find_open()
          --   end,
          -- },
        },
      }
    end,
    -- opts = function()
    --   local menu_utils = require("dropbar.utils.menu")
    --
    --   -- Closes all the windows in the current dropbar.
    --   local function close()
    --     local menu = menu_utils.get_current()
    --     while menu and menu.prev_menu do
    --       menu = menu.prev_menu
    --     end
    --     if menu then
    --       menu:close()
    --     end
    --   end
    --
    --   return {
    --     menu = {
    --       -- can be distracting, but I like having it on
    --       -- preview = false,
    --       quick_navigation = true,
    --       keymaps = {
    --         -- Navigate back to the parent menu.
    --         ["h"] = "<C-w>q",
    --         -- Expands the entry if possible.
    --         ["l"] = function()
    --           local menu = menu_utils.get_current()
    --           if not menu then
    --             return
    --           end
    --           local row = vim.api.nvim_win_get_cursor(menu.win)[1]
    --           local component = menu.entries[row]:first_clickable()
    --           if component then
    --             menu:click_on(component, nil, 1, "l")
    --           end
    --         end,
    --         ["q"] = close,
    --         ["<esc>"] = close,
    --         -- NOTE: added by me
    --         -- fuzzy search buffer default is i
    --         ["/"] = function()
    --           local menu = menu_utils.get_current()
    --           if not menu then
    --             return
    --           end
    --           menu:fuzzy_find_open()
    --         end,
    --       },
    --     },
    --   }
    -- end,
  })
end
return M
