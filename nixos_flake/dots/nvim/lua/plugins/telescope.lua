local M = {
  {
    "telescope.nvim",
    opts = function()
      return {
        defaults = {
          -- show filename first, with path after ()
          path_display = {
            filename_first = {
              reverse_directories = true,
            },
          },
          mappings = {
            n = {
              ["c"] = require("telescope.actions").delete_buffer,
              ["d"] = require("telescope.actions").delete_buffer,
              ["x"] = require("telescope.actions").delete_buffer,

              ["q"] = require("telescope.actions").close,
            },
          },
        },
      }
    end,
  },
  {
    "jvgrootveld/telescope-zoxide",
    keys = {
      {
        "<leader>fz",
        ":Telescope zoxide list<CR>",
        noremap = true,
        desc = "Zoxide Change Directory",
      },
    },
    config = function()
      require("telescope").load_extension("zoxide")
    end,
  },
  {
    "LinArcX/telescope-env.nvim",
    keys = {
      {
        "<leader>se",
        ":Telescope env<CR>",
        noremap = true,
        desc = "Env variables",
      },
    },
    config = function()
      require("telescope").load_extension("env")
    end,
  },
}
return M
