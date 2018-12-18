-- AppManagement originally by jqno

local This = {}

-- Quickly move to and from a specific app
-- (Thanks Teije)
local previousApp = ""
function This.switchToAndFromApp(bundleID)
  local focusedWindow = hs.window.focusedWindow()

  if focusedWindow == nil then
    This.focusApp(bundleID)
  elseif focusedWindow:application():bundleID() == bundleID then
    if previousApp == nil then
      hs.window.switcher.nextWindow()
    else
      previousApp:activate()
    end
  else
    previousApp = focusedWindow:application()
    This.focusApp(bundleID)
  end
end

function This.focusApp(bundleID)
  hs.application.launchOrFocusByBundleID(bundleID)
  if hs.window.focusedWindow() == nil then
    if bundleID == "com.googlecode.iterm2" then
      hs.applescript.applescript([[
        tell application "iTerm"
          activate
        end tell
      ]])
    end
  end
end

-- Open new windows

function This.newTerminalWindow()
  hs.applescript.applescript([[
    tell application "Terminal"
      do script ""
      activate
    end tell
  ]])
end

return This

