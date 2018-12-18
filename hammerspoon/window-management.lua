local This = {}

local MAX = 12
local HALF = MAX / 2

local pressed = {
  left = false,
  down = false,
  up = false,
  right = false
}

hs.grid.setGrid(MAX .. 'x' .. MAX)
hs.grid.setMargins({5, 5})
hs.window.animationDuration = 0

function This.fw()
  return hs.window.focusedWindow()
end

function This.windowPosition(cell, window)
  if window == nil then
    window = hs.window.focusedWindow()
  end
  if window then
    local screen = window:screen()
    hs.grid.set(window, cell, screen)
  end
end

function This.windowMoveLeft(window)
  This.windowPosition({x = 0, y = 0, w = HALF, h = MAX}, window)
end

function This.windowMoveDown(window)
  This.windowPosition({x = 0, y = HALF, w = MAX, h = HALF}, window)
end

function This.windowMoveUp(window)
  This.windowPosition({x = 0, y = 0, w = MAX, h = HALF}, window)
end

function This.windowMoveRight(window)
  This.windowPosition({x = HALF, y = 0, w = HALF, h = MAX}, window)
end

function This.windowMoveTopLeft(window)
  This.windowPosition({x = 0, y = 0, w = HALF, h = HALF}, window)
end

function This.windowMoveTopRight(window)
  This.windowPosition({x = HALF, y = 0, w = HALF, h = HALF}, window)
end

function This.windowMoveBottomLeft(window)
  This.windowPosition({x = 0, y = HALF, w = HALF, h = HALF}, window)
end

function This.windowMoveBottomRight(window)
  This.windowPosition({x = HALF, y = HALF, w = HALF, h = HALF}, window)
end

function This.windowMoveToCenter(window)

   local newx = (window:screen():frame().w - window:size().w) / 2
   local newy = (window:screen():frame().h - window:size().h) / 2
   
   This.windowPosition({x = newx, y = newy, w = window:size().w, h = window:size().h })
end

function This.windowMaximize(factor, window)
   if window == nil then
      window = hs.window.focusedWindow()
   end
   if window then
      window:maximize()
   end
end

function This.applyLayouts(layouts)
  for _, layout in ipairs(layouts) do
    local apps = hs.application.applicationsForBundleID(layout.bundle)
    for _, app in ipairs(apps) do
      local wins = app:allWindows()
      for _, win in ipairs(wins) do
        layout.func(win)
      end
    end
  end
end

function This.leftPressed()
  pressed.left = true
  if pressed.down then
    This.windowMoveBottomLeft()
  elseif pressed.up then
    This.windowMoveTopLeft()
  else
    This.windowMoveLeft()
  end
end

function This.downPressed()
  pressed.down = true
  if pressed.left then
    This.windowMoveBottomLeft()
  elseif pressed.right then
    This.windowMoveBottomRight()
  else
    This.windowMoveDown()
  end
end

function This.upPressed()
  pressed.up = true
  if pressed.left then
    This.windowMoveTopLeft()
  elseif pressed.right then
    This.windowMoveTopRight()
  else
    This.windowMoveUp()
  end
end

function This.rightPressed()
  pressed.right = true
  if pressed.down then
    This.windowMoveBottomRight()
  elseif pressed.up then
    This.windowMoveTopRight()
  else
    This.windowMoveRight()
  end
end

function This.leftReleased()
  pressed.left = false
end

function This.downReleased()
  pressed.down = false
end

function This.upReleased()
  pressed.up = false
end

function This.rightReleased()
  pressed.right = false
end

return This

