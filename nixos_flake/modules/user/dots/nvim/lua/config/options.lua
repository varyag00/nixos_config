-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- disable popup menu blending (transparency)
opt.pumblend = 0

opt.clipboard = "unnamed" -- Do NOT sync with system clipboard
