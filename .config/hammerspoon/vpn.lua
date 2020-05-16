local vpn = "Windscribe"

--- Turn VPN on when connected to unsecure ssids
local function toggleVpn(prev_ssid, new_ssid)

    --- Don't do nothing if it's just a reconnect
    if new_ssid == prev_ssid then 
        do return end
    end

    if new_ssid == "0o 5GHz" or new_ssid == "0o" then
        stopApp(vpn)
    else
        --- (Re-) start Windscribe, 
        --- to have VPN auto-connect when connected to unsecure WIFI.
        hs.notify.new({
            title="Unsecure WIFI Detected", 
            informativeText="Starting VPN..."
        }):send()
        stopApp(vpn)
        startApp(vpn)
    end
end

--- use the WiFiTransitions spoon to cleanly manage wifi events
Install:andUse(
    "WiFiTransitions",
    {
        config = {
            actions = {
                { -- Toggle VPN
                     fn = function(_, _, prev_ssid, new_ssid)
                        toggleVpn(prev_ssid, new_ssid)
                     end
                },
            }
        },
        start = true,
    }
)
