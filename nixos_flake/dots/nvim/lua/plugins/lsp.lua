-- NOTE: extra languages and lsp/tresitter grammars not included in lazyextras
-- for extending filetypes (see full settings):
-- https://www.lazyvim.org/extras/util/dot#nvim-treesitter
local M = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- kdl config lang for zellij
        "kdl",
        "latex",
      },

      -- SECTION: filetype mappings
      vim.filetype.add({
        -- pattern = {
        --   ["%.envrc"] = "sh",
        -- },
        filename = {
          [".envrc"] = "sh",
        },
      }),
      -- END_SECTION:
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- configured in lazyextra
        -- bashls = { },
      },
    },
  },
}
return M
