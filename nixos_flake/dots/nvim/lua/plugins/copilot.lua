local M = {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      mappings = {
        reset = {
          -- override annoying default <C-l>
          normal = "gCC",
          insert = false,
        },
      },
    },
  },
  -- NOTE: replace blink-cmp-copilot with bliink-copilot for multiple suggestions
  {
    "giuxtaposition/blink-cmp-copilot",
    -- included by default by copilot.lua lazy extra
    enabled = false,
  },
  {
    "saghen/blink.cmp",
    dependencies = { "fang2hou/blink-copilot" },
    opts = {
      sources = {
        providers = {
          copilot = {
            module = "blink-copilot",
            opts = {
              max_completions = 3,
            },
          },
        },
      },
    },
  },
}
return M
