-- Ui BY: Mini Sara
-- ReCoded By: ItzBamdad
local Core, CoreType

-- تشخیص خودکار بیس سرور | Auto Detect Server Core
CreateThread(function()
    if GetResourceState('qb-core') == 'started' then
        Core = exports['qb-core']:GetCoreObject()
        CoreType = 'QBCore'
    elseif GetResourceState('es_extended') == 'started' then
        TriggerEvent('esx:getSharedObject', function(obj) Core = obj end)
        CoreType = 'ESX'
    elseif GetResourceState('esx') == 'started' then
        TriggerEvent('esx:getSharedObject', function(obj) Core = obj end)
        CoreType = 'OldESX'
    elseif GetResourceState('qbus') == 'started' then
        Core = exports['qbus']:GetCoreObject()
        CoreType = 'OldQBCore'
    end
end)

-- گرفتن اطلاعات و ارسال آن به اسکوربرد | Requesting The Data And Sending Them To The Scoreboard
RegisterNetEvent('scoreboard:updateData', function(data)
    SendNUIMessage({
        action = "updateData",
        players = data.players,
        robs = data.robs
    })
end)

-- باز/بستن اسکوربورد | Toggling Scoreboard
RegisterCommand('scoreboard', function()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "toggle" })
    TriggerServerEvent('scoreboard:requestData')
end)

-- ان یو آی کال بک بستن اسکوربرد | Closing Scoreboard NUI Callback
RegisterNUICallback('close', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)
