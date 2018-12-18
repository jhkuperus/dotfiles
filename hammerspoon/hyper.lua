local This = {}

-- Global Variable for Hyper Mode
-- Note: This actually programs Hyper Mode to the usage of F17 rather than F18. The F18 key is later used
-- to be able to switch Hyper mode on and off. At first I thought this was a typo from the original example,
-- but turning this into F18 causes the Hyper Mode to be extremely jittery (i.e. it gets turned on and off almost
-- immediately at every keypress)
This.hyperMode = hs.hotkey.modal.new({}, 'F17')
function This.bindKey(key, handler)
   This.hyperMode:bind({}, key, function()
	 handler()
	 This.hyperMode.triggered = true
   end)
end

function This.bindShiftKey(key, handler)
   This.hyperMode:bind({'shift'}, key, function()
	 handler()
	 This.hyperMode.triggered = true
   end)
end

function This.bindKeyWithModifiers(key, mods, handler)
   This.hyperMode:bind(mods, key, function()
	 handler()
	 This.hyperMode.triggered = true
   end)
end

-- Enter Hyper Mode when F18 (Hyper) is pressed
function enterHyperMode()
   This.hyperMode.triggered = false
   This.hyperMode:enter()
end

-- Leave Hyper Mode when F18 (Hyper) is pressed
function exitHyperMode()
   This.hyperMode:exit()
end

function This.install(hotKey)
  hs.hotkey.bind({}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"ctrl"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"ctrl", "shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"cmd"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"cmd", "shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"cmd", "ctrl"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"cmd", "ctrl", "shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "ctrl"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "ctrl", "shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "cmd"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "cmd", "shift"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "cmd", "ctrl"}, hotKey, enterHyperMode, exitHyperMode)
  hs.hotkey.bind({"alt", "cmd", "shift", "ctrl"}, hotKey, enterHyperMode, exitHyperMode)
end


return This
