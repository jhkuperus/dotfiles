-- ------------------------------------------------------------------------------------
-- 🔨🥄 Configuration file for Kramor
-- ------------------------------------------------------------------------------------

local am = require('app-management')
local wm = require('window-management')
local hyper = require('hyper')
local emoji = require('emoji')
local caf = require('caffeine')

hyper.install('F18')
caf.install()
hyper.bindKey('e', function()
		 emoji.enterEmojiMode()
end)

local composeAirmail = function()
   hs.osascript.applescript([[tell application "Airmail 3"
  set newMail to make new outgoing message
  activate
  compose newMail
end tell]])
   local tl = hs.window.frontmostWindow():topLeft()

   local nP = {}
   nP.x = tl.x + 100
   nP.y = tl.y + 75
   print(nP.x)
   print(nP.y)
   hs.timer.doAfter(2, function() hs.eventtap.leftClick(np) end)
end

local minimizeAllWindows = function()
   for i,w in pairs(hs.window.allWindows()) do
	     w:minimize()
   end
end

local minimizeAllButFocussedWindow = function()
   local focusWindow = hs.window.focusedWindow()

   for i,w in pairs(hs.window.allWindows()) do
      if w ~= focusWindow then
	        w:minimize()
      end
   end

   hs.alert.show('📽')
end

-- Quick Reloading of Hammerspoon
hyper.bindKey('r', hs.reload)

-- Global Application Keyboard Shortcuts
hyper.bindKey('m', function() am.switchToAndFromApp("com.postbox-inc.postbox") end)
hyper.bindShiftKey('m', function()
		      print(pcall(composeAirmail))
end)
hyper.bindKey('p', function() am.switchToAndFromApp("com.spotify.client") end)
hyper.bindShiftKey('p', function() hs.spotify.displayCurrentTrack() end)
hyper.bindKey(']', function() am.switchToAndFromApp("com.googlecode.iterm2") end)
hyper.bindKey('[', function() am.switchToAndFromApp("com.apple.ActivityMonitor") end)
hyper.bindKey(';', function() am.switchToAndFromApp("com.google.Chrome") end)
hyper.bindShiftKey('\\', function() am.switchToAndFromApp("chat.rocket") end)
hyper.bindKey('l', function() am.switchToAndFromApp("com.jetbrains.intellij") end)
hyper.bindKey('k', function() am.switchToAndFromApp("com.apple.keychainaccess") end)
hyper.bindKey('\'', function() am.switchToAndFromApp("com.apple.Notes") end)
hyper.bindKey('/', function() am.switchToAndFromApp("com.apple.iCal") end)
hyper.bindKey('.', function() am.switchToAndFromApp("com.apple.finder") end)
hyper.bindKey(',', function() am.switchToAndFromApp("net.cozic.joplin-desktop") end)
hyper.bindKey('`', function() print(pcall(minimizeAllButFocussedWindow)) end)
hyper.bindKey('1', function() am.switchToAndFromApp("WhatsApp") end)
hyper.bindKey('2', function() am.switchToAndFromApp("com.tinyspeck.slackmacgap") end)
hyper.bindKey('\\', function() am.switchToAndFromApp("com.tinyspeck.slackmacgap") end)

-- Create new Terminal Window
hyper.bindShiftKey('space', function() am.newTerminalWindow() end)

-- Show the bundleID of the currently open window
hyper.bindKey('b', function() 
    local bundleId = hs.window.focusedWindow():application():bundleID()
    hs.alert.show(bundleId)
    hs.pasteboard.setContents(bundleId)
end)

-- Window Management
hyper.bindKey("up", function() wm.windowMaximize(0) end)
hyper.bindKey("right", function() wm.moveWindowToPosition(wm.screenPositions.right) end)
hyper.bindKey("down", function() hs.window.focusedWindow():moveOneScreenEast() end)
hyper.bindShiftKey("down", function() hs.window.focusedWindow():moveOneScreenWest() end)
hyper.bindKey("left", function() wm.moveWindowToPosition(wm.screenPositions.left) end)

hyper.bindShiftKey("1", function() wm.moveWindowToPosition(wm.screenPositions.topLeft) end)
hyper.bindShiftKey("2", function() wm.moveWindowToPosition(wm.screenPositions.topRight) end)
hyper.bindShiftKey("3", function() wm.moveWindowToPosition(wm.screenPositions.bottomLeft) end)
hyper.bindShiftKey("4", function() wm.moveWindowToPosition(wm.screenPositions.bottomRight) end)
hyper.bindShiftKey("5", function() wm.moveWindowToPosition(wm.screenPositions.top) end)
hyper.bindShiftKey("6", function() wm.moveWindowToPosition(wm.screenPositions.bottom) end)

-- Date Handy Dandyness
hyper.bindKey("t", function()
  local time = os.date("%A, %d %B %Y, %H:%M")
  hs.alert.show(time)
  hs.pasteboard.setContents(time)
end)

hyper.bindShiftKey("t", function()
  local time = os.date("%Y%m%d")
  hs.alert.show(time)
  hs.pasteboard.setContents(time)
end)

hyper.bindCommandShiftKey("t", function()
  local time = os.date("%Y-%m-%d")
  hs.alert.show(time)
  hs.pasteboard.setContents(time)
end)


local soundBoard = {
  badumtiss =       { key = '1', file = 'joke_drum_effect.mp3' },
  metalgearsolid =  { key = '2', file = 'metalgearsolid.swf.mp3' },
  winError =        { key = '3', file = 'erro.mp3' },
  sadtrombone =     { key = '4', file = 'sadtrombone.swf.mp3' },
  crickets =        { key = '5', file = 'crickets-chirping.mp3' },
  batman =          { key = '6', file = 'batman-transition-download-sound-link.mp3' },
  shocked =         { key = '7', file = 'shocked.mp3' },
  inception =       { key = '8', file = 'inceptionbutton.mp3' },
  haGay =           { key = '9', file = 'ha-gay.mp3' },
  workwork =        { key = '0', file = 'wc3-peon-says-work-work-only-.mp3' },
  workComplete =    { key = '-', file = 'warcraft-ii-sound-effects-orc-peon-grunt_-_work-complete.mp3' },
  ns =              { key = '=', file = 'ns-ding-dong.mp3' },
  
  airhorn =         { key = 'q', file = 'air-horn-club-sample_1.mp3' },
  nooo =            { key = 'w', file = 'nooo.swf.mp3' },
  victoryff =       { key = 'e', file = 'victoryff.swf.mp3' },
  laughterShort =   { key = 'r', file = 'laughter-short.mp3' },
  kidsCheering =    { key = 't', file = 'kids_cheering.mp3' },
  retardAlert =     { key = 'y', file = 'retard-alert.mp3' },
  zoidberg =        { key = 'u', file = 'zoidberg.mp3' },
  thunderbirds =    { key = 'i', file = 'thunderbirds-countdown.mp3' },
  mk =              { key = 'o', file = 'mk.mp3' },
  over9000 =        { key = 'p', file = 'over9000.swf.mp3' },
  sound9 =          { key = '[', file = 'sound-9.mp3' },
  it =              { key = ']', file = 'it.mp3' },
  
  sheep =           { key = 'a', file = '01-the-screaming-sheep.mp3' },
  woohoo =          { key = 's', file = 'homersimpsonwoohoow-1.mp3', volume = 1.0 },
  doh =             { key = 'd', file = 'homer-d-oh.mp3' },
  homeEvilLaugh =   { key = 'f', file = 'homer-simpson-evil-laugh-from-youtube.mp3' },
  haha =            { key = 'g', file = 'the-simpsons-nelsons-haha.mp3' },
  psbAlarm =        { key = 'h', file = 'psb-alarm.mp3', volume = 0.4 },
  kaChing =         { key = 'j', file = 'ka-ching.mp3' },
  woodyWoodpecker = { key = 'k', file = 'woody-woodpecker-laugh.mp3' },
  woopWoop =        { key = 'l', file = 'sound-of-da-police-krs-one.mp3' },
  wtfBoom =         { key = ';', file = 'wtf_boom.mp3' },
  dropTheBass =     { key = '\'', file = 'd-d-d-d-drop-the-bass.mp3' },
  leroy =           { key = '\\', file = 'leroy.swf.mp3' },
  
  elevator =        { key = '`', file = 'musique-dascenseur-mp3cut.mp3' },
  cupASoup =        { key = 'z', file = 'cup-a-soup-reclame-sjors-ruben-van-der-meer-mp3cut.mp3' },
  looneyTunes =     { key = 'x', file = 'looney-tunes.mp3' },
  christmas1 =      { key = 'c', file = 'christmas_driving.m4a' },
  --homeEvilLaugh =   { key = 'c', file = 'homer-simpson-evil-laugh-from-youtube.mp3' },
  mariachi =        { key = 'v', file = 'mariachi_1.mp3' },
  cantTouchThis =   { key = 'b', file = 'mc-hammer-u-cant-touch-this.mp3' },
  nope =            { key = 'n', file = 'nope.mp3' },
  
  hallelujah =      { key = '/', file = 'holygrenade.mp3' }
     
}

-- Initialise Soundboard!
for n,s in pairs(soundBoard) do
  s.sound = hs.sound.getByFile(os.getenv("HOME") .. '/.hammerspoon-assets/soundboard/' .. s.file)

  hyper.bindKeyWithModifiers(s.key, {'cmd'}, function()
    s.sound:stop()
    s.sound:play()
  end)
end

local parseMinimizeRequest = function(data, addr)
  addr = hs.socket.parseAddress(addr)
  print(data)

  if data == 'min' then
    minimizeAllWindows()
  end
end

local server = hs.socket.udp.server(10901, parseMinimizeRequest):receive()

local alertRememberOnUnlock = function(eventType)

  if eventType == hs.caffeinate.watcher.screensDidUnlock then
    local f = io.open('/Users/kramor/.remember', 'r')
    if f ~= nil then
      local content = f:read('*all'):gsub("^%s*(.-)%s*$", "%1")
      hs.alert.show('Remember: ' .. content)
    end
  end
end

hs.caffeinate.watcher.new(alertRememberOnUnlock):start()

hs.alert.show('🔨🥄✅')
		 
