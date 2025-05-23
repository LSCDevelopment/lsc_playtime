local config = require('config')

lib.onCache('weapon', function(value, oldValue)
    if value then
        if lib.table.contains(config.BypassWeapons, value) then return end

        lib.callback('playtime:checkWeaponAccess', false, function(hasAccess)
            if not hasAccess then
                TriggerEvent('ox_inventory:disarm', false)
                TriggerEvent('chat:addMessage', {
                    multiline = true,
                    args = {'^1[ ! ] ^7You cannot use weapons until you have played for at least ' .. config.Hours .. ' hours.'}
                })
            end
        end)
    end
end)