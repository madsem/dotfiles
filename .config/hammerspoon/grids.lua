-- Window management
hs.window.animationDuration = 0 -- disable animations
hs.grid.setMargins({0, 0})
hs.grid.setGrid('2x2')

function mkSetFocus(to)
    return function() hs.grid.set(hs.window.focusedWindow(), to) end
end

local fullScreen = hs.geometry("0,0 2x2")
local leftHalf = hs.geometry("0,0 1x2")
local rightHalf = hs.geometry("1,0 1x2")
local upperLeft = hs.geometry("0,0 1x1")
local lowerLeft = hs.geometry("0,1 1x1")
local upperRight = hs.geometry("1,0 1x1")
local lowerRight = hs.geometry("1,1 1x1")


hs.hotkey.bind(hyper, "8", mkSetFocus(upperLeft))
hs.hotkey.bind(hyper, "9", mkSetFocus(upperRight))
hs.hotkey.bind(hyper, 'i', mkSetFocus(leftHalf))
hs.hotkey.bind(hyper, "o", mkSetFocus(rightHalf))
hs.hotkey.bind(hyper, "k", mkSetFocus(lowerLeft))
hs.hotkey.bind(hyper, "l", mkSetFocus(lowerRight))
hs.hotkey.bind(hyper, 'space', mkSetFocus(fullScreen))

-- throw to other screen
hs.hotkey.bind(hyper, '/', function()
    local window = hs.window.focusedWindow()
    window:moveToScreen(window:screen():next())
end)

--- snap all windows to grid
hs.hotkey.bind(hyper, "'", function() hs.fnutils.map(hs.window.visibleWindows(), hs.grid.snap) end)

