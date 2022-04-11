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
        local DeptsAllowed = {} 
        local AllowedChars = {}


        for v, Data in pairs(cfg.Departments) do
            if Data.DiscordRoleId ~= nil then
                for i = 1, #discordItems do
                    if Data.DiscordRoleId == discordItems[i] then
                        DeptsAllowed[v] = Data
                    end
                end
            else
                DeptsAllowed[v] = Data
            end
        end

        TriggerClientEvent('core:openCharSelection', _src, json.encode(results), json.encode(DeptsAllowed))
    end)
end)

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    deferrals.defer()
    local _src = source
    Citizen.Wait(100)

    local srcSteam = getSteamID(_src)
    local srcDisc = getDiscordId(_src)
    print(srcDisc)

    if srcSteam ~= nil and srcDisc ~= nil then
        deferrals.done()
    else
        deferrals.done(cfg.NoSteamorDiscord)
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
            local DeptsAllowed = {} 

            for v, Data in pairs(cfg.Departments) do
                if Data.DiscordRoleId ~= nil then
                    for i = 1, #discordItems do
                        if Data.DiscordRoleId == discordItems[i] then
                            DeptsAllowed[v] = Data
                        end
                    end
                else
                    DeptsAllowed[v] = Data
                end
            end

            TriggerClientEvent('core:refreshChars', _src, json.encode(results), json.encode(DeptsAllowed))
        else
            local discordItems = GetDiscordRoles(_src)
            local DeptsAllowed = {} 

            for v, Data in pairs(cfg.Departments) do
                if Data.DiscordRoleId ~= nil then
                    for i = 1, #discordItems do
                        if Data.DiscordRoleId == discordItems[i] then
                            DeptsAllowed[v] = Data
                        end
                    end
                else
                    DeptsAllowed[v] = Data
                end
            end

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
        local discordItems = GetDiscordRoles(_src)
        local plyDept = char[1].department
        local deptData = cfg.Departments[plyDept] 
        local permToPlayChar= false

        for i=1, #discordItems do 
            if deptData.DiscordRoleId ~= nil then
                if deptData.DiscordRoleId == discordItems[i] then
                    permToPlayChar = true
                    break
                end
            else
                permToPlayChar = true
            end
        end

        if permToPlayChar == true then
            TriggerClientEvent('core:spawnPlayer', _src, spawn, json.encode(char))
			ply.setChar(cid, char[1].fname, char[1].lname, char[1].department, char[1].sex, char[1].dob, json.decode(char[1].accounts))
        else
            TriggerClientEvent("core:sendNui", _src, json.encode{type="error", errormsg=cfg.FailedCharPermision})
        end

     end)
end)


RegisterServerEvent('core:registerChar')
AddEventHandler('core:registerChar', function(charData)
    local _src = source
	local playerIdentifier = getSteamID(_src)
    local discordItems = GetDiscordRoles(_src)
    local cData = json.decode(charData)
    local charDept = cfg.Departments[cData.dept]
    local permToRegisterDept = false

    for i=1, #discordItems do 
        if charDept.DiscordRoleId ~= nil then
            if charDept.DiscordRoleId == discordItems[i] then
                permToRegisterDept = true
                break
            end
        else
            permToRegisterDept = true
        end
    end

    if permToRegisterDept == true then
        MySQL.Async.execute('INSERT INTO characters (steamhex, fname, lname, dob, sex, department, accounts) VALUES (@hex, @fname, @lname, @dob, @sex, @department, @accounts)', {
            ['@hex'] = playerIdentifier,
            ['@fname'] = cData.fname,
            ['@lname'] = cData.lname,
            ['@dob'] = cData.dob,
            ['@sex'] = cData.sex,
            ['@department'] = cData.dept,
            ['@accounts'] = json.encode{cash = cfg.startingCash, bank = cfg.startingBank}
        }, function(changes) end)
    else
        TriggerClientEvent("core:sendNui", json.encode{type="error",errormsg=cfg.NoRegisterPerms})
    end
end)

RegisterServerEvent("core:switchChar")
AddEventHandler("core:switchChar", function()
	local src = source
	local ply = Core.Player.getPlayerFromId(src)
	
	Core.savePlayer(ply)

end)

AddEventHandler("onResourcestop", function(resourceName)
	for i=1, #cfg.resToRestart do
        ExecuteCommand("restart ".. cfg.resToRestart[i])
    end

end)

function getSteamID(_src)
    for k,v in ipairs(GetPlayerIdentifiers(_src)) do
		if string.match(v, 'steam:') then 
			do return v end
            break
		end
	end
end

function getDiscordId(_src)
    for k,v in ipairs(GetPlayerIdentifiers(_src)) do
		if string.match(v, "discord:") then
			do return v end
			break
		end
	end
end