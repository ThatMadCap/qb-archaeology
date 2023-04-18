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
    TriggerClientEvent('inventory:client:ItemBox', src, iteminfo, "add")
	TriggerClientEvent("QBCore:Notify", src, "You grabbed "..itemName.."!")
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


