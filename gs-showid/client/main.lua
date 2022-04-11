local hasId

RegisterNetEvent('id:notPlayer')
AddEventHandler('id:notPlayer', function()
    SetNotificationTextEntry('STRING')
	AddTextComponentString("The player ID you entered is not a valid player.")
	DrawNotification(0,1)
end)

RegisterNetEvent('id:showIdClosest')
AddEventHandler('id:showIdClosest', function()
    local zPly = GetClosestPlayer()

    if zPly == false then
        TriggerEvent('chat:addMessage', {
            args = {"~r~No player close enough to show ID to."}
          })
    else
        ExecuteCommand('showid '.. zPly)
    end
end)

TriggerEvent('chat:addSuggestion', '/showid', 'This command will show your ID Card to the nearest player.', {
    { name="playerId", help="To send your ID directly to someone place their Server ID here." },
})


RegisterNetEvent('id:showIdExact')
AddEventHandler('id:showIdExact', function(fromPlayer)
    if not hasId then
        local zPlayer = fromPlayer
        local zIndex = GetPlayerFromServerId(zPlayer.serverId)
        local zPos = GetEntityCoords(GetPlayerPed(zIndex))
        local xPos = GetEntityCoords(GetPlayerPed(-1))

        if Vdist2(zPos, xPos) < 5.0 then
            hasId = true
            
            local mugshot, mugshotStr = GetPedMugshot(GetPlayerPed(zIndex), false)

            while hasId do
                while not HasStreamedTextureDictLoaded('showid') do
                    RequestStreamedTextureDict('showid')
                    Citizen.Wait(0)
                end
                DrawSprite("showid", "idcard", 0.75, 0.875, 0.175, 0.245, 0.0, 255, 255, 255, 1000)
                drawText(""..zPlayer.Player.firstName .. "   ".. zPlayer.Player.lastName, 0.735, 0.819, 0, 0.275,0.275)
                drawText(""..zPlayer.Player.firstName .. "   ".. zPlayer.Player.lastName, 0.735, 0.9, 1, 0.45,0.45)
                drawText(zPlayer.Player.sex .. "     "..zPlayer.Player.dob, 0.735, 0.858, 0, 0.275,0.275)
                DrawSprite(mugshotStr, mugshotStr, 0.70, 0.885, 0.055, 0.120, 0.0, 255, 255, 255, 1000)
                displayHelpText("Press ~INPUT_CONTEXT~ to hide the id.")

                if IsControlJustReleased(0, 38) then
                    hasId = false
                    UnregisterPedheadshot(mugshot)
                    SetStreamedTextureDictAsNoLongerNeeded('showid')
                end

                Wait(0)
            end
        else
            TriggerServerEvent('id:toFar', fromPlayer.serverId)
        end
    else 
        SetNotificationTextEntry('STRING')
        AddTextComponentString("Someone tried handing you another ID but you already had one in your hands.")
        DrawNotification(0,1)
        TriggerServerEvent('id:hasId', fromPlayer.serverId)
    end
end)


RegisterNetEvent('id:hasIdNoti')
AddEventHandler('id:hasIdNoti', function()
    SetNotificationTextEntry('STRING')
	AddTextComponentString("The player you tried to give a ID to already has one in their hands.")
	DrawNotification(0,1)
end)

RegisterNetEvent('id:toFarNoti')
AddEventHandler('id:toFarNoti', function()
    SetNotificationTextEntry('STRING')
	AddTextComponentString("You are not close enough to this player to give them your ID.")
	DrawNotification(0,1)
end)


GetPedMugshot = function(ped, transparent)
	if DoesEntityExist(ped) then
		local mugshot

		if transparent then
			mugshot = RegisterPedheadshotTransparent(ped)
		else
			mugshot = RegisterPedheadshot(ped)
		end

		while not IsPedheadshotReady(mugshot) or not IsPedheadshotValid(mugshot) do
			Citizen.Wait(0)
		end

		return mugshot, GetPedheadshotTxdString(mugshot)
	else
		return
	end
end

displayHelpText = function(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

drawText = function(msg, x, y, fontid, scale)
    SetTextFont(fontid)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(0, 0, 0, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextEntry("STRING")
    AddTextComponentString(msg)
    DrawText(x, y)
end

GetClosestPlayer = function()
    local Ped = PlayerPedId()

    for _, Player in ipairs(GetActivePlayers()) do
        if GetPlayerPed(Player) ~= GetPlayerPed(-1) then
            local Ped2 = GetPlayerPed(Player)
            local x, y, z = table.unpack(GetEntityCoords(Ped))
            if (GetDistanceBetweenCoords(GetEntityCoords(Ped2), x, y, z) <  5.0) then
                return GetPlayerServerId(Player)
            end
        end
    end

    return false
end