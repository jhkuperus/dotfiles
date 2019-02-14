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
hyper.bindKey('m', function() am.switchToAndFromApp("it.bloop.airmail2") end)
hyper.bindShiftKey('m', function()
		      print(pcall(composeAirmail))
end)
hyper.bindKey('p', function() am.switchToAndFromApp("com.spotify.client") end)
hyper.bindShiftKey('p', function() hs.spotify.displayCurrentTrack() end)
hyper.bindKey(']', function() am.switchToAndFromApp("com.googlecode.iterm2") end)
hyper.bindKey('[', function() am.switchToAndFromApp("com.apple.ActivityMonitor") end)
hyper.bindKey(';', function() am.switchToAndFromApp("com.google.Chrome") end)
hyper.bindKey('\\', function() am.switchToAndFromApp("com.grupovrs.ramboxce") end)
hyper.bindKey('k', function() am.switchToAndFromApp("com.apple.keychainaccess") end)
hyper.bindKey('\'', function() am.switchToAndFromApp("com.apple.Notes") end)
hyper.bindKey('/', function() am.switchToAndFromApp("com.apple.iCal") end)
hyper.bindKey('.', function() am.switchToAndFromApp("com.apple.finder") end)
hyper.bindKey('`', function() print(pcall(minimizeAllButFocussedWindow)) end)

-- Create new Terminal Window
hyper.bindShiftKey('space', function() am.newTerminalWindow() end)

-- Show the bundleID of the currently open window
hyper.bindKey('b', function() hs.alert.show(hs.window.focusedWindow():application():bundleID()) end)

-- Window Management
hyper.bindKey("up", function() wm.windowMaximize(0) end)
hyper.bindKey("right", function() wm.windowMoveRight() end)
hyper.bindKey("down", function() wm.fw():moveOneScreenEast() end)
hyper.bindShiftKey("down", function() wm.fw():moveOneScreenWest() end)
hyper.bindKey("left", function() wm.windowMoveLeft() end)

hyper.bindKey("1", function() wm.windowMoveTopLeft() end)
hyper.bindKey("2", function() wm.windowMoveTopRight() end)
hyper.bindKey("3", function() wm.windowMoveBottomRight() end)
hyper.bindKey("4", function() wm.windowMoveBottomLeft() end)
hyper.bindKey("5", function() wm.windowMoveUp() end)
hyper.bindKey("6", function() wm.windowMoveDown() end)
hyper.bindKey("7", function() print(pcall(function() wm.windowMoveToCenter(hs.window.focusedWindow()) end)) end)

-- Handy Dandyness
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

hallelujah =      { key = '/', file = 'holygrenade.mp3' }
   
}

-- Soundboard!
for n,s in pairs(soundBoard) do
   print(pcall(function()
	       s.sound = hs.sound.getByFile(os.getenv("HOME") .. '/.hammerspoon-assets/soundboard/' .. s.file)

	       if s.volume then
		  s.sound:volume(s.volume)
	       end
   end))
   
   print(pcall(function() hyper.bindKeyWithModifiers(s.key, {'cmd'}, function()
				 s.sound:stop()
				 s.sound:play()
						    end)
   end))

end



hs.alert.show('🔨🥄✅')
		 