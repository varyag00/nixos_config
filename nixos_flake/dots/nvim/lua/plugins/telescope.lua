-- TODO: if possible, transition plugins to fzf-lua
local M = {
  {
    "telescope.nvim",
    opts = function()
      return {
        defaults = {
          -- show filename first, with path after ()
          path_display = {
            filename_first = {
              -- looks a bit strange, but it works:
              -- filename | dir/to/path/some/dan/~
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
  -- TODO: check if snacks has an env var module
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
