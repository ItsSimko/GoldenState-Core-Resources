Core = nil

TriggerEvent('core:getServer', function(data) Core = data end)

RegisterCommand('showid', function(source, args, rawCommand)
    if args[1] == nil then
        TriggerClientEvent('id:showIdClosest', source)
    else
        if DoesEntityExist(GetPlayerPed(args[1])) then
            TriggerClientEvent('id:showIdExact', tonumber(args[1]), Core.Player.getPlayerFromId(source))
        else
            TriggerClientEvent('chat:addMessage', source, {
                args = {"~r~Invalid Player ID!"}
              })
        end
    end
end)

RegisterCommand('viewid', function(source, args, rawCmd)
    TriggerClientEvent('id:showIdExact', source, Core.Player.getPlayerFromId(source))
end)

RegisterServerEvent('id:hasId')
AddEventHandler('id:hasId', function(returnPlayer)
    TriggerClientEvent('id:hasIdNoti', returnPlayer)
end)

RegisterServerEvent('id:toFar')
AddEventHandler('id:toFar', function(returnPlayer)
    TriggerClientEvent('id:toFarNoti', returnPlayer)
end)
