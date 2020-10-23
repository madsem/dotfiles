--- hyper on caps_lock
hyper = { "cmd", "alt", "ctrl", "shift" }

-- log stuff if needed
log = hs.logger.new('init','debug')

--- Install Spoons
hs.loadSpoon('SpoonInstall')
spoon.SpoonInstall.use_syncinstall = true
Install = spoon.SpoonInstall

-- launchOrFocus apps, or activate / hide.
--- windowTitle (optional): if app has different name than title (Like visual studio code)
function toggleApplication(name, windowTitle)
  log.d(name)
  windowTitle = windowTitle or name
  focused = hs.window.focusedWindow()
  search = hs.application.find(name) or hs.application.find(windowTitle)
  if focused and search then
    app = focused:application()
    log.d(app:title())
    log.d(search:title())
    if app:title() == search:title() then
      log.d('Hide application')
      search:hide()
      return
    end
  end

  log.d('launchOrFocus', name)
  hs.application.launchOrFocus(name)
end

function stopApp(name)
  app = hs.application.get(name)
  if app and app:isRunning() then
    app:kill()
  end
end

function forceKillProcess(name)
  hs.execute("pkill " .. name)
end

function startApp(name)
  hs.application.open(name)
end

--- lock screen
hs.hotkey.bind(hyper, "delete", function() hs.caffeinate.lockScreen(); end)

--- require modules
require "grids"
require "apps"
require "layouts"
require "watchers"
require "wifi"

