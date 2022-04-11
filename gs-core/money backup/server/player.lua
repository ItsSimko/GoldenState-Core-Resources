Core = {}

print("core players.lua loaded")

Core.Players = {}

function createPlayer(steamid, sid)
    local ply = {}
    ply.Player = {}
    ply.variables = {}

    ply.steamId = steamid
    ply.serverId = sid

    ply.getActiveChar = function()
        return ply.Player
    end

    ply.setChar = function(cid ,fname, lname, dept, sex, dob, accounts)
        ply.Player.activeCharId = cid
        ply.Player.firstName = fname
        ply.Player.lastName = lname
        ply.Player.department = dept
        ply.Player.sex = sex
		ply.Player.dob = dob
        ply.Player.money = {accounts.cash, accounts.bank}
    end

    ply.getName = function()
        return ply.Player.firstName, ply.Player.lastName
    end

    ply.getSteam = function()
        return ply.steamId
    end

    ply.getServerId = function()
        return ply.serverId
    end

    ply.set = function(k, v)
		ply.variables[k] = v
	end

    return ply
end
