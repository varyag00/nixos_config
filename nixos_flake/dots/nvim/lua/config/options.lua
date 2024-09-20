-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- disable popup menu blending (transparency)
opt.pumblend = 0

opt.clipboard = "unnamed" -- Do NOT sync with system clipboard


vim.g.annoying_me = false

vim.g.lazyvim_python_ruff = "ruff"
vim.g.lazyvim_python_lsp = "basedpyright"

-- SECTION: Neovide
if vim.g.neovide then
  -- vim.o.guifont = "IosevkaTerm Nerd Font Mono:h13"
  vim.o.guifont = "SauceCodePro Nerd Font Mono:h13"

  -- default copy + paste bindings
  vim.keymap.set('n', '<D-s>', ':w<CR>')      -- Save
  vim.keymap.set('v', '<D-c>', '"+y')         -- Copy
  vim.keymap.set('n', '<D-v>', '"+P')         -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P')         -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+')      -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

  -- resize keybindings
  vim.g.neovide_scale_factor = 1.0
  local scale_delta = 1.125 -- default is 1.25 but it's too much
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(scale_delta)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / scale_delta)
  end)

  vim.g.neovide_cursor_animate_in_command_line = false -- default true
  vim.g.neovide_cursor_animate_in_insert_mode = false  -- default true
  vim.g.neovide_cursor_trail_size = 0.2                -- default 0.8
  vim.g.neovide_cursor_animation_length = 0.05         -- default 0.13

  vim.g.neovide_position_animation_length = 0.15       -- default 0.15
  vim.g.neovide_scroll_animation_length = 0.15         -- default 0.3

  -- TODO: disable mini.animate
end
-- END_SECTION: Neovide
