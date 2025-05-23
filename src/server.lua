local config = require('config')
local ESX = exports.es_extended:getSharedObject()

exports('getPlayerPlaytime', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return 0 end
    
    local playtime = xPlayer.getPlayTime()
    return math.floor(playtime / 3600)
end)

lib.callback.register('playtime:checkWeaponAccess', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end

    if lib.table.contains({'sheriff', 'police', 'ambulance'}, xPlayer.job.name) then
        return true
    end

    local playtime = xPlayer.getPlayTime()
    local hours = math.floor(playtime / 3600)
    
    return hours >= config.Hours
end)

lib.addCommand('playtime', {
    help = 'Check your current playtime',
    restricted = false
}, function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    local playtime = xPlayer.getPlayTime()
    local days = math.floor(playtime / 86400)
    local hours = math.floor((playtime % 86400) / 3600)
    local minutes = math.floor((playtime % 3600) / 60)

    TriggerClientEvent('chat:addMessage', source, {
        multiline = true,
        args = {('^1[ ! ]: ^7You have played for %s Days, %s Hours, %s Minutes^7'):format(days, hours, minutes)}
    })
end)
