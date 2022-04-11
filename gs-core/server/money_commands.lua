RegisterCommand("money", function(src, args, raw)
	local ply = Core.Player.getPlayerFromId(src)
    
    local type = args[1]
    
    if type ~= nil then
        if string.lower(type) == "hud" then
            TriggerClientEvent("core:MoneyHud", src, "toggle")
        end
    else
        TriggerClientEvent("core:MoneyHud", src, "flash")
    end
end)

RegisterCommand("addmoney", function(s, a, r)
    local ply = Core.Player.getPlayerFromId(s)
    local amnt = tonumber(a[2])
    if a[1] == "bank" then
    print(amnt)
        ply.money.addBank(amnt)
    elseif a[1] == "cash" then
       ply.money.addCash(amnt)
    end
end)

RegisterCommand("removemoney", function(s, a, r)
    local ply = Core.Player.getPlayerFromId(s)
    if a[1] == "bank" then
        ply.money.removeBank(a[2])
    elseif a[1] == "cash" then
       ply.money.removeCash(a[2])
    end
end)

RegisterCommand("wire", function(src,args,raw)    
    local ply = Core.Player.getPlayerFromId(src)
    
    if (args[1] == nil or args[2] == nil) then
            TriggerClientEvent("chat:addMessage", src, {
                template = '<height="16"> <b>{0}:</b> {1}',
                args = {"~r~Bank of San Andreas", "wire failed due to invalid arguments, \"/wire [playerId] [amount]\""}
            })
    else
        local zPly = Core.Player.getPlayerFromId(args[1])

        if zPly ~= nil then
            local amnt = args[2]
            TriggerClientEvent("chat:addMessage", src, {
                template = '<div style="padding: 0.25vw; background-color: rgba(0, 225, 0, 0.6); color: white; border-radius: 3px; text-align:center;"> &ensp; <font color="white" >{1}</font></div>',
                args = {"", "Wire transfer of "..amnt.." to ".. zPly.Player.firstName.. " ".. zPly.Player.lastName.. " successful."}
            })
            ply.removeBank(amnt)
            zPly.addBank(amnt)
        else
            TriggerClientEvent("chat:addMessage", src, {
                template = '<div style="padding: 0.25vw; background-color: rgba(255, 0, 0, 0.6); color: white; border-radius: 3px; text-align:center;"> &ensp; <font color="white" >{1}</font></div>',
                args = {"", "Wire transfer of $".. args[2].." incomplete to account id "..args[1].."."}
            })
        end
    end

end)