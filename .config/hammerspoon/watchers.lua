--- automatically reload config
function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
      if file:sub(-4) == ".lua" then
          doReload = true
      end
  end
  if doReload then
      hs.reload()
  end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.config/hammerspoon/", reloadConfig):start()
hs.alert("Config tasty, Hammerspoon happy!")

--- watch applications
function applicationWatcher(appName, eventType, appObject)
  if (eventType == hs.application.watcher.activated) then
      if (appName == "Finder" or appName == "TextEdit") then
          -- Bring all windows forward when one gets activated
          appObject:selectMenuItem({"Window", "Bring All to Front"})
      end
  end
end
appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()


--- mute volume on computer sleep
function muteOnWake(eventType)
    if (eventType == hs.caffeinate.watcher.systemDidWake) then
      local output = hs.audiodevice.defaultOutputDevice()
      output:setMuted(true)
    end
  end
caffeinateWatcher = hs.caffeinate.watcher.new(muteOnWake)
caffeinateWatcher:start()

