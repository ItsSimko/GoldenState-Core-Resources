Core = {}

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
        local ply = GetPlayerPed(player.serverId)
        local plyCoords = GetEntityCoords(ply)
        MySQL.Async.execute('UPDATE characters SET accounts = @accounts WHERE steamhex = @identifier AND charid = @charid', {
            ["@accounts"] = json.encode(player.Player.money),
            --["@coords"] = json.encode(plyCoords),
            ["@identifier"] = player.steamId,
            ["@charid"] = player.Player.activeCharId
        }, function(updates) end)
        print("[CORE][SAVE] Succesfully saved player CharID:".. player.Player.activeCharId.." NAME:".. player.getName()) 
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

local error_codes_defined = {
	[200] = 'OK - The request was completed successfully..!',
	[400] = "Error - The request was improperly formatted, or the server couldn't understand it..!",
	[401] = 'Error - The Authorization header was missing or invalid..! Your Discord Token is probably wrong or does not have correct permissions attributed to it.',
	[403] = 'Error - The Authorization token you passed did not have permission to the resource..! Your Discord Token is probably wrong or does not have correct permissions attributed to it.',
	[404] = "Error - The resource at the location specified doesn't exist.",
	[429] = 'Error - Too many requests, you hit the Discord rate limit. https://discord.com/developers/docs/topics/rate-limits',
	[502] = 'Error - Discord API may be down?...'
};

function GetDiscordRoles(user)
	local discord = getDiscordId(user)
	local discId = string.gsub(discord, "discord:", "")
	print(discId)
	if discId then
		local jsondata = {}
		local discPly
		local bot = "Bot " ..cfg.DiscordBotToken
		--local endpoint = "guilds/"..cfg.DiscordGuildId.."/members/"..discId..""
		local endpoint = ("guilds/%s/members/%s"):format(cfg.DiscordGuildId, discId)
		PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
		discPly = {data=resultData, code=errorCode, headers=resultHeaders} end, 
		"GET", #jsondata > 0 and json.encode(jsondata) or "", 
		{["Content-Type"] = "application/json", ["Authorization"] = bot})

		while discPly == nil do
			Citizen.Wait(0)
		end

		if discPly.code == 200 then
			local data = json.decode(discPly.data)
			local roles = data.roles
			local found = true
						print("returned")
			return roles
		else
			print("[Framework] ERROR: Code 200 was not reached... Returning false. [Member Data NOT FOUND] DETAILS: " .. error_codes_defined[discPly.code])
			return false
		end
	else
		print("[Framework] ERROR: Discord was not connected to user's Fivem account...")
		return false
	end
	return false
end

RegisterServerEvent('core:getServer')
AddEventHandler('core:getServer', function(cb)
    cb(Core)
end)

function coreReceiveServer()
    return Core
end