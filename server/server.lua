local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-archaeology:setLocationAsDug')
AddEventHandler('qb-archaeology:setLocationAsDug', function(location)
    TriggerClientEvent('qb-archaeology:setLocationAsDug', -1, location)
end)

RegisterServerEvent("qb-archaeology:success")
AddEventHandler("qb-archaeology:success",function(item, iteminfo, itemName)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem(iteminfo, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[iteminfo], "add")
	TriggerClientEvent("QBCore:Notify", src, "You found a "..itemName.."!")
end)

QBCore.Functions.CreateUseableItem(Config.DigItem, function(source)
	TriggerClientEvent('qb-archaeology:dig', source)
end)

QBCore.Functions.CreateCallback("qb-archaeology:getDigItem",function(source, cb)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName("trowel") then
		cb(true)
	else
		cb(false)
		TriggerClientEvent('QBCore:Notify', source, "I need something to dig maybe?")
	end
end)

-- Trade Event --

RegisterServerEvent('qb-archaeology:server:Trade', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = tostring(data.item)
    local check = Player.Functions.GetItemByName(item)

    if data.id == 2 then
        if check ~= nil then
            if check.amount >= 1 then
                Player.Functions.RemoveItem(item, 1)
                Player.Functions.AddMoney('cash', 100)
                TriggerClientEvent('QBCore:Notify', src, 'You traded 1 Skull'..' for $100.', 'success')
            else 
                TriggerClientEvent('QBCore:Notify', src, "You don't have enough Skulls.", 'error')
            end 
        else 
            TriggerClientEvent('QBCore:Notify', src, "You do not have any Skulls.", 'error')
        end
    elseif data.id == 3 then
        if check ~= nil then
            if check.amount >= 1 then
                Player.Functions.RemoveItem(item, 1)
                Player.Functions.AddMoney('cash', 200)
                TriggerClientEvent('QBCore:Notify', src, 'You traded 1 Pot'..' for $200.', 'success')
            else 
                TriggerClientEvent('QBCore:Notify', src, "You don't have enough Pots.", 'error')
            end 
        else 
            TriggerClientEvent('QBCore:Notify', src, "You do not have any Pots.", 'error')
        end
    elseif data.id == 4 then
        if check ~= nil then
            if check.amount >= 1 then
                Player.Functions.RemoveItem(item, 1)
                Player.Functions.AddMoney('cash', 300)
                TriggerClientEvent('QBCore:Notify', src, 'You traded 1 Relic'..' for $300.', 'success')
            else 
                TriggerClientEvent('QBCore:Notify', src, "You don't have enough Relics.", 'error')
            end 
        else 
            TriggerClientEvent('QBCore:Notify', src, "You do not have any Relics.", 'error')
        end
    elseif data.id == 5 then
        if check ~= nil then
            if check.amount >= 1 then
                Player.Functions.RemoveItem(item, 1)
                Player.Functions.AddMoney('cash', 400)
                TriggerClientEvent('QBCore:Notify', src, 'You traded 1 Fossil'..' for $400.', 'success')
            else 
                TriggerClientEvent('QBCore:Notify', src, "You don't have enough Fossils.", 'error')
            end 
        else 
            TriggerClientEvent('QBCore:Notify', src, "You do not have any Fossils.", 'error')
        end
    elseif data.id == 6 then
        if check ~= nil then
            if check.amount >= 1 then
                Player.Functions.RemoveItem(item, 1)
                Player.Functions.AddMoney('cash', 500)
                TriggerClientEvent('QBCore:Notify', src, 'You traded 1 Decorated Pot'..' for $500.', 'success')
            else 
                TriggerClientEvent('QBCore:Notify', src, "You don't have enough Decorated Pots.", 'error')
            end 
        else 
            TriggerClientEvent('QBCore:Notify', src, "You do not have any Decorated Pots.", 'error')
        end
    elseif data.id == 7 then
        if check ~= nil then
            if check.amount >= 1 then
                Player.Functions.RemoveItem(item, 1)
                Player.Functions.AddMoney('cash', 600)
                TriggerClientEvent('QBCore:Notify', src, 'You traded 1 Time Capsule'..' for $600.', 'success')
            else 
                TriggerClientEvent('QBCore:Notify', src, "You don't have enough Time Capsules.", 'error')
            end 
        else 
            TriggerClientEvent('QBCore:Notify', src, "You do not have any Time Capsules.", 'error')
        end
    elseif data.id == 8 then
        if check ~= nil then
            if check.amount >= 1 then
                Player.Functions.RemoveItem(item, 1)
                Player.Functions.AddMoney('cash', 750)
                TriggerClientEvent('QBCore:Notify', src, 'You traded 1 Rare Fossil'..' for $750.', 'success')
            else 
                TriggerClientEvent('QBCore:Notify', src, "You don't have enough Rare Fossils.", 'error')
            end 
        else 
            TriggerClientEvent('QBCore:Notify', src, "You do not have any Rare Fossils.", 'error')
        end
    elseif data.id == 9 then
        if check ~= nil then
            if check.amount >= 1 then
                Player.Functions.RemoveItem(item, 1)
                Player.Functions.AddMoney('cash', 1000)
                TriggerClientEvent('QBCore:Notify', src, 'You traded 1 Onyx Relic'..' for $1,000.', 'success')
            else 
                TriggerClientEvent('QBCore:Notify', src, "You don't have enough Onyx Relics.", 'error')
            end 
        else 
            TriggerClientEvent('QBCore:Notify', src, "You do not have any Onyx Relics.", 'error')
        end
    elseif data.id == 10 then
        if check ~= nil then
            if check.amount >= 1 then
                Player.Functions.RemoveItem(item, 1)
                Player.Functions.AddMoney('cash', 2500)
                TriggerClientEvent('QBCore:Notify', src, 'You traded 1 Mythic Fossil'..' for $2,500.', 'success')
            else 
                TriggerClientEvent('QBCore:Notify', src, "You don't have enough Mythic Fossils.", 'error')
            end 
        else 
            TriggerClientEvent('QBCore:Notify', src, "You do not have any Mythic Fossils.", 'error')
        end
    elseif data.id == 11 then
        if check ~= nil then
            if check.amount >= 1 then
                Player.Functions.RemoveItem(item, 1)
                Player.Functions.AddMoney('cash', 5000)
                TriggerClientEvent('QBCore:Notify', src, 'You traded 1 Ancient Red Gem'..' for $5,000.', 'success')
            else 
                TriggerClientEvent('QBCore:Notify', src, "You don't have enough Ancient Red Gems.", 'error')
            end 
        else 
            TriggerClientEvent('QBCore:Notify', src, "You do not have any Ancient Red Gems.", 'error')
        end
    elseif data.id == 12 then
        if check ~= nil then
            if check.amount >= 1 then
                Player.Functions.RemoveItem(item, 1)
                Player.Functions.AddMoney('cash', 7500)
                TriggerClientEvent('QBCore:Notify', src, 'You traded 1 Dino Egg'..' for $7,500.', 'success')
            else 
                TriggerClientEvent('QBCore:Notify', src, "You don't have enough Dino Eggs.", 'error')
            end 
        else 
            TriggerClientEvent('QBCore:Notify', src, "You do not have any Dino Eggs.", 'error')
        end
    elseif data.id == 13 then
        if check ~= nil then
            if check.amount >= 1 then
                Player.Functions.RemoveItem(item, 1)
                Player.Functions.AddMoney('cash', 9000)
                TriggerClientEvent('QBCore:Notify', src, 'You traded 1 Slate Tablet'..' for $9,000.', 'success')
            else 
                TriggerClientEvent('QBCore:Notify', src, "You don't have enough Slate Tablets.", 'error')
            end 
        else 
            TriggerClientEvent('QBCore:Notify', src, "You do not have any Slate Tablets.", 'error')
        end
    elseif data.id == 14 then
        if check ~= nil then
            if check.amount >= 1 then
                Player.Functions.RemoveItem(item, 1)
                Player.Functions.AddMoney('cash', 10000)
                TriggerClientEvent('QBCore:Notify', src, 'You traded 1 Broken Gold Chain'..' for $10,000.', 'success')
            else 
                TriggerClientEvent('QBCore:Notify', src, "You don't have enough Broken Gold Chains.", 'error')
            end 
        else 
            TriggerClientEvent('QBCore:Notify', src, "You do not have any Broken Gold Chains.", 'error')
        end
    end
end)