--[[ 
    TODO: 
    create table that maps WireGuard VPN connections to country codes
    Then use https://www.hammerspoon.org/docs/hs.location.geocoder.html,
    to select a VPN country with a mapping, or fall back to a default VPN connection.
--]] 
local myVPN = "Germany"

--- Turn VPN on when connected to unsecure ssids
local function toggleVpn(prev_ssid, new_ssid)

    --- Don't do nothing if it's just a reconnect
    if new_ssid == prev_ssid then do return end end

    --- How big are the chances an untrusted network has those? We will see :)
    if string.find(new_ssid, "Oo_") then
        hs.execute("scutil --nc stop " .. myVPN)
    else

        hs.alert("Untrusted WIFI detected, starting VPN")

        --- Wait until we have internet connectivity
        hs.network.reachability.internet():setCallback(
            function(self, flags)
                if (flags & hs.network.reachability.flags.reachable) > 0 then
                    hs.execute("scutil --nc start " .. myVPN)
                    hs.alert(myVPN .. " VPN successfully connected")

                    --- stop watcher to prevent firing multiple alerts.
                    self:stop()
                end
            end):start()
    end

end

--- use the WiFiTransitions spoon to cleanly manage wifi transitions
Install:andUse("WiFiTransitions", {
    config = {
        actions = {
            {
                -- Toggle VPN
                fn = function(_, _, prev_ssid, new_ssid)
                    toggleVpn(prev_ssid, new_ssid)
                end
            }
        }
    },
    start = true
})
