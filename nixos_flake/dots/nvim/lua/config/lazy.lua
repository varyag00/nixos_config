local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- import any lazy extras modules here
local spec = {
  { import = "lazyvim.plugins.extras.dap.core" },
  -- debug nvim's lua
  { import = "lazyvim.plugins.extras.dap.nlua" },
  { import = "lazyvim.plugins.extras.test.core" },

  { import = "lazyvim.plugins.extras.coding.luasnip" },
  -- annotation generator
  { import = "lazyvim.plugins.extras.coding.neogen" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  { import = "lazyvim.plugins.extras.coding.yanky" },

  -- FIXME: use blink.nvim (new default) for completion, but watch out for bugs
  -- > Bugs observed: obsidian.nvim: https://github.com/epwalsh/obsidian.nvim/issues/793
  -- >  - triaged in ../plugins/obsidian.lua
  -- { import = "lazyvim.plugins.extras.coding.nvim-cmp" },
  { import = "lazyvim.plugins.extras.coding.blink" },

  -- languages
  { import = "lazyvim.plugins.extras.lang.nix" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.lang.toml" },
  { import = "lazyvim.plugins.extras.lang.terraform" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.ansible" },
  { import = "lazyvim.plugins.extras.lang.cmake" },
  { import = "lazyvim.plugins.extras.lang.helm" },
  { import = "lazyvim.plugins.extras.lang.git" },
  -- nvim-dadbod
  { import = "lazyvim.plugins.extras.lang.sql" },
  -- { import = "lazyvim.plugins.extras.lang.typescript" },
  -- { import = "lazyvim.plugins.extras.lang.rust" },
  -- dotfiles support; not an extras.lang but it includes lsp settings
  { import = "lazyvim.plugins.extras.util.dot" },

  -- global and per-project settings
  -- TODO: re-evaluate using this; no longer being developed
  { import = "lazyvim.plugins.extras.lsp.neoconf" },

  -- ui
  { import = "lazyvim.plugins.extras.ui.mini-indentscope" },
  { import = "lazyvim.plugins.extras.ui.treesitter-context" },

  -- window layout manager
  { import = "lazyvim.plugins.extras.ui.edgy" },

  -- project manager NOTE: use snacks project instead
  -- { import = "lazyvim.plugins.extras.util.project" },
  -- live preview for rename
  { import = "lazyvim.plugins.extras.editor.inc-rename" },
  -- FIXME: use fzf-lua (new default picker) instead of telescope, but watch out for bugs
  -- { import = "lazyvim.plugins.extras.editor.fzf" },
  -- { import = "lazyvim.plugins.extras.editor.telescope" },
  { import = "lazyvim.plugins.extras.editor.snacks_picker" },
  { import = "lazyvim.plugins.extras.editor.snacks_explorer" },

  -- interesting refactoring
  { import = "lazyvim.plugins.extras.editor.refactoring" },
  -- buffer harpooning
  { import = "lazyvim.plugins.extras.editor.harpoon2" },
  -- symbols outline
  -- { import = "lazyvim.plugins.extras.editor.aerial" },
  -- symbols outline
  -- { import = "lazyvim.plugins.extras.editor.outline" },
  -- highlight usage of word under cursor
  { import = "lazyvim.plugins.extras.editor.illuminate" },
  -- smarter C-a/C-x increment
  { import = "lazyvim.plugins.extras.editor.dial" },
  -- task runner
  { import = "lazyvim.plugins.extras.editor.overseer" },
  -- github integration
  { import = "lazyvim.plugins.extras.util.octo" },
  -- http client
  { import = "lazyvim.plugins.extras.util.rest" },
}

-- SECTION: conditional plugins

-- NOTE: always use copilot and never use codeium atm
table.insert(spec, { import = "lazyvim.plugins.extras.ai.copilot" })
table.insert(spec, { import = "lazyvim.plugins.extras.ai.copilot-chat" })
-- NOTE: neovide doesn't source .zshrc, so these need to go in $ZDOTDIR/.zshenv
-- if os.getenv("WORK_ENV") == "1" then
--   table.insert(spec, { import = "lazyvim.plugins.extras.coding.copilot" })
--   table.insert(spec, { import = "lazyvim.plugins.extras.coding.copilot-chat" })
--   -- elseif os.getenv("WORK_ENV") == "0" then
--   --   table.insert(spec, { import = "lazyvim.plugins.extras.coding.codeium" })
-- end

-- these cause graphical glitches inside neovide
if not vim.g.neovide then
  -- fancy animated cursor inside terminal
  -- TODO: try disabling and using Snacks instead
  table.insert(spec, { import = "lazyvim.plugins.extras.ui.smear-cursor" })
end

-- END_SECTION: conditional plugins

-- NOTE: process spec to ensure correct formatting:
-- NOTE: 1st: lazy plugins
-- NOTE: 2nd: extras
-- NOTE: 3rd: my plugin configs
-- first (zero index): lazy and its plugins
table.insert(spec, 1, { "LazyVim/LazyVim", import = "lazyvim.plugins" })
-- last: personal plugins and overrrides
table.insert(spec, { import = "plugins" })
table.insert(spec, { import = "snippets" })

require("lazy").setup({
  spec = spec,
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true,
    frequency = 86400, -- check for updates every DAY
    notify = false, -- stop the spam
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- SECTION: Custom Modules

-- Perhaps there's a better place to put them? Check lazyvim docs
-- TODO: remove this if it causes problems
-- local pomo_popup = require("custom.pomo_popup").

-- TODO: test it, then move to keymaps
-- vim.keymap.set('n', '<leader>uta', ':lua require("custom.pomo_popup").start_timer()<CR>', 'Ensure Timers Running') -- Paste command mode
-- TODO: stop timers if it's too annoying
-- vim.keymap.set('<leader>uta', ':lua require("custom.pomo_popup").start_timer()<CR>', 'Ensure Timers Running') -- Paste command mode

-- END_SECTION: Custom Modules
