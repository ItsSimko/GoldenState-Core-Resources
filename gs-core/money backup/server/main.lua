Citizen.CreateThread(function()
    SetGameType('Roleplay')
end)

RegisterServerEvent('core:playerJoined')
AddEventHandler('core:playerJoined', function()
    local _src = source
    local player = createPlayer(getSteamID(_src), _src)
    local playerIdentifier = getSteamID(_src)
        
    Core.Players[_src] = player
    
    MySQL.Async.fetchAll('SELECT * FROM characters WHERE steamhex = @ident',{
        ['@ident'] = playerIdentifier
    }, function(results)
        local discordItems = GetDiscordRoles(_src)
        TriggerClientEvent('core:openCharSelection', _src, json.encode(results), json.encode(discordItems))
    end)
end)

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    deferrals.defer()
    local _src = source
    Citizen.Wait(100)

    local srcIdent = getSteamID(_src)

    if srcIdent then
        deferrals.done()
    else
        deferrals.done('You do not have your steam connect, please make sure steam is open and attempt to open your game again. \n Error code: missing-steam \n\n If you continue to have issues please join discord.gg/hZ5b7AuBbF and someone will be hapy to help.')
    end
end)

AddEventHandler('playerDropped', function(reason)
    local _src = source
    local ply = Core.Player.getPlayerFromId(_src)
    
    if ply then
        Core.savePlayer(ply)
        Core.Players[_src] = nil
    end
end)

RegisterServerEvent('core:dc')
AddEventHandler('core:dc', function()
    local _src = source
    DropPlayer(_src, "Leaving game via character screen.")
end)

RegisterServerEvent('core:getChars')
AddEventHandler('core:getChars', function(type)
    local _src = source
    local playerIdentifier = getSteamID(_src)

    MySQL.Async.fetchAll('SELECT * FROM characters WHERE steamhex = @ident',{
        ['@ident'] = playerIdentifier
    }, function(results)
        if type == "refresh" then
            local discordItems = GetDiscordRoles(_src)
            TriggerClientEvent('core:refreshChars', _src, json.encode(results), json.encode(discordItems))
        else
            local discordItems = GetDiscordRoles(_src)
            TriggerClientEvent('core:openCharSelection', _src, json.encode(results), json.encode(discordItems))
        end
    end)
end)

RegisterServerEvent("core:deleteChar")
AddEventHandler("core:deleteChar", function(charId)
    local _src = source
    local playerIdentifier = getSteamID(_src)

    MySQL.Async.execute('DELETE FROM characters WHERE steamhex = @ident AND charid = @id',{
        ['@ident'] = playerIdentifier,
        ['@id'] = charId
    }, function(changes) print(changes) end)
end)

RegisterServerEvent('core:aopChange')
AddEventHandler('core:aopChange', function(AOP)
    TriggerClientEvent('core:aopUpdate', AOP)
end)

RegisterServerEvent('core:selectChar')
AddEventHandler('core:selectChar', function(data)
    local _src = source
    local cid = data.charid
    local spawn = data.loc
    local ply = Core.Player.getPlayerFromId(_src)
    MySQL.Async.fetchAll('SELECT * FROM characters WHERE steamhex = @ident AND charid = @id', {
        ["@ident"] = getSteamID(_src),
        ["@id"] = cid
    }, function(char)    
         TriggerClientEvent('core:spawnPlayer', _src, spawn, json.encode(char))
         if char[1].accounts == nil then
            char[1].accounts = {cash = cfg.startingCash, bank = cfg.startingBank}
         end
         ply.setChar(cid, char[1].fname, char[1].lname, char[1].department, char[1].sex, char[1].dob, char[1].accounts)
     end)

     --TriggerEvent('phone:playerLoaded', _src)

end)


RegisterServerEvent('core:registerChar')
AddEventHandler('core:registerChar', function(charData)
    local _src = source
	local playerIdentifier = getSteamID(_src)

    MySQL.Async.execute('INSERT INTO characters (steamhex, fname, lname, dob, sex, department) VALUES (@hex, @fname, @lname, @dob, @sex, @department)', {
        ['@hex'] = playerIdentifier,
        ['@fname'] = charData.fname,
        ['@lname'] = charData.lname,
        ['@dob'] = charData.dob,
        ['@sex'] = charData.sex,
        ['@department'] = charData.dept
    }, function(changes) end)

end)

function getSteamID(_src)
    for k,v in ipairs(GetPlayerIdentifiers(_src)) do
		if string.match(v, 'steam:') then 
			do return v end
            break
		end
	end
end
