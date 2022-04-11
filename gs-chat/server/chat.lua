Core = nil

TriggerEvent('core:getServer', function(obj)
    Core = obj
end)

AddEventHandler('chatMessage', function(source, name, message)
    CancelEvent()
    local _src = Core.Player.getPlayerFromId(source)
    local ply = _src.getActiveChar()
    if isCommand(message) == false then
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<b style="font-size: 18px;">{0}</b><span style="font-size:18px;">: {1}</span>',
            args = {ply.firstName.." "..ply.lastName.." (#"..source..")", message}
        })
    end
end)

RegisterCommand('twt', function(source, args, user)
    local ply = Core.Player.getPlayerFromId(source)
    local plyInfo = ply.getActiveChar()
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.25vw; background-color: rgba(28, 160, 242, 0.6); color: white; border-radius: 3px;"><i class="fab fa-twitter "style="font-size:17px;color:white"></i><font color="white" style="font-size:17px;"> @{0}: </font><font color="white" style="font-size: 17px;">{1}</font>',
        args = {plyInfo.firstName..' '..plyInfo.lastName..' (#'..ply.getServerId()..')', table.concat(args, " ")}
    })
end, false)

RegisterCommand('meglobal', function(source, args, user)
    local ply = Core.Player.getPlayerFromId(source)
    local plyInfo = ply.getActiveChar()
    TriggerClientEvent('chat:addMessage', -1,{
        color = { 100, 200, 255},
        multiline = true,
        template = '<b style="font-size: 18px;">{0}:</b><span style="font-size:18px;"> {1}</span>',
        args = {"[Global-ME]"..plyInfo.firstName.." "..plyInfo.lastName.." (#"..source..")", "" ..table.concat(args, " ")}
    })
end)

RegisterCommand('ooc', function(source, args, user)
    local ply = Core.Player.getPlayerFromId(source)
    local plyInfo = ply.getActiveChar()
    TriggerClientEvent('chat:addMessage', -1,{
        multiline = true,
        template = '<b style="font-size: 18px; color:DimGrey;">{0}:</b><span style="font-size:18px; color:DimGrey;"> {1}</span>',
        args = {"~c~[OOC] "..GetPlayerName(source).." (#"..source..")", "" ..table.concat(args, " ")}
    })
end)

function isCommand(s)
    local firstLetter = string.sub(s, 1, 1)
    
    if firstLetter == "/" then
        return true
    else
        return false
    end

end

