local M = {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },

              validate = false,
              schemas = {
                -- -- NOTE: using .yaml causes issues, so we configure k8s manifests to end in .k8s.yaml or use schema
                -- -- # yaml-language-server: $schema=<urlToTheSchema|relativeFilePath|absoluteFilePath}>
                --
                -- NOTE: treat everything as k8s unless specified otherwise
                kubernetes = "*.k8s.{yml,yaml}",
                -- kubernetes = "*.k8s.yaml",
                -- kubernetes = "k8s/*.yaml",

                ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
                ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
                ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
                ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
                ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
                ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
              },
            },
          },
        },
      },
    },
  },
  -- {
  --   "anasinnyk/nvim-k8s-crd",
  --   event = { "BufEnter *.yaml" },
  --   dependencies = { "neovim/nvim-lspconfig" },
  --   opts = {
  --     cache_dir = "~/.cache/k8s-schemas/",
  --     k8s = {
  --       file_mask = "*.yaml",
  --     },
  --   },
  -- },
}
return M
