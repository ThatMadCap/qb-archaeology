-- RNG for rare finds is currently using default seed
-- To set a more "real" random seed before generating random numbers we could use math.randomseed(os.time())
-- Leaving as is for simplicity (will always give pseudo-random numbers)
local QBCore = exports['qb-core']:GetCoreObject()
local inScenario = false
local ableToDig = false
local alreadyDug = {}

-- Dig via command
RegisterCommand("dig", function()
    startActivity()
end, false)

-- Net event if you want to call it from a usable item
RegisterNetEvent('qb-archaeology:dig')
AddEventHandler('qb-archaeology:dig', function()
	startActivity()
end)

-- Keep all clients up to date with locations already dug up
RegisterNetEvent('qb-archaeology:setLocationAsDug')
AddEventHandler('qb-archaeology:setLocationAsDug', function(location)
    table.insert(alreadyDug, location)
end)


-- Main activity method
function startActivity(playerServerId)
    Citizen.CreateThread(function()
        QBCore.Functions.TriggerCallback('qb-archaeology:getDigItem', function(hasTrowel)
            if hasTrowel then
                -- Check if the ground is compatibile before digging
                local diggable, message, location, _, ground = getDiggingLocation()
                if diggable then
                    QBCore.Functions.Notify('Started Digging')
                    TriggerServerEvent('qb-archaeology:setLocationAsDug', location)
                    local timeToStart = GetGameTimer()
                    local timeToComplete = Config.DigTimeMax
                    if Config.RandomTime then
                        timeToComplete = math.random(Config.DigTimeMin, Config.DigTimeMax) -- should use math.randomseed(os.time()) to get around repetiveness but we'll keep it simple for now                                              
                    end
                    runScenario(Config.Scenario)
                    while GetGameTimer() <= timeToStart + timeToComplete do
                        Wait(0)
                    end
                    if inScenario then
                        ClearPedTasks(PlayerPedId())
                        local val = math.random(1, Config.Ground[ground]) -- should use math.randomseed(os.time()) to get around repetiveness but we'll keep it simple for now                                            
                        local reward = 'nothing'
                        for i=1, #Config.RareItems, 1 do
                            if val <= Config.RareItems[i].value then
                                reward = Config.RareItems[i]
                                break
                            end
                        end
                        if reward ~= 'nothing' then
                            TriggerServerEvent('qb-archaeology:success', reward, reward["item"],reward["label"])
                        else
                            QBCore.Functions.Notify('You found nothing')
                        end
                    end
                    inScenario = false
                else -- If it's not compatible ground then notify the player
                    QBCore.Functions.Notify(message)
                end
            end
        end)
    end)
end

-- Scenario player
function runScenario(name)
    local playerPed = PlayerPedId()
    ClearPedTasks(playerPed)
    SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`)
    TaskStartScenarioInPlace(playerPed, name, 0, true)
    inScenario = true
end

-- Check ground level
function checkLevel(surfaceNormal)
    local x = math.abs(surfaceNormal.x)
    local y = math.abs(surfaceNormal.y)
    local z = math.abs(surfaceNormal.z)
    return (
        x <= Config.MaxGroundAngle
        and
        y <= Config.MaxGroundAngle
        and
        z >= 1.0 - Config.MaxGroundAngle
    )
end

-- Check ground compatibility 
function getDiggingLocation()
    local ped = PlayerPedId()

    -- Obviously no digging in cars
    if IsPedInAnyVehicle(ped) then
        return false, 'Unable to dig inside vehicle'
    end

    local playerCoord = GetEntityCoords(ped)
    local target = GetOffsetFromEntityInWorldCoords(ped, vector3(0,2,-3)) -- Tried and tested vector
    local testRay = StartShapeTestRay(playerCoord, target, 17, ped, 7) -- This values 17 and 7 are kind of just tried and tested to work nicely
    local _, hit, hitLocation, surfaceNormal, material, _ = GetShapeTestResultEx(testRay)    

    -- Initial check, if hit is 0 just escape
    if hit == 1 then
        if Config.Ground[material] then
            -- First check if location has already been dug up
            for i, location in ipairs(alreadyDug) do
                local distanceToOld = #(playerCoord - location)
                if distanceToOld <= Config.MinDistanceBetweenSites then
                    return false, 'You already dug here, try somewhere else', hitLocation, surfaceNormal, material
                end
            end
            -- Check to see ground angle    
            if checkLevel(surfaceNormal) then
                return true,'OK', hitLocation, surfaceNormal, material            
            else
                return false, 'Too steep to dig', hitLocation, surfaceNormal, material
            end
        else
            return false, 'Ground not suitable for digging', hitLocation, surfaceNormal, material
        end
    else
        return false, 'Too steep to dig', hitLocation, surfaceNormal, material
    end
end
