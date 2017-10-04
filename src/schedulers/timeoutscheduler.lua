local Subscription = require 'subscription'

--- @class TimeoutScheduler
-- @description A scheduler that uses luvit's timer library to schedule events on an event loop.
local TimeoutScheduler = {}
TimeoutScheduler.__index = TimeoutScheduler
TimeoutScheduler.__tostring = util.constant('TimeoutScheduler')

--- Creates a new TimeoutScheduler.
-- @returns {TimeoutScheduler}
function TimeoutScheduler.create()
  return setmetatable({}, TimeoutScheduler)
end

--- Schedules an action to run at a future point in time.
-- @arg {function} action - The action to run.
-- @arg {number=0} delay - The delay, in milliseconds.
-- @returns {Subscription}
function TimeoutScheduler:schedule(action, delay, ...)
  local cancelled = false
  delay = delay or 0
  C_Timer.After(delay / 1000, function()
    if cancelled then
      return
    end
    action(...)
  end)
  return Subscription.create(function()
    cancelled = true
  end)
end

return TimeoutScheduler
