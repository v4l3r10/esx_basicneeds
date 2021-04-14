ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

for i=1, #Config.Items, 1 do 
	local item = Config.Items[i];
	
	ESX.RegisterUsableItem(item.name, function(source)
	
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem(item.name, 1)
		
		TriggerClientEvent('esx_status:add', source, item.pType, item.value)
		
		if(item.pType == 'thirst') then
			TriggerClientEvent('esx_basicneeds:onDrink', source)
		else 
			TriggerClientEvent('esx_basicneeds:onEat', source)
		end
		
		local msg = _U('used_' .. item.name)
		if(msg == nil) then
			msg = _U('used_' .. pType)
		end
		TriggerClientEvent('esx:showNotification', source, msg)
	end)
end

ESX.RegisterCommand('heal', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_basicneeds:healPlayer')
	args.playerId.triggerEvent('chat:addMessage', {args = {'^5HEAL', 'You have been healed.'}})
end, true, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})
