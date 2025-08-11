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

-- گرفتن تعداد پلیرهای هر جاب | Get Number Of Every Job's Online Employees
local function GetAllJobCounts()
    local counts = {}
    local players = GetPlayers()

    for _, id in ipairs(players) do
        local jobName
        if CoreType == 'QBCore' or CoreType == 'OldQBCore' then
            local Player = Core.Functions.GetPlayer(tonumber(id))
            if Player then
                jobName = Player.PlayerData.job.name
            end
        elseif CoreType == 'ESX' or CoreType == 'OldESX' then
            local xPlayer = Core.GetPlayerFromId(tonumber(id))
            if xPlayer then
                jobName = xPlayer.job.name
            end
        end

        if jobName then
            counts[jobName] = (counts[jobName] or 0) + 1
        end
    end

    return counts
end

-- دریافت وضعیت سرقت ها | Get Robbery Status
local function GetRobsStatus()
    local jobCounts = GetAllJobCounts()
    local result = {}

    for robName, robData in pairs(Config.Robs) do
        local allOk = true
        local jobInfo = {}

        for job, minCount in pairs(robData.requiredJobs) do
            local current = jobCounts[job] or 0
            jobInfo[job] = {
                count = current,
                required = minCount,
                active = current >= minCount
            }
            if current < minCount then
                allOk = false
            end
        end

        result[robName] = {
            jobs = jobInfo,
            robActive = allOk
        }
    end

    return result
end

-- درخواست دیتا از کلاینت | Request Data From Client
RegisterNetEvent('scoreboard:requestData', function()
    local src = source
    local data = {
        players = #GetPlayers(),
        robs = GetRobsStatus()
    }
    TriggerClientEvent('scoreboard:updateData', src, data)
end)

-- بروزرسانی اسکوربرد | Updating The Scoreboard
CreateThread(function()
    while true do
        Wait((Config.UpdateInterval or 5) * 1000)
        local players = GetPlayers()
        local data = {
            players = #players,
            robs = GetRobsStatus()
        }
        for _, id in ipairs(players) do
            TriggerClientEvent('scoreboard:updateData', id, data)
        end
    end
end)
