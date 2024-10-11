if true then
  return {}
end

-- NOTE: this notebooks setup mostly works, but it's a complex setup and I don't really use it
local M = {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_output_win_max_height = 20
      -- vim.g.molten_image_provider = "image.nvim"
    end,
    dependencies = {
      -- for image.nvim image provider (alternative wezterm.nvim)
      "3rd/image.nvim",
    },
  },
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    enabled = false,
    opts = {
      {
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            -- download_remote_images = true,
            download_remote_images = false,
            only_render_image_at_cursor = true,
            filetypes = { "markdown" }, -- markdown extensions (ie. quarto) can go here
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = true, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.svg" }, -- render image files as images when opened
      },
    },
  },
}
return M
