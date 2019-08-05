local modalUtils = require('modal-tools')

local This = {}

-- Global Variable for Emoji Mode
This.emojiMode = hs.hotkey.modal.new({}, 'F16')

--local screenRect = hs.screen.mainScreen():frame()
local screenRect = hs.screen.primaryScreen():frame()
local keyGutter = 15
local kbdWidth = screenRect.w - (200 + 20)
local singleKeySize = math.floor((kbdWidth - (15 * keyGutter)) / 14.5)
local kbdHeight = (5 * singleKeySize) + (6 * keyGutter)

local keyRows = {
   {
      { s = 1, k = "§" },
      { s = 1, k = "1" },
      { s = 1, k = "2" },
      { s = 1, k = "3" },
      { s = 1, k = "4" },
      { s = 1, k = "5" },
      { s = 1, k = "6" },
      { s = 1, k = "7" },
      { s = 1, k = "8" },
      { s = 1, k = "9" },
      { s = 1, k = "0" },
      { s = 1, k = "-" },
      { s = 1, k = "=" },
      { s = 1.5, k = "backspace" }
   },
   {
      { s = 1.5, k = "tab" },
      { s = 1, k = "q" },
      { s = 1, k = "w" },
      { s = 1, k = "e" },
      { s = 1, k = "r" },
      { s = 1, k = "t" },
      { s = 1, k = "y" },
      { s = 1, k = "u" },
      { s = 1, k = "i" },
      { s = 1, k = "o" },
      { s = 1, k = "p" },
      { s = 1, k = "[" },
      { s = 1, k = "]" }
   },
   {
      { s = 1.8, k = "capslock" },
      { s = 1, k = "a" },
      { s = 1, k = "s" },
      { s = 1, k = "d" },
      { s = 1, k = "f" },
      { s = 1, k = "g" },
      { s = 1, k = "h" },
      { s = 1, k = "j" },
      { s = 1, k = "k" },
      { s = 1, k = "l" },
      { s = 1, k = ";" },
      { s = 1, k = "'" },
      { s = 1, k = "\\" }
   },
   {
      { s = 1.2, k = "leftshift" },
      { s = 1, k = "`" },
      { s = 1, k = "z" },
      { s = 1, k = "x" },
      { s = 1, k = "c" },
      { s = 1, k = "v" },
      { s = 1, k = "b" },
      { s = 1, k = "n" },
      { s = 1, k = "m" },
      { s = 1, k = "," },
      { s = 1, k = "." },
      { s = 1, k = "/" },
      { s = 2.5, k = "rightshift" }
   },
   {
      { s = 1, k = "fn" },
      { s = 1, k = "leftcontrol" },
      { s = 1, k = "leftalt" },
      { s = 1.2, k = "leftcmd" },
      { s = 5.8, k = "space" },
      { s = 1.2, k = "rightcmd" },
      { s = 1, k = "rightalt" },
      { s = 1, k = "left" },
      { s = 1, k = "up", h = 0.4, noYMove = true },
      { s = 1, k = "down", h = 0.4, d = 0.4 },
      { s = 1, k = "right" }
   }   
}

This.mappings = {}

function iffy(cond, a, b)
   if cond then
      return a
   else
      return b
   end
end

function This.initKbd()
        local canvasCoords = hs.screen.mainScreen():localToAbsolute({ x = 110, y = math.floor((screenRect.h - kbdHeight) / 2), h = kbdHeight, w = kbdWidth })
        print(canvasCoords)
   --This.onScreenKbd = hs.canvas.new{ hs.screen.mainScreen():localToAbsolute({ x = 110, y = math.floor((screenRect.h - kbdHeight) / 2), h = kbdHeight, w = kbdWidth })}
   This.onScreenKbd = hs.canvas.new{ x = 110, y = math.floor((screenRect.h - kbdHeight) / 2), h = kbdHeight, w = kbdWidth }
   This.onScreenKbd:insertElement({
	 type = "rectangle",
	 roundedRectRadii = { xRadius = 7, yRadius = 7 },
	 canvasAlpha = 0.8,
	 fillColor = { black = 0.8, alpha = 0.5 },
	 strokeColor = { white = 1 },
	 strokeWidth = 4.0
   })

   for rowid, row in pairs(keyRows) do
      local keyOffset = keyGutter
      for keyid, key in pairs(row) do
	 local keyWidth = (singleKeySize * key.s)
	 local keyX = keyOffset

	 if key.l then
	    keyX = keyX - (key.l * (keyGutter + keyWidth))
	 end

	 local keyH = singleKeySize
	 if key.h then
	    keyH = key.h * singleKeySize
	 end

	 local keyY = (rowid * keyGutter) + ((rowid - 1) * singleKeySize)
	 if key.d then
	    keyY = keyY + (key.d * singleKeySize) + keyGutter
	 end
	 
	 local localFrame = { x = keyX, y = keyY, w = keyWidth, h = keyH }
	 This.onScreenKbd:insertElement({
	       type = "rectangle",
	       id = "key" .. key.k,
	       action = "strokeAndFill",
	       frame = localFrame,
	       strokeColor = { white = 1 },
	       strokeWidth = 2.0,
	       fillColor = { black = 1 }
	 })
	 if This.mappings[key.k] then
	    This.onScreenKbd:insertElement({
		  type = "text",
		  frame = localFrame,
		  text = This.mappings[key.k] .. "\n" .. key.k,
		  textSize = 32.0,
		  textAlignment = "center"
	    })
	 end

	 if key.noYMove then
	    keyOffset = keyOffset
	 else
	    keyOffset = keyOffset + keyGutter + keyWidth
	 end
      end
   end
