cfg = {}

cfg.DiscordGuildId = "709830957779255328" -- put your discord severs guild here
cfg.DiscordBotToken = "NzM5NjkxMDU3MTIxMzI5MjMz.XyeI-g.3oJipaqNIRYdNZIyRjcGkC4mNvM"
cfg.DiscordLink = "discord.gg/hZ5b7AuBbF" -- Put your discord linke here
cfg.ServerName = "Golden State RP" -- Put your server name here

cfg.DiscordChatLogs = true -- IF you want chat to be logged to a webhook
cfg.DiscordChatWebhook = "" -- place the webhook of the channel for chat logs. 

cfg.UseCustomChat = true -- use the custom chat format from the resource, note chat script is open source for you to edit.
cfg.GlobalMeCmd = "meglobal" -- command for the globalme command, on works if CustomChat is enabled
cfg.TwitterCmd = "twt" -- command for the twitter command, on works if CustomChat is enabled
cfg.OocCmd = "ooc" -- command for the out of charchter command, on works if CustomChat is enabled
cfg.ChatCharacterName = true -- if true chat messages will be sent with the users framework name ie; ""John Doe: I love pizza!"


cfg.UseMoney = true -- toggles the economy/money aspect of the framework. The framework still ceates econonmy tables in case it is turned on to prevent errors.
cfg.startingBank = 25000 -- the amount players start with in da bank
cfg.startingCash = 500 -- the amount of cash players start with
cfg.MoneyCmd = "money" -- the command so the player can view their balances, or "/MoneyCmd hud" to toggle the HUD on or off.

-- This is the error presented when the player doesnt have the discord roles for the department and trys to play.
cfg.FailedCharPermision = "It seems you have lost permission to play as this charachter. If you belive this is an error make sure you have discord connected. If problems continue contanct administration."

-- If a player trys to register as a department they shouldnt have, the error that will be displayed.
cfg.NoRegisterPerms = "You do not have permission to register as the department selected, please refresh. If you belive this is an error make sure you have the corresponding discord roles, or contact administration."

--message to be displayed when some one tries to connect without steam or discord connected.
cfg.NoSteamorDiscord = "You do not have your steam or discord connected, please make sure steam & discord is open and attempt to open your game again. \n Error code: missing-steam-or-discord \n\n If you continue to have issues please join discord.gg/hZ5b7AuBbF and someone will be hapy to help."

    --resources the framework should restart, when it self is restarted. Useful for scripts that use charadata, something like a store script.
cfg.resToRestart = {
    "",
    "",
    ""
}


cfg.Departments = {
    --[[
    ["MAKE THIS TE SAME AS DeptAbv] = {
        DeptName = "San Andreas State Troopers", -- ANY NAME YOU WANT
        DeptAbv = "SAST", -- CAN NOT BE MORE THAN 4 CHARS
        SpawnPoint = {
            {x=sumcord, y=sumcord, z=sumcord, label="Spawnpoint Label"}, 
            {x=sumcord2, y=sumcord2, z=sumcord2, label="Spawnpoint Label2"},
        }, -- SPAWNPOINTS THAT WILL BE AVAILBLE FOR THE department
        DiscordRoleId = "Insert Discord ID if you want it to be whitelist or delete line for no white list", -- SELF EXPLANTORY
    },
    --]]
    ["SAST"] = {
        DeptName = "San Andreas State Troopers",
        DeptAbv = "SAST",
        SpawnPoint = {
            {x=2506.297, y=-384.514, z=94.125, label="SAST Headquarters"},
            {x=-447.307, y=6009.122, z=32.616, label="Paleto Bay Substation"},
            {x=823.94, y=-1290.15, z=28.24, label="La Mesa Substation"},
        },
        DiscordRoleId = "709830958215463002"
    },
    ["LSPD"] = {   
        DeptName = "Los Santos Police Department",
        DeptAbv = "LSPD",
        SpawnPoint = {
            {x=458.7, y=-997.94, z=30.69, label="Mission Row Police Station"},
            {x=-1062.849, y=-848.1111, z=5.0415, label="Vespucci Police Station"},
            {x=823.94, y=-1290.15, z=28.24, label="La Mesa Police Station"},
            {x=-1632.07, y=-1015.5, z=13.13, label="Del Perro Substation"},
            {x=1849.388, y=3689.164, z=34.270, label="Sandy Shores Sheriff Station"}
        },
        DiscordRoleId = "709830958244954137"
        },
    ["BCSO"] = {
        DeptName = "Blaine County Sheriff County",
        DeptAbv = "BCSO",
        SpawnPoint = {
            {x=1849.388, y=3689.164, z=34.270, label="Sandy Shores Sheriff Station"},
            {x=-447.307, y=6009.122, z=32.616, label="Paleto Bay Sheriff Station"},
            {x=374.245, y=-1608.263, z=29.292, label="Davis Substation"},
            {x=387.12, y=791.92, z=187.69, label="Wildlife Rangers Station"}
        },
        DiscordRoleId = "709830958232371207"
    },
    ["SAFR"] = {
        DeptName = "San Andreas Fire Department",
        DeptAbv = "SAFR",
        SpawnPoint = {
            {x=-362.294, y=6130.17, z=31.4402, label="Station 3, Paleto Bay"},
            {x=1690.56, y=3581.49, z=35.62, label="Station 2, Sandy Shores"},
            {x=-640.5, y=-120.2, z=38.2138, label="Station 1, Rockford Hills"},
            {x=1207.95, y=-1461.68, z=38.8434, label="Station 7, El Burro Heights "},
            {x=218.38, y=-1646.74, z=29.77, label="Station 6, Davis"}
        },
        DiscordRoleId = "709830958211137556"
    },
    ["CIV"] = {
        DeptName = "Civilians of San Andreas",
        DeptAbv = "CIV",
        SpawnPoint = {
        {x=386.68, y=3594.23, z=33.29, label="Marina drive, Sandy Shores"},
        {x=2044.86, y=3445.24, z=43.78, label="Nowhere road, Sandy Shores"},
        {x=-197.66, y=6532.66, z=11.1, label="Procopio Promenade, Paleto Bay"},
        {x=-400.99, y=1209.89, z=325.94, label="Galileo Observatory, Los Santos"},
        {x=-197.66, y=6532.66, z=11.1, label="Vinewood Racetrack, Los Santos"},
        {x=-197.66, y=6532.66, z=11.1, label="Del Perro Beach, Los Santos"}
        },
        -- no discord role id cause civ is public
    }
}
