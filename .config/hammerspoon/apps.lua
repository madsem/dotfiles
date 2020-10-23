
--- browsers
hs.hotkey.bind(hyper, "g", function() toggleApplication("Google Chrome") end)
hs.hotkey.bind(hyper, "s", function() toggleApplication("Safari") end)
hs.hotkey.bind(hyper, "a", function() toggleApplication("Opera") end)

--- general mac
hs.hotkey.bind(hyper, "f", function() toggleApplication("Finder") end)
hs.hotkey.bind(hyper, "m", function() toggleApplication("Mail") end)
hs.hotkey.bind(hyper, "return", function() toggleApplication("System Preferences") end)
hs.hotkey.bind(hyper, "z", function() toggleApplication("iTunes") end)
hs.hotkey.bind(hyper, "x", function() toggleApplication("Screen Sharing") end)
hs.hotkey.bind(hyper, "e", function() toggleApplication("TextEdit") end)
hs.hotkey.bind(hyper, ";", function() toggleApplication("Screenshot") end)

--- messengers
hs.hotkey.bind(hyper, "\\", function() toggleApplication("Skype") end)
hs.hotkey.bind(hyper, ']', function() toggleApplication("Messages") end)

--- development
hs.hotkey.bind(hyper, "c", function() toggleApplication("Visual Studio Code", "Code") end)
hs.hotkey.bind(hyper, "p", function() toggleApplication("PhpStorm") end)
hs.hotkey.bind(hyper, "d", function() toggleApplication("TablePlus") end)
hs.hotkey.bind(hyper, "t", function() toggleApplication("iTerm") end)

--- vpn
hs.hotkey.bind(hyper, "v", function() toggleApplication("WireGuard") end)
