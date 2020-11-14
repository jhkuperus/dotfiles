local eventtap  = require("hs.eventtap")
local timer     = require("hs.timer")

local events    = eventtap.event.types

local module    = {}

-- Adapted from https://gist.github.com/asmagill/c38f75fff9d9ef43d1226329fc1436e4

-- What is the maximum number of seconds over which the double-press will be considered a double press
module.timeFrame = 1

-- Change what this function does to change the behavior under double shift (can be overridden when including this module)
module.action = function()
  -- On double-tap of shift, we are sending CMD-Space to the OS to activate Spotlight (or whatever is on that shortcut)
  hs.eventtap.keyStroke({"cmd"}, "space")
end

local timeFirstPress, firstDown, secondDown = 0, false, false

-- Function to check if the event is "clear" event where no modifier is pressed
local noFlags = function(ev)
  local result = true
  for k, v in pairs(ev:getFlags()) do
    if v then
      result = false
      break
    end
  end
  return result
end

-- Function to check if the event is a shift-press only (no other modifiers down)
local onlyShift = function(ev)
  local result = ev:getFlags().shift
  for k,v in pairs(ev:getFlags()) do
    if k~="shift" and v then
      result = false
      break
    end
  end
  return result
end

-- The function actually watching events and keeping track of the shift presses
module.eventWatcher = eventtap.new({events.flagsChanged, events.keyDown}, function(ev)
  if (timer.secondsSinceEpoch() - timeFirstPress) > module.timeFrame then
    timeFirstPress, firstDown, secondDown = 0, false, false
  end

  if ev:getType() == events.flagsChanged then
    if noFlags(ev) and firstDown and secondDown then -- shift up and we've seen two, do action
      if module.action then module.action() end
      timeFirstPress, firstDown, secondDown = 0, false, false
    elseif onlyShift(ev) and not firstDown then -- first shift down, start timer
      firstDown = true
      timeFirstPress = timer.secondsSinceEpoch()
    elseif onlyShift(ev) and firstDown then -- second shift down
      secondDown = true
    elseif not noFlags(ev) then -- some other key was pressed in between, cancel timer
      timeFirstPress, firstDown, secondDown = 0, false, false
    end
  else -- some other key (other than modifiers) was pressed, cancel timer
    timeFirstPress, firstDown, secondDown = 0, false, false
  end
  return false
end):start()

return module
