-- see https://github.com/2nthony/dotfiles/blob/39198b647088e4104222be7c3979de914eaf32f6/.config/nvim/lua/plugins/extras/vscode.lua
if not vim.g.vscode then
  return {}
end

-- NOTE: code's which-key needpops up too slowly without this setting
-- trying out different timeoutlen
vim.o.timeoutlen = 100
-- vim.o.timeoutlen = 500
-- vim.o.updatetime = 100

vim.keymap.set({ "n", "x", "o" }, "<leader>", ":call VSCodeNotify('vspacecode.space')<cr>")
vim.keymap.set({ "n", "x", "o" }, "<C-p>", ":call VSCodeNotify('vspacecode.space')<cr>")

vim.keymap.set("i", "jk", "<esc><cr>")
vim.keymap.set("i", "kj", "<esc><cr>")

-- navigation
vim.keymap.set("n", "H", ":call VSCodeNotify('workbench.action.previousEditor')<cr>")
vim.keymap.set("n", "L", ":call VSCodeNotify('workbench.action.nextEditor')<cr>")

vim.keymap.set("n", "<leader>bd", "<nop>")
vim.keymap.set("n", "<leader>bD", "<nop>")

-- zen
--  NOTE: as a test, this _does_ work and is loaded...
vim.keymap.set("n", "<leader>wo", ":call VSCodeNotify('workbench.action.toggleZenMode')<cr>")

-- explorer
vim.keymap.set("n", "<leader>e", ":call VSCodeNotify('workbench.view.explorer')<cr>")
vim.keymap.set("n", "<leader>fe", "<leader>e")

-- magit
-- BUG: attempts to call lazygit (default <leader>gg command)
-- this attempt to completely disble to <leader>gg keymap, but doesn't work
-- vim.api.nvim_set_keymap("n", "<leader>gg", "", { noremap = true, silent = true })

-- vim.keymap.set("n", "<leader>gg", ":call VSCodeNotify('magit.status')<cr>")
vim.keymap.set("n", "<leader>gg", ":call VSCodeNotify('magit.status')<cr>")
vim.keymap.set("n", "<leader>gs", ":call VSCodeNotify('magit.status')<cr>")
vim.keymap.set("n", "<leader>gS", ":call VSCodeNotify('magit.status')<cr>")

-- code actions
vim.keymap.set("n", "<leader>ca", ":call VSCodeNotify('editor.action.quickFix')<cr>")
vim.keymap.set("n", "<leader>cA", ":call VSCodeNotify('editor.action.sourceAction')<cr>")
vim.keymap.set("n", "<leader>cr", ":call VSCodeNotify('editor.action.rename')<cr>")
vim.keymap.set("n", "<leader>cf", ":call VSCodeNotify('editor.action.formatDocument')<cr>")

vim.keymap.set("n", "<leader>ff", ":call VSCodeNotify('workbench.action.quickOpen')<cr>")
vim.keymap.set("n", "<leader>fr", ":call VSCodeNotify('workbench.action.openRecent')<cr>")

-- -- Neovim UI Modifier vscode extension
-- vim.api.nvim_exec(
--   [[
--     " THEME CHANGER
--     function! SetCursorLineNrColorInsert(mode)
--         " Insert mode: blue
--         if a:mode == "i"
--             call VSCodeNotify('nvim-theme.insert')
--
--         " Replace mode: red
--         elseif a:mode == "r"
--             call VSCodeNotify('nvim-theme.replace')
--         endif
--     endfunction
--
--     augroup CursorLineNrColorSwap
--         autocmd!
--         autocmd ModeChanged *:[vV\x16]* call VSCodeNotify('nvim-theme.visual')
--         autocmd ModeChanged *:[R]* call VSCodeNotify('nvim-theme.replace')
--         autocmd InsertEnter * call SetCursorLineNrColorInsert(v:insertmode)
--         autocmd InsertLeave * call VSCodeNotify('nvim-theme.normal')
--         autocmd CursorHold * call VSCodeNotify('nvim-theme.normal')
--     augroup END
-- ]],
--   false
-- )

-- local keys = {
--   -- reset
--
--   { { "n", "x", "o" }, "<leader>", ":call VSCodeNotify('vspacecode.space')<cr>" },
--   { { "n", "x", "o" }, "<C-p>", ":call VSCodeNotify('vspacecode.space')<cr>" },
--
--   -- bindings --
--   -- NOTE: better to use vscode's undo to avoid confusion
--   -- TODO: check this isn't already done by default
--   { "u", ":call VSCodeNotify('undo')<cr>" },
--   { "<c-r>", ":call VSCodeNotify('redo')<cr>" },
--
--   -- { "ss", ":call VSCodeNotify('workbench.action.splitEditorDown')<cr>" },
--   -- { "sv", ":call VSCodeNotify('workbench.action.splitEditor')<cr>" },
--   -- { "sh", ":call VSCodeNotify('workbench.action.focusLeftGroup')<cr>" },
--   -- { "sl", ":call VSCodeNotify('workbench.action.focusRightGroup')<cr>" },
--   -- { "sk", ":call VSCodeNotify('workbench.action.focusAboveGroup')<cr>" },
--   -- { "sj", ":call VSCodeNotify('workbench.action.focusBelowGroup')<cr>" },
--   -- { "gi", ":call VSCodeNotify('editor.action.goToImplementation')<cr>" },
--   -- { "gp", ":call VSCodeNotify('editor.action.peekDefinition')<cr>" },
--   -- { "gP", ":call VSCodeNotify('editor.action.peekTypeDefinition')<cr>" },
--   -- { "gcc", ":call VSCodeNotify('editor.action.commentLine')<cr>" },
--   -- { "<leader>fe", "<leader>e", remap = true },
--   -- { "<leader>ff", ":call VSCodeNotify('workbench.action.quickOpen')<cr>" },
--   -- { "<leader>fp", ":call VSCodeNotify('workbench.action.openRecent')<cr>" },
--   -- { "<leader>fn", ":call VSCodeNotify('workbench.action.files.newUntitledFile')<cr>" },
--   --
--   -- { "<c-j>", ":call VSCodeNotify('editor.action.marker.next')<cr>" },
--   -- { "J", ":call VSCodeNotify('editor.action.marker.prev')<cr>" },
--   -- { "<c-k>", ":call VSCodeNotify('editor.action.triggerParameterHints')<cr>", mode = { "n", "i" } },
-- }

-- vim.api.nvim_create_autocmd("User", {
--   pattern = "LazyVimKeymaps",
--   -- callback = function()
--   --   lazykeys(keys)
--   -- end,
--   callback = function()
--     return keys
--   end,
-- })

return {
  { import = "lazyvim.plugins.extras.vscode" },
}
