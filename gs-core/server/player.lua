Core.Players = {}

function createPlayer(steamid, sid)
    local ply = {}
    ply.Player = {}
    ply.variables = {}
	ply.money = {}

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
		ply.Player.money = {}
        ply.Player.money.cash = accounts.cash
		ply.Player.money.bank = accounts.bank
        TriggerClientEvent("core:SetStats",ply.serverId ,"MP0_WALLET_BALANCE", accounts.cash)
        TriggerClientEvent("core:SetStats",ply.serverId ,"BANK_BALANCE", accounts.bank)
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
	
	ply.money.getAccounts = function()
		return ply.Player.money
	end
	
	ply.money.removeCash = function(amount)
		ply.Player.money.cash = ply.Player.money.cash - amount
        TriggerClientEvent("core:SetStats", ply.serverId,"MP0_WALLET_BALANCE", ply.Player.money.cash)
	end

	ply.money.addCash = function(amount)
		ply.Player.money.cash = ply.Player.money.cash + tonumber(amount)
        TriggerClientEvent("core:SetStats", ply.serverId,"MP0_WALLET_BALANCE", ply.Player.money.cash)
	end
	
	ply.money.addBank = function(amount)
        print(amount)
		ply.Player.money.bank = ply.Player.money.bank + amount
        TriggerClientEvent("core:SetStats", ply.serverId ,"BANK_BALANCE", ply.Player.money.bank)
	end
	
	ply.money.removeBank = function(amount)
		ply.Player.money.bank = ply.Player.money.bank - amount
        TriggerClientEvent("core:SetStats", ply.serverId ,"BANK_BALANCE", ply.Player.money.bank)
	end
	

    return ply
end
