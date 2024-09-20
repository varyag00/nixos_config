-- Import required modules
local pomo = require("pomo")
local noice = require("noice")

-- Define the module
local M = {}

M.timer = nil
M.delay_start_ms = 0
-- 5s
M.interval_ms = 5000
M.pomo_timers = nil

-- Make it public for troubleshooting
function M.check_timers()
  M.pomo_timers = pomo.get_all_timers()
  if #pomo_timers == 0 then
    noice.notify("󱎫 No timer is ongoing. Set one up!", "error")
  end
end

function M.start_check_timer()
  if not M.timer then
    M.timer = vim.uv.new_timer()
  end
  M.timer:start(M.delay_start_ms, M.interval_ms, vim.schedule_wrap(M.check_timers))
end

function M.stop_check_timer()
  M.timer:close()
  M.timer = nil
  -- FIXME: memory leak here; try garbage_collect()? see if lazyvim has a recommended way to do this
  -- collectgarbage("collect")
end

-- TODO: do something to tell me off when I'm on a break timer

return M
