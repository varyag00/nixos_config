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
  {
    "cenk1cenk2/schema-companion.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    keys = {
      -- FIXME: this doesn't work; the telescope prompt pops up and eventually allows selection (run it twice), but schema isn't actually set
      -- | WORKAROUND: use custom/additional-schemas.lua (<leader>cy) to set the schema via comment
      -- {
      --   -- map("n", "<leader>kz", "<cmd>lua require('telescope').extensions.schema_companion.select_from_matching_schemas()<CR>", { desc = "TEST" })
      --   "<leader>cY",
      --   function()
      --     require("telescope").extensions.schema_companion.select_from_matching_schemas()
      --   end,
      --   desc = "SchemaCompanion: Select YAML Schema",
      --   ft = "yaml",
      -- },
    },
    config = function()
      require("schema-companion").setup({
        enable_telescope = true,
        formatting = false,
        matchers = {
          -- add your matchers
          require("schema-companion.matchers.kubernetes").setup({ version = "master" }),
        },
        schemas = {
          {
            name = "Kubernetes master",
            uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json",
          },
          -- TODO: if github actions LSP fails, check this: https://github.com/SchemaStore/schemastore/blob/master/src/schemas/json/github-action.json
        },
      })
      -- breaks things...
      -- require("lspconfig").yamlls.setup(require("schema-companion").setup_client({
      --   -- your yaml language server configuration
      -- }))
      require("lspconfig").yamlls.setup(require("schema-companion").setup_client({
        filetypes = {
          "yaml",
          "!yaml.ansible",
          "!yaml.docker-compose",
        },
        settings = {
          flags = {
            debounce_text_changes = 50,
          },
          redhat = { telemetry = { enabled = false } },
          yaml = {
            hover = true,
            completion = true,
            validate = true,
            format = { enable = false },
            schemaStore = { enable = true, url = "https://www.schemastore.org/api/json/catalog.json" },
            schemaDownload = { enable = true },
            schemas = {
              kubernetes = {
                "templates/*!(.gitlab-ci).{yml,yaml}",
                "workloads/**/*!(kustomization).{yml,yaml}",
                "*.k8s.{yml,yaml}",
                "daemon.{yml,yaml}",
                "manager.{yml,yaml}",
                "restapi.{yml,yaml}",
                "*namespace*.{yml,yaml}",
                "role.{yml,yaml}",
                "role-binding.{yml,yaml}",
                "*onfigma*.{yml,yaml}",
                "*ingress*.{yml,yaml}",
                "*secret*.{yml,yaml}",
                "*deployment*.{yml,yaml}",
                "*service*.{yml,yaml}",
                "kubectl-edit*.yaml",
              },
              ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = {
                "*argocd*.{yml,yaml}",
              },
              ["http://json.schemastore.org/chart"] = { "Chart.{yml,yaml}" },
              ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
                ".gitlab-ci.yml",
              },
              ["https://json.schemastore.org/drone.json"] = { ".drone.yml" },
              ["https://raw.githubusercontent.com/ansible-community/schemas/main/f/ansible-playbook.json"] = {
                "deploy.yml",
                "provision.yml",
              },
              ["https://bitbucket.org/atlassianlabs/atlascode/raw/main/resources/schemas/pipelines-schema.json"] = {
                "bitbucket-pipelines.yml",
              },
              ["https://taskfile.dev/schema.json"] = {
                "Taskfile*.{yml,yaml}",
              },
              ["https://json.schemastore.org/pulumi.json"] = {
                "Pulumi.{yml,yaml}",
              },
              ["https://raw.githubusercontent.com/cenk1cenk2/docker-vizier/main/schema.json"] = {
                "vizier.{yml,yaml}",
              },
            },
          },
        },
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
