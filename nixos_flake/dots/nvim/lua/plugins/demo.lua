-- NOTE: Collection of plugins that are useful when presenting a demo

-- enable/disable
if true then
  return {}
end

local M = {
  -- [screenkey](https://www.thregr.org/wavexx/software/screen), but within nvim
  {
    "NStefan002/screenkey.nvim",
    lazy = false,
    version = "*", -- or branch = "dev", to use the latest commit
  },
}
return M
