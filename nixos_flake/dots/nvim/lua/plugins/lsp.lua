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
        -- TODO: ledger plugin, move to ledger.lua
        "ledger",
      },

      -- SECTION: filetype mappings
      vim.filetype.add({
        -- pattern = {
        --   ["%.envrc"] = "sh",
        -- },
        filename = {
          [".envrc"] = "sh",
          [".journal"] = "ledger",
        },
      }),
      -- END_SECTION:
    },
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       -- configured in lazyextra
  --       -- bashls = { },
  --     },
  --   },
  -- },

  -- superset of yaml-companion
  -- {
  --   "cenk1cenk2/schema-companion.nvim",
  --   dependencies = {
  --     -- { "neovim/nvim-lspconfig.nvim" },
  --     { "nvim-lua/plenary.nvim" },
  --     { "nvim-telescope/telescope.nvim" },
  --   },
  --   -- config = function()
  --   --   require("schema-companion").setup({
  --   --     -- if you have telescope you can register the extension
  --   --     enable_telescope = true,
  --   --     matchers = {
  --   --       -- add your matchers
  --   --       require("schema-companion.matchers.kubernetes").setup({ version = "master" }),
  --   --     },
  --   --     schemas = {
  --   --       -- add your schemas
  --   --       {
  --   --         name = "Kubernetes master",
  --   --         uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json",
  --   --       },
  --   --     },
  --   --   })
  --   --
  --   --
  --   --   local cfg = require("yaml-companion").setup(opts)
  --   --   require("lspconfig")["yamlls"].setup(cfg)
  --   --   require("telescope").load_extension("yaml_schema")
  --   --
  --   -- end,
  --
  --   opts = {
  --     -- if you have telescope you can register the extension
  --     enable_telescope = true,
  --     matchers = {
  --       -- add your matchers
  --       -- TODO: uncomment
  --       -- require("schema-companion.matchers.kubernetes").setup({ version = "master" }),
  --     },
  --     schemas = {
  --       -- add your schemas
  --       {
  --         name = "Kubernetes master",
  --         uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json",
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     local cfg = require("schema-companion").setup(opts)
  --     require("lspconfig")["yamlls"].setup(cfg)
  --     require("telescope").load_extension("schema_companion")
  --   end,
  --   keys = {
  --     {
  --       "<leader>cy",
  --       function()
  --         require("telescope").extensions.schema_companion.select_schema()
  --       end,
  --       desc = "Select YAML Schema",
  --       ft = "yaml",
  --     },
  --   },
  -- },
  --

  -- TODO: compare this will strict yaml-companion, which seems to work more seemlessly
  -- FIXME: telescope selector is completely broken
  {
    "cenk1cenk2/schema-companion.nvim",
    dependencies = {
      -- { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("schema-companion").setup({
        enable_telescope = true,
        formatting = false,
        matchers = {
          -- add your matchers
          require("schema-companion.matchers.kubernetes").setup({ version = "master" }),
        },
        schemas = {},
      })
      require("lspconfig").yamlls.setup(require("schema-companion").setup_client({
        -- your yaml language server configuration
      }))
    end,
  },

  -- -- abandoned, but seems to still work
  -- {
  --   "someone-stole-my-name/yaml-companion.nvim",
  --   ft = { "yaml" },
  --   opts = {
  --     builtin_matchers = {
  --       kubernetes = { enabled = true },
  --     },
  --   },
  --   dependencies = {
  --     { "neovim/nvim-lspconfig" },
  --     { "nvim-lua/plenary.nvim" },
  --     { "nvim-telescope/telescope.nvim" },
  --   },
  --   config = function(_, opts)
  --     local cfg = require("yaml-companion").setup(opts)
  --     require("lspconfig")["yamlls"].setup(cfg)
  --     require("telescope").load_extension("yaml_schema")
  --   end,
  -- },

  -- k8s yaml crd schemas. messes up yaml-companion
  -- {
  --   -- :K8SSchemasGenerate - sync CRDs based on the current k8s context
  --   "anasinnyk/nvim-k8s-crd",
  --   -- event = { "BufEnter *.yaml" },
  --   dependencies = { "neovim/nvim-lspconfig" },
  --   config = function()
  --     -- To enable, run command:
  --     -- require("k8s-crd").setup({ cache_dir = vim.fn.expand("~/.cache/k8s-schemas/")}),
  --     require("k8s-crd").setup({
  --       cache_dir = vim.fn.expand("~/.cache/k8s-schemas/"),
  --       -- k8s = {
  --       --   file_mask = "*.yaml",
  --       -- },
  --     })
  --   end,
  -- },
}
return M
