local This = {}


This.menuBar = hs.menubar.new()

function setCaffeineDisplay(state)
   if state then
      This.menuBar:setIcon(os.getenv("HOME") .. "/.hammerspoon-assets/caffeine/active.png")
   else
      This.menuBar:setIcon(os.getenv("HOME") .. "/.hammerspoon-assets/caffeine/inactive.png")
   end
end

function caffeineClicked()
   setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

function This.set(state)
   setCaffeineDisplay(hs.caffeinate.set('displayIdle', state))
end

function This.toggle()
   setCaffeineDisplay(hs.caffeinate.toggle('displayIdle'))
end

function This.install()
   if This.menuBar then
    This.menuBar:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
   end
end


return This
