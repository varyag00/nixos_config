local M = {
  -- disable bufferline (tabs)
  -- tab bars are bad for my ADHD brain; will make my melt
  -- this makes the UI feel cleaner and closer to glorious emacs

  {
    "akinsho/bufferline.nvim",
    enabled = false,
    -- opts = {
    --   options = {
    --     -- stylua: ignore
    --     close_command = function(n) Snacks.bufdelete(n) end,
    --     -- stylua: ignore
    --     right_mouse_command = function(n) Snacks.bufdelete(n) end,
    --     diagnostics = "nvim_lsp",
    --     always_show_bufferline = false,
    --     diagnostics_indicator = function(_, _, diag)
    --       local icons = LazyVim.config.icons.diagnostics
    --       local ret = (diag.error and icons.Error .. diag.error .. " " or "")
    --         .. (diag.warning and icons.Warn .. diag.warning or "")
    --       return vim.trim(ret)
    --     end,
    --     offsets = {
    --       {
    --         filetype = "neo-tree",
    --         text = "Neo-tree",
    --         highlight = "Directory",
    --         text_align = "left",
    --       },
    --     },
    --     ---@param opts bufferline.IconFetcherOpts
    --     get_element_icon = function(opts)
    --       return LazyVim.config.icons.ft[opts.filetype]
    --     end,
    --
    --     -- TODO: determine if I can only display pinned buffers
    --     custom_filter = function(buf_number)
    --       -- Check if the buffer is pinned
    --       local is_pinned = vim.fn.getbufvar(buf_number, "buflisted") == 1
    --       return is_pinned
    --     end,
    --   },
    -- },
  },
}

return M
