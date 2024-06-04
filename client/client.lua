-- RNG for rare finds is currently using default seed
-- To set a more "real" random seed before generating random numbers we could use math.randomseed(os.time())
-- Leaving as is for simplicity (will always give pseudo-random numbers)
local QBCore = exports['qb-core']:GetCoreObject()
local inScenario = false
local ableToDig = false
local alreadyDug = {}

-- Dig via command
--[[ RegisterCommand("dig", function()
startActivity()
end, false) ]]

-- Net event if you want to call it from a usable item
RegisterNetEvent('qb-archaeology:dig')
AddEventHandler('qb-archaeology:dig', function()
	startActivity()
end)

-- Keep all clients up to date with locations already dug up
RegisterNetEvent('qb-archaeology:setLocationAsDug')
AddEventHandler('qb-archaeology:setLocationAsDug', function(location)
    table.insert(alreadyDug, location)
    SpawnDugProp(location)
end)

-- Variable used by the function below
local rarePropChance = 1 -- 1% chance

-- Spawn prop function
function SpawnDugProp(location)

    -- Determine whether to spawn the rare prop
    local spawnRareProp = math.random(1, 100) <= rarePropChance

    -- Define the model to spawn based on chance
    local model = spawnRareProp and "xm_prop_x17_chest_closed" or "prop_pile_dirt_01"

    -- Load the model
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(500)
    end

    -- Adjust Z position for rare prop
    local zOffset = spawnRareProp and 0.0 or -1

    -- Create the prop
    local prop = CreateObject(model, location.x, location.y, location.z + zOffset, true, true, true)

    -- Disable collision between the prop and the player
    SetEntityNoCollisionEntity(PlayerPedId(), prop, true)

    -- Fade in the prop gradually
    for alpha = 0, 255, 5 do
        SetEntityAlpha(prop, alpha, false)
        Wait(50) -- Adjust the duration of each step
    end

    -- Set the final alpha value to ensure it's fully visible
    SetEntityAlpha(prop, 255, false)

    -- Freeze entity position (stop it moving)
    FreezeEntityPosition(prop, true)

    -- Set the model as no longer needed
    SetModelAsNoLongerNeeded(model)

end


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

                        --print("^7 You rolled: ^1" .. val .. "^7 out of: ^1" .. Config.Ground[ground])

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

---------------

-- Spawn Sell Ped
CreateThread(function()
    exports['qb-target']:SpawnPed({
        model = Config.ArcCommonPed,
        coords = Config.ArcCommonPedLocation,
        minusOne = true, 
        freeze = true, 
        invincible = true, 
        blockevents = true,
        scenario = Config.Scenario,
        target = { 
            options = {
                {
                    type="client",
                    event = "qb-archaeology:TradingMenu",
                    icon = "fas fa-user-secret",
                    label = "Trade your Dig Finds"
                }
            },
          distance = 2.5,
        },
    })
end)


RegisterNetEvent('qb-archaeology:TradingMenu', function(data)
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Archaeology Trade",
            isMenuHeader = true,
        },
        {
            id = 2,
            header = "Skull",
            txt = "Sell 1 Skull for $100",
            params = {
                isServer = true,
                event = "qb-archaeology:server:Trade",
                args = {
                    id = 2,
                    item = 'skull'
                }
            }
        },
        {
            id = 3,
            header = "Pot",
            txt = "Sell 1 Pot for $200",
            params = {
                isServer = true,
                event = "qb-archaeology:server:Trade",
                args = {
                    id = 3,
                    item = 'pot'
                }
            }
        },
        {
            id = 4,
            header = "Relic",
            txt = "Sell 1 Relic for $300",
            params = {
                isServer = true,
                event = "qb-archaeology:server:Trade",
                args = {
                    id = 4,
                    item = 'relic'
                }
            }
        },
        {
            id = 5,
            header = "Fossil",
            txt = "Sell 1 Fossil $400",
            params = {
                isServer = true,
                event = "qb-archaeology:server:Trade",
                args = {
                    id = 5,
                    item = 'fossil'
                }
            }
        },
        {
            id = 6,
            header = "Decorated Pot",
            txt = "Sell 1 Decorated Pot for $500",
            params = {
                isServer = true,
                event = "qb-archaeology:server:Trade",
                args = {
                    id = 6,
                    item = 'decoratedpot'
                }
            }
        },
        {
            id = 7,
            header = "Time Capsule",
            txt = "Sell 1 Time Capsule for $600",
            params = {
                isServer = true,
                event = "qb-archaeology:server:Trade",
                args = {
                    id = 7,
                    item = 'timecapsule'
                }
            }
        },
        {
            id = 8,
            header = "Rare Fossil",
            txt = "Sell 1 Rare Fossil for $750",
            params = {
                isServer = true,
                event = "qb-archaeology:server:Trade",
                args = {
                    id = 8,
                    item = 'rarefossil'
                }
            }
        },
        {
            id = 9,
            header = "Onyx Relic",
            txt = "Sell 1 Onyx Relic for $1,000",
            params = {
                isServer = true,
                event = "qb-archaeology:server:Trade",
                args = {
                    id = 9,
                    item = 'onyxrelic'
                }
            }
        },
        {
            id = 10,
            header = "Mythic Fossil",
            txt = "Sell 1 Mythic Fossil for $2,500",
            params = {
                isServer = true,
                event = "qb-archaeology:server:Trade",
                args = {
                    id = 10,
                    item = 'mythicfossil'
                }
            }
        },
        {
            id = 11,
            header = "Ancient Red Gem",
            txt = "Sell 1 Ancient Red Gem for $5,000",
            params = {
                isServer = true,
                event = "qb-archaeology:server:Trade",
                args = {
                    id = 11,
                    item = 'princeruby'
                }
            }
        },
        {
            id = 12,
            header = "Dino Egg",
            txt = "Sell 1 Dino Egg for $7,500",
            params = {
                isServer = true,
                event = "qb-archaeology:server:Trade",
                args = {
                    id = 12,
                    item = 'dinoegg'
                }
            }
        },
        {
            id = 13,
            header = "Slate Tablet",
            txt = "Sell 1 Slate Tablet for $9,000",
            params = {
                isServer = true,
                event = "qb-archaeology:server:Trade",
                args = {
                    id = 13,
                    item = 'slatetablet'
                }
            }
        },
        {
            id = 14,
            header = "Broken Gold Chain",
            txt = "Sell 1 Broken Gold Chain for $10,000",
            params = {
                isServer = true,
                event = "qb-archaeology:server:Trade",
                args = {
                    id = 14,
                    item = 'echain'
                }
            }
        },
    })
end)