-- Ui BY: Mini Sara
-- ReCoded By: ItzBamdad
local Core, CoreType
local uiOpen = false

-- تشخیص خودکار بیس سرور | Auto Detect Server Core
CreateThread(function()
    while not CoreType do
        if GetResourceState('qb-core') == 'started' then
            Core = exports['qb-core']:GetCoreObject()
            CoreType = 'QBCore'
        elseif GetResourceState('qbus') == 'started' then
            Core = exports['qbus']:GetCoreObject()
            CoreType = 'OldQBCore'
        elseif GetResourceState('es_extended') == 'started' then
            TriggerEvent('esx:getSharedObject', function(obj) Core = obj end)
            CoreType = 'ESX'
        elseif GetResourceState('esx') == 'started' then
            TriggerEvent('esx:getSharedObject', function(obj) Core = obj end)
            CoreType = 'OldESX'
        else
            Wait(1000)
        end
        Wait(0)
    end
    print("^2[ParadiseInspiredScoreboardAndVersionHUD] Detected core: ^7" .. tostring(CoreType))
end)

-- فانکشن باز و بسته کردن اسکوربرد | Toggling Scoreboard Function
local function ToggleScoreboard()
    uiOpen = not uiOpen
    SetNuiFocus(uiOpen, uiOpen)
    SendNUIMessage({ action = "toggle" }) -- سازگار با UI ای که toggle دریافت میکنه
    if uiOpen then
        TriggerServerEvent('scoreboard:requestData')
    end
end


-- باز/بستن اسکوربورد | Toggling Scoreboard
RegisterCommand(Config.ScoreboardCommand, function()
    ToggleScoreboard()
end, false)

-- دکمه باز و بستن اسکوربرد | KeyBind
CreateThread(function()
    local key = Config and Config.ScoreboardKey
    RegisterKeyMapping('scoreboard', 'Toggle Scoreboard UI', 'keyboard', key)
end)

-- ان یو آی کال بک بستن اسکوربرد | Closing Scoreboard NUI Callback
RegisterNUICallback('close', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)
