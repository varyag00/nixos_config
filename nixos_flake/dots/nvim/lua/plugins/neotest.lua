local M = {
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-golang"] = {
          runner = "gotestsum",
          -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
          -- dap_go_enabled = true,
        },
      },
    },
  },
}

return M
