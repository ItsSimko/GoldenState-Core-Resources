Config = {}
Config.ShowUnlockedText = true
Config.CheckVersion = true
Config.CheckVersionDelay = 60 -- Minutes
Config.KeybingText = 'Interact with a door lock'

Config.DoorList = {}


-- SSPD Cell #1
table.insert(Config.DoorList, {
	objHeading = 119.97119903564,
	lockpick = false,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(1846.645, 3685.48, 34.40243),
	objHash = 631614199,
	maxDistance = 2.0,
	garage = false,
	authorizedJobs = { ['LSPD']=0, ['SAST']=0, ['BCSO']=0 },
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- SSPD Cell #2
table.insert(Config.DoorList, {
	objHeading = 119.97119903564,
	lockpick = false,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(1844.865, 3688.567, 34.40243),
	objHash = 631614199,
	maxDistance = 2.0,
	garage = false,
	authorizedJobs = { ['LSPD']=0, ['SAST']=0, ['BCSO']=0 },
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- SSPD Front Door
table.insert(Config.DoorList, {
	objHeading = 29.971229553223,
	lockpick = false,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(1855.702, 3683.896, 34.58652),
	objHash = -1765048490,
	maxDistance = 2.0,
	garage = false,
	authorizedJobs = { ['LSPD']=0, ['SAST']=0, ['BCSO']=0 },
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- SSPD Back Door
table.insert(Config.DoorList, {
	objHeading = 209.97125244141,
	lockpick = false,
	slides = false,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(1854.107, 3700.163, 34.40295),
	objHash = 452874391,
	maxDistance = 2.0,
	garage = false,
	authorizedJobs = { ['LSPD']=0, ['SAST']=0, ['BCSO']=0 },
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})