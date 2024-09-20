local M = {
  {
    "epwalsh/pomo.nvim",
    version = "*",
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
    dependencies = {
      -- Optional, but highly recommended if you want to use the "Default" timer
      "rcarriga/nvim-notify",
    },
    opts = {
      timers = {
        -- For example, use only the "System" notifier when you create a timer called "Break",
        -- e.g. ':TimerStart 2m Break'.
        Break = {
          { name = "System" },
        },
        Work = {
          { name = "System" },
        },
      },
      --You can optionally define custom timer sessions.
      sessions = {
        -- Example session configuration for a session called "pomodoro".
        pomodoro = {
          { name = "Work",        duration = "25m" },
          { name = "Short Break", duration = "5m" },
          { name = "Work",        duration = "25m" },
          { name = "Short Break", duration = "5m" },
          { name = "Work",        duration = "25m" },
          { name = "Long Break",  duration = "15m" },
        },
      },
    },
    keys = {
      require("which-key").add({
        {
          "<leader>ut",
          "",
          icon = { icon = "󱎫", color = "purple" },
          desc = "+timers",
          group = "timers",
          mode = { "n", "v" },
        },
        -- work
        {
          "<leader>utw",
          "", -- group
          icon = { icon = "󱎫", color = "blue" },
          desc = "Start work..",
        },
        {
          "<leader>utw1",
          "<cmd>TimerStart 25m Work<cr>",
          icon = { icon = "󱎫", color = "blue" },
          desc = "Start 25m work timer"
        },
        {
          "<leader>utw2",
          "<cmd>TimerStart 50m Work<cr>",
          icon = { icon = "󱎫", color = "blue" },
          desc = "Start 50m work timer"
        },
        -- break
        {
          "<leader>utb",
          "", -- group
          icon = { icon = "󱎫", color = "green" },
          desc = "Start break..",
        },
        {
          "<leader>utb1",
          "<cmd>TimerStart 5m Break<cr>",
          icon = { icon = "󱎫", color = "green" },
          desc = "Start 5m break timer",
        },
        {
          "<leader>utb2",
          "<cmd>TimerStart 15m Break<cr>",
          icon = { icon = "󱎫", color = "green" },
          desc = "Start 15m break timer",
        },
        {
          "<leader>uts",
          "<cmd>TimerStop<cr>",
          icon = { icon = "󱎫", color = "red" },
          desc = "Stop running timers"
        },
        -- checking
        {
          '<leader>uta',
          ':lua require("custom.pomo_popup").start_check_timer()<CR>',
          icon = { icon = '󱤥', color = 'green' },
          desc = 'Start Checking',
        },
        {
          '<leader>utx',
          ':lua require("custom.pomo_popup").stop_check_timer()<CR>',
          icon = { icon = '󱤥 ', color = 'red' },
          desc = 'Stop Checking',
        },
      })
    }
    -- TODO: when there is no timer going, popup a noice notification every ~15s (to make it annoying)
    -- Message = "󱎫 No timer is ongoing. Set one up!
  },
  {
    "OXY2DEV/helpview.nvim",
    lazy = false, -- Recommended
    -- In case you still want to lazy load
    -- ft = "help",
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    }
  },
  -- pretty code screenshots
  { "mistricky/codesnap.nvim", build = "make" },
  -- browser bookmarks in nvim
  {
    -- TODO: run this setup function() require('telescope').load_extension('bookmarks') end,
    'dhruvmanila/browser-bookmarks.nvim',
    version = '*',
    -- Only required to override the default options
    opts = {
      -- NOTE: supports buku and qutebrowser
      selected_browser = "brave"
    },
    dependencies = {
      -- Only if your selected browser is Firefox, Waterfox or buku
      'kkharji/sqlite.lua',
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      {
        "<leader>sB", "<cmd>Telescope bookmarks<cr>", desc = "Browser Bookmarks",
      },
    },
  },
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   keys = {
  --     -- NOTE: browser-bookmarks.nvim telescope integration
  --     {
  --       "<leader>sB", "<cmd>Telescope bookmarks<cr>", desc = "Browser Bookmarks",
  --     },
  --   },
  -- },
}
return M