end

function This:bindEmoji(key, emoji)
   self.mappings[key] = emoji
   self.emojiMode:bind({}, key, function()
	 This.emojiMode:exit()
	 hs.eventtap.keyStrokes(emoji)
   end)
   self.initKbd()
   return self
end

function This:bindShiftEmoji(key, emoji)
   self.emojiMode:bind({'shift'}, key, function()
	 This.emojiMode:exit()
	 hs.eventtap.keyStrokes(emoji)
   end)
   return self
end

This.emojiMode.entered = function(self)
   This.eventCapture = modalUtils.suppressUnboundModalKeys(This.emojiMode):start()
end

This.emojiMode.exited = function(self)
   This.onScreenKbd:hide()
   This.eventCapture:stop()
   This.eventCapture = nil
end

-- Enter Emoji Mode when F16 (Emoji) is pressed
function This.enterEmojiMode()
    This.onScreenKbd:show()
   This.emojiMode:enter()
end

-- Register ESCAPE to allow closing of the Emoji Mode
This.emojiMode:bind({}, 'escape', function()
      This.emojiMode:exit()
end)

This:bindEmoji('§', '😀')
    :bindEmoji('1', '😃')
    :bindEmoji('2', '😄')
    :bindEmoji('3', '😁')
    :bindEmoji('4', '😆')
    :bindEmoji('5', '😅')
    :bindEmoji('6', '😂')
    :bindEmoji('7', '🤣')
    :bindEmoji('8', '☺️')
    :bindEmoji('9', '😊')
    :bindEmoji('0', '😇')
    :bindEmoji('-', '🙂')
    :bindEmoji('=', '🙃')
    :bindEmoji('delete', '😉')
    :bindEmoji('tab', '😌')
    :bindEmoji('q', '😍')
    :bindEmoji('w', '😘')
    :bindEmoji('e', '😋')
    :bindEmoji('r', '😛')
    :bindEmoji('t', '😝')
    :bindEmoji('y', '😜')
    :bindEmoji('u', '🤪')
    :bindEmoji('i', '🤨')
    :bindEmoji('o', '🤓')
    :bindEmoji('p', '😎')
    :bindEmoji('[', '😞')
    :bindEmoji(']', '😫')
    :bindEmoji('a', '😭')
    :bindEmoji('s', '😰')
    :bindEmoji('d', '😱')
    :bindEmoji('f', '😡')
    :bindEmoji('g', '🤢')
    :bindEmoji('h', '🤮')
    :bindEmoji('j', '😴')
    :bindEmoji('k', '😄')
    :bindEmoji('l', '😄')
    :bindEmoji(';', '😄')
    :bindEmoji('\'', '😄')
    :bindEmoji('\\', '😄')
    :bindEmoji('return', '😄')
    :bindEmoji('`', '✅')
    :bindEmoji('z', '❗')
    :bindEmoji('x', '❓')
    :bindEmoji('c', '⏱')
    :bindEmoji('v', '❄')
    :bindEmoji('b', '⚡️')
    :bindEmoji('n', '🧹')
    :bindEmoji('m', '⚙')
    :bindEmoji(',', '✍️')
    :bindEmoji('.', '🛠')
    :bindEmoji('/', '😄')
    :bindEmoji('space', '🚦')
    :bindEmoji('up', '⬆️')
    :bindEmoji('right', '➡️')
    :bindEmoji('down', '⬇️')
    :bindEmoji('left', '⬅️')


return This
