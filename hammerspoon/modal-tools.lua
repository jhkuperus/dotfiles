local This = {}

local convertEventTapFlagsToHotkeyFlags = function(modal)
   local modalBindings = {}

      for i,v in ipairs(modal.keys) do
      -- parse for flags, get keycode for each
      local kc, mods = tostring(v._hk):match("keycode: (%d+), mods: (0x[^ ]+)")
      local hkFlags = tonumber(mods)
      local hkOriginal = hkFlags
      local flags = 0
      if (hkFlags &  256) ==  256 then hkFlags, flags = hkFlags -  256, flags | hs.eventtap.event.rawFlagMasks.command   end
      if (hkFlags &  512) ==  512 then hkFlags, flags = hkFlags -  512, flags | hs.eventtap.event.rawFlagMasks.shift     end
      if (hkFlags & 2048) == 2048 then hkFlags, flags = hkFlags - 2048, flags | hs.eventtap.event.rawFlagMasks.alternate end
      if (hkFlags & 4096) == 4096 then hkFlags, flags = hkFlags - 4096, flags | hs.eventtap.event.rawFlagMasks.control   end
      if hkFlags ~= 0 then print("unexpected flag pattern detected for " .. tostring(v._hk)) end
      local tableKey = kc .. 'F' .. tostring(flags)
--      hs.printf("Keycode: %s, flags: %d, bindingKey: %s", kc, flags, tableKey)
      modalBindings[tableKey] = flags
   end

   return modalBindings
end

-- Utility function copied and adapted from https://github.com/asmagill/hammerspoon-config/blob/master/_scratch/modalSuppression.lua
This.suppressUnboundModalKeys = function(modal, optionalCatchAllCallback)
   local passThroughKeys = convertEventTapFlagsToHotkeyFlags(modal)
   -- Dirty hack to allow Hyper-status changes to go through (needs to be a parameter to this function)
   passThroughKeys[hs.keycodes.map['f18'] .. 'F0'] = 0
   passThroughKeys[hs.keycodes.map['f17'] .. 'F0'] = 0

   return hs.eventtap.new({
	 hs.eventtap.event.types.keyDown,
	 hs.eventtap.event.types.keyUp
		       }, function(event)

	 -- check only the flags we care about and filter the rest
	 local flags = event:getRawEventData().CGEventData.flags  & (
	    hs.eventtap.event.rawFlagMasks.command   |
	    hs.eventtap.event.rawFlagMasks.control   |
	    hs.eventtap.event.rawFlagMasks.alternate |
	    hs.eventtap.event.rawFlagMasks.shift
								    )
	 local tableKey = tostring(event:getKeyCode()) .. 'F' .. tostring(flags)
--	 hs.printf("Looking for bindingKey: %s", tableKey)
	 if passThroughKeys[tableKey] == flags then
	    return false -- pass it through so hotkey can catch it
	 else
	    if optionalCatchAllCallback ~= nil then
	       optionalCatchAllCallback(event)
	    end
	    
	    return true -- delete it if we got this far -- it's a key that we want suppressed
	 end
   end)
end


return This
