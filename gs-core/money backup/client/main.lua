RegisterNUICallback('disconnect', function(data, cb)
    TriggerServerEvent('core:dc')
    cb('ok')
end)

RegisterNUICallback('refresh', function(data, cb)
    TriggerServerEvent('core:getChars', "refresh")
end)

RegisterNUICallback('registerChar', function(data, cb)
    TriggerServerEvent('core:registerChar', data)
    cb('ok')
end)

RegisterNUICallback('deleteChar', function(data, cb)
    TriggerServerEvent('core:deleteChar', data)
    cb('ok')
end)

RegisterNUICallback('selectChar', function(data, cb)
	TriggerServerEvent('core:selectChar', data)
	cb("ok")
end)

RegisterNetEvent('core:refreshChars')
AddEventHandler('core:refreshChars', function(chars, disc)
	SendNuiMessage(json.encode{
		type = 'refresh',
		newData = chars,
		newRoles = disc,
		spawns = cfg.SpawnPoints
	})
end)

RegisterNetEvent('core:aopUpdate')
AddEventHandler('core:aopUpdate', function(AOP)
	SendNuiMessage(json.encode{
		type = 'aop',
		aop = AOP
	})
end)

RegisterNetEvent('core:openCharSelection')
AddEventHandler('core:openCharSelection', function(chars, disc)
	SendNuiMessage(json.encode{
		type = 'open',
		charData = chars,
		discordRoles = disc,
		spawns = cfg.SpawnPoints
	})
	SetNuiFocus(true, true)
end)

RegisterNetEvent('core:spawnPlayer')
AddEventHandler('core:spawnPlayer', function(spawn, charData)
	local char = json.decode(charData)

	SetEntityCoords(PlayerPedId(), spawn.x, spawn.y, spawn.z)
	SendNuiMessage(json.encode{
		type='close',
	})
	DoScreenFadeIn(1000)
	SetNuiFocus(false, false)
	TriggerEvent('chat:addMessage', {
		template = '<div style="padding: 0.25vw; background-color: rgba(0, 0, 0, 0.6); color: white; border-radius: 3px; text-align:center;"> &ensp; <font color="white" >{1}</font></div>',
		args = {"", "You are now playing as "..char[1].fname.." "..char[1].lname.." ("..char[1].department..")"}
	  })
	
	  TriggerEvent('phone:PlayerSpawned')
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsPlayerActive(PlayerId()) then
			TriggerServerEvent('core:playerJoined')
			break
		end
	end
end)

RegisterCommand('switchchar', function()
	DoScreenFadeOut(1000)
    TriggerServerEvent('core:getChars')
end)

