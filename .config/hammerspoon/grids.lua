--- default grid, 2x2 issa niiice
hs.grid.setGrid'2x2'
hs.grid.setMargins("0,0")

--- disable window animations, for betterer speed
hs.window.animationDuration = 0

--- arrows: move focused window
hs.hotkey.bind(hyper, "left", function() hs.grid.pushWindowLeft() end)
hs.hotkey.bind(hyper, "right", function() hs.grid.pushWindowRight() end)
hs.hotkey.bind(hyper, "up", function() hs.grid.pushWindowUp() end)
hs.hotkey.bind(hyper, "down", function() hs.grid.pushWindowDown() end)

--- ikjl: resize window
hs.hotkey.bind(hyper, "k", function() hs.grid.resizeWindowTaller() end)
hs.hotkey.bind(hyper, "i", function() hs.grid.resizeWindowShorter() end)
hs.hotkey.bind(hyper, "j", function() hs.grid.resizeWindowThinner() end)
hs.hotkey.bind(hyper, "l", function() hs.grid.resizeWindowWider() end)

--- 1,2,3,4: show grid & resize grid
hs.hotkey.bind(hyper, "1", function() hs.grid.show(); end)
hs.hotkey.bind(hyper, "2", function() hs.grid.setGrid('2x2'); hs.alert.show('Grid set to 2x2'); end)
hs.hotkey.bind(hyper, "3", function() hs.grid.setGrid('3x2'); hs.alert.show('Grid set to 3x2'); end)
hs.hotkey.bind(hyper, "4", function() hs.grid.setGrid('4x2'); hs.alert.show('Grid set to 4x2'); end)

--- space: maximize window
hs.hotkey.bind(hyper, "space", function() hs.grid.maximizeWindow() end)

--- /: move window to next screen
hs.hotkey.bind(hyper, "/", function() local win = getWin(); win:moveToScreen(win:screen():next()) end)

--- snap window(s) to grid
hs.hotkey.bind(hyper, ';', function() hs.grid.snap(hs.window.focusedWindow()) end) --- snap one
hs.hotkey.bind(hyper, "'", function() hs.fnutils.map(hs.window.visibleWindows(), hs.grid.snap) end) --- snap 'em all

