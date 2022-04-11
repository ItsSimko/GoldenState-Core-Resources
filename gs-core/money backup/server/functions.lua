Core.Player = {}

Core.GetPlayers = function()
	local sources = {}

	for k,v in pairs(Core.Players) do
		table.insert(sources, k)
	end

	return sources
end

Core.savePlayer = function(player)
    if player == nil then
        print("error no player to save")
    else
        MySQL.Async.execute('UPDATE characters SET accounts = @accounts WHERE identifier = @identifier AND charid = @charid', function(updates) end)
        print("[CORE][SAVE] Succesfully saved player CharID:".. player.activeCharId.." NAME:".. player.getName) 
    end
end

Core.savePlayers = function()
    local xPlayers = Core.GetPlayers()

	for i=1, #xPlayers, 1 do
			local xPlayer = Core.getPlayerFromId(xPlayers[i])
			Core.savePlayer(xPlayer)
    end
end

Core.Player.getPlayerFromId = function(id)
    return Core.Players[tonumber(id)]
end

Core.Player.getPlayerFromSteam = function(steam)
    for k, v in pairs(Core.Players) do
        if v.steamId == steam then
            do return v end
            break
        end
    end
end

RegisterServerEvent('core:getServer')
AddEventHandler('core:getServer', function(cb)
    cb(Core)
end)

function coreReceiveServer()
    return Core
end