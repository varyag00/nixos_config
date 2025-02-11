-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- buffers
-- NOTE: only here for reference
-- if not vim.g.vscode then
--   vim.keymap.set("n", "<leader>bc", require("mini.bufremove").delete, { desc = "Delete buffer" })
--   vim.keymap.set("n", "<leader>bk", require("mini.bufremove").delete, { desc = "Delete buffer" })
-- end

-- -- FIXME: snacks.explorer should probably go elsewhere...
-- vim.keymap.set("n", "<leader>e", function()
--   Snacks.explorer()
-- end, { desc = "Explorer" })
-- vim.keymap.set("n", "<leader>E", function()
--   Snacks.explorer.open()
-- end, { desc = "Explorer Picker" })

-- snacks vscode-like lsp symbols picker, set in snacks.lua
-- vim.keymap.set("n", "g.", function()
--   Snacks.picker.lsp_symbols({ layout = { preset = "vscode", preview = "main" } })
-- end, { desc = "LSP Symbols" })

-- use remap = true to point (remap) to an existing key mappings
vim.keymap.set("n", "<leader>bk", "<leader>bd", { desc = "Delete buffer", remap = true })
vim.keymap.set("n", "<leader>bc", "<leader>bd", { desc = "Delete buffer", remap = true })
-- NOTE: prefer the default <leader>fb
-- vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>", { desc = "Show Buffers" })

-- FIXME: broken? Or were these commands just removed?
vim.keymap.set("n", "<A-h>", "<cmd>BufferLineCyclePrev<cr>")
vim.keymap.set("n", "<A-l>", "<cmd>BufferLineCycleNext<cr>")
-- remove annoying move line on alt-j/k
vim.keymap.set({ "n", "i", "v" }, "<A-j>", "<nop>")
vim.keymap.set({ "n", "i", "v" }, "<A-k>", "<nop>")

vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")
-- vim.keymap.set("i", "jk", "<Esc><cr>")
-- vim.keymap.set("i", "kj", "<Esc><cr>")

vim.keymap.set("n", "<c-\\>", function()
  Snacks.terminal(nil)
  -- Snacks.terminal(nil, { cwd = LazyVim.root() }
end, { desc = "Terminal (Root Dir)" })
vim.keymap.set("t", "<C-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- Paste without replace clipboard
vim.keymap.set("v", "p", '"_dP')

-- System clipboard helpers
vim.keymap.set({ "v", "n" }, "<leader>C", "", { desc = "+clipboard" })
vim.keymap.set({ "v" }, "<leader>CY", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "v", "n" }, "<leader>CP", '"+p', { desc = "Paste from system clipboard" })

-- BUG: Fix for the weird "n" behaviour.... however I am quite sure I introduced this bug by set setting "n" in keys somewhere...
-- observation: seems to re-break between updates
-- observation: seems to only happen in specific files, and the file remains broken consistently regardless of nvim restarts
--    example: ~/obsidian/obsidian_tasks/journal/2024-11-05.md
-- BUG: doesn't work; gets overwritten by "undo" somwhere
-- re-set "n" searchforward keybind
-- from: https://github.com/LazyVim/LazyVim/blob/75750be1c0493659c9fbc60ff5e06dba053ef528/lua/lazyvim/config/keymaps.lua#L55
-- vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
-- vim.keymap.set({ "o", "x" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- same thing:
vim.keymap.set({ "n" }, "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
vim.keymap.set({ "x" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set({ "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
-- BUG: if the above doesn't work, try this C-n mapping
-- add <C-n> as next search result
vim.keymap.set({ "n" }, "<C-n>", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
vim.keymap.set({ "x" }, "<C-n>", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set({ "o" }, "<C-n>", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })

-- ctrl-backspace to delete previous word
vim.keymap.set("i", "", "<C-W>")
vim.keymap.set({ "n" }, "<C-n>", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })

-- comment on c-/
-- BUG: doesn't work
-- vim.api.nvim_set_keymap("v", "<C-/>", ":lua require('Comment.api').toggle.linewise.vsplit()<CR>",
--   { noremap = true, silent = true })

-- telecope buffers list; from linkarzu
-- NOTE: must not be lazy loaded in telecope.lua
-- > these are used alongside the keybinds declared in telescope.lua
-- TODO: make it a normal mode keybind, perhaps something like ",b" or "\b" or "Shift-H" when I'm happy with it (and remove tab bar)

-- local tele_buffers_cmd = "<cmd>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal theme=ivy<cr>"
-- vim.keymap.set("n", "<leader>B", tele_buffers_cmd, { desc = "Show Buffers" })
-- vim.keymap.set("n", "<localleader>b", tele_buffers_cmd, { desc = "Show Buffers" })
-- -- possible keybinds
-- vim.keymap.set("n", "<S-h>", tele_buffers_cmd, { desc = "Show Buffers" })
-- vim.keymap.set("n", "<S-l>", tele_buffers_cmd, { desc = "Show Buffers" })
-- -- because normal-mode t and T are kinda useless
-- vim.keymap.set("n", "<S-t>", tele_buffers_cmd, { desc = "Show Buffers" })

-- NOTE: attempt to reimplement using Snacks picker
-- | docs: https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#buffers
local show_buffers_cmd = function()
  Snacks.picker.buffers({
    current = false,
    -- from https://github.com/folke/snacks.nvim/discussions/531
    on_show = function()
      vim.cmd.stopinsert()
    end,
  })
end
vim.keymap.set("n", "<S-h>", function()
  show_buffers_cmd()
end, { desc = "Show Buffers" })
vim.keymap.set("n", "<S-l>", function()
  show_buffers_cmd()
end, { desc = "Show Buffers" })

-- yaml schema modeline
vim.keymap.set("n", "<leader>cy", function()
  require("custom.additional-schemas").init()
end, { desc = "Set YAML schema" })

-- SECTION: macros
-- FIXME: macros don't get set

-- idea from https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
-- require("which-key").add({
--   -- "<leader>@m",
--   "<leader>m",
--   "",
--   icon = { icon = "󰍔", color = "purple" },
--   desc = "+markdown",
--   group = "markdown",
--   mode = { "n", "v" },
-- })
--
-- -- vim.keymap.set({ "v" }, "<leader>@mbv", "viwc****hP", { desc = "bold visual selection" })
-- vim.keymap.set({ "v" }, "<leader>mbv", "viwc****hP", { desc = "bold visual selection" })
