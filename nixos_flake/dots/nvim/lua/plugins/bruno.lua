-- bruno is an http testing tool.
-- there is no nvm plugin, but this treesitter grammer enables syntax highlighting
-- BUG: syntax highlighting doesn't work

if true then
  return {}
end

local M = {
  {
    "jesses-code-adventures/bruno.nvim",
    opts = {},
    keys = {
      {
        "<leader>Rs",
        function()
          require("bruno").query_current_file()
        end,
        mode = "n",
        desc = "Test the current query with the results in a scratch buffer.",
      },
    },
    lazy = false,
  },
}

return M
