--- layouts (hyper + fn) + Fy
local activeDisplay = hs.screen.mainScreen()

--- set up layout grid
hs.layout.topRight = { x = 0.5, y = 0, w = 0.5, h = 0.5 }
hs.layout.bottomRight = { x = 0.5, y = 0.5, w = 0.5, h = 0.5 }

--- loop over layout applications and open them if necessary
function toggleWorkspace(apps, layout)
    for key, value in pairs(apps) do
        toggleApplication(value)
    end

    hs.layout.apply(layout)
end

--- development
local devApps = {
    'Visual Studio Code',
    'PhpStorm',
    'iTerm',
    'TablePlus',
    'Google Chrome'
}

local devLayout = {
  { 'Code', nil, activeDisplay, hs.layout.left50, nil, nil },
  { 'PhpStorm', nil, activeDisplay, hs.layout.left50, nil, nil },
  { 'TablePlus', nil, activeDisplay, hs.layout.right50, nil, nil },
  { 'iTerm2', nil, activeDisplay, hs.layout.right50, nil, nil },
  { 'Google Chrome', nil, activeDisplay, hs.layout.right50, nil, nil },
}
hs.hotkey.bind(hyper, '1', function() toggleWorkspace(devApps, devLayout) end)

--- communication
local commApps = {
    'Mail',
    'Skype',
    'Messages'
}

local commLayout = {
    { 'Mail', nil, activeDisplay, hs.layout.left50, nil, nil },
    { 'Skype', nil, activeDisplay, hs.layout.topRight, nil, nil },
    { 'Messages', nil, activeDisplay, hs.layout.bottomRight, nil, nil },
  }
  hs.hotkey.bind(hyper, '2', function() toggleWorkspace(commApps, commLayout) end)
  