local Version = "1.8.6"
local isDev = false

-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Senzaa/MeltinHub/main/MeltinHub.lua", true))()

-- Cloneref support (adds support for JJsploit/Temple/Electron and other sploits that don't have cloneref or really shit versions of it.)
--loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/CloneRef.lua", true))()

-- Dex Bypasses
--loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/Bypasses.lua", true))()

local BaseUrl = isDev and "http://azv.ddns.net/MeltinHub/" or "https://raw.githubusercontent.com/Senzaa/MeltinHub/main/"

-- Common anti-cheats bypass
loadstring(game:HttpGet(BaseUrl .. "AnticheatBypass.lua", true))()

if not cloneref then
	warn("no cloneref implementation found, severe performance hindering")
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/CloneRef.lua", true))()
end

function _G.SafeGetService(service)
    return cloneref(game:GetService(service))
end

print("MeltinHub " .. Version .. ", Game ID =", game.GameId)
if isDev then
	warn("MeltinHub is in Development mode!")
end

local plr = _G.SafeGetService("Players").LocalPlayer

_G.NUKE_KICKATTEMPTS = false

local repository = {
	[1903935756] = "Lucky-Block-Tycoon.lua",
	[1310079979] = "Lucky-Block-Tycoon.lua",
	[228573408] = "Lucky-Block-Tycoon.lua",
	[383310974] = "AdoptMe.lua",
	[1681168130] = "Cart-Ride-Into-Rdite.lua",
	[873703865] = "Westbound.lua",
	[703124385] = "Tower-Of-Hell.lua",
	[12454828] = "RobloxTalentShow/Roblox-Talent-Show.lua",
	[2316994223] = "Pet-Simulator-X.lua",
	[770538576] = "Naval-Warfare.lua",
	[2946564974] = "Impossible-Obby.lua",
	[225431369] = "Fashion-Famous.lua",
	[22016281] = "Solar-Conquest-2.lua",
	[1499870257] = "GRG.lua",
	[2142948266] = "Project-Slayers.lua",
	[3183403065] = "AnimeAdventures.lua",
	[2788648141] = "MilitaryTycoon.lua",
	[1415710834] = "Banana-Eats.lua",
	[4483760934] = "Minecraft.lua",
	[4337267189] = "Minecraft.lua",
	[3314547819] = "Refinery-Caves.lua",
	[4034899513] = "ScamTycoon.lua",
	[2492481398] = "NoobArmyTycoon1.lua",
	[4201860712] = "CarFactoryTycoon.lua",
	[111958650] = "Arsenal.lua",
	[1686885941] = "Brookhaven.lua",
	[3149100453] = "EatBlobsSimulator.lua",
	[3647333358] = "Evade.lua",
	[4363131662] = "Worm2048.lua",
	[4147392742] = "YeetAFriend.lua",
	[47545] = "PizzaPlace.lua",
	[2406494408] = "SpeedRunner.lua",
	[504035427] = "ZombieAttack.lua",
	[66654135] = "MurderMystery2.lua",
	[539067902] = "ArmoredPatrol.lua",
	[4523856444] = "ColorOrDie.lua",
	[3056160040] = "FindTheMarkers.lua",
	[4382992762] = "Minecraft.lua",
	[372226183] = "FleeTheFacility.lua",
	[1001911915] = "FarmingAndFriends.lua",
	[4986566693] = "AnimeChampions.lua",
	[1802741133] = "CabinCrewSimulator.lua",
	[5219307126] = "Minecraft.lua"
}

--setclipboard(tostring(game.GameId))

local blacklisted = {
	[2142948266] = {
		TeleportToPlayer = true,
		Stalker = true
	}
}

_G.AIMBOT_DebugMode = false

_G.ESPModule_DontParent = {
	[3647333358] = true,
	[4523856444] = true
}

_G.COLOR3DEF = {
	WHITE = Color3.new(1, 1, 1),
	BLACK = Color3.new(0, 0, 0),
	RED = Color3.new(1, 0, 0),
	GREEN = Color3.new(0, 1, 0),
	BLUE = Color3.new(0, 0, 1)
}

function _G.Notify(text, title)
	game.StarterGui:SetCore("SendNotification", {
		Title = title or "Notification",
		Icon = "rbxassetid://6238540373",
		Text = text
	})
end

function _G.SystemChat(...)
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = table.concat({...}, " "),
		Color = Color3.new(1, 1, 0),
		Font = Enum.Font.Roboto
	})
end

function _G.StrFixedLength(str, length)
	if #str < length then
		str = str .. string.rep(" ", length - #str)
	end
	return str
end

setreadonly(string, false)
function string.NeedsQuotas(self)
	return (self:match("^%d") or self:match("[^%a%d_]")) and true or false
end

function _G.Stringify(obj, no_quotas)
	if not obj then return "nil" end
	if typeof(obj) == "string" then
		return no_quotas and obj or '"' .. obj .. '"'
	elseif type(obj) == "userdata" then
		if typeof(obj) ~= "Instance" then
			return typeof(obj) .. ".new(" .. tostring(obj) .. ")"
		else
			local parts = {}
			local instance = obj
			while instance ~= nil do
				table.insert(parts, 1, instance.Name)
				instance = instance.Parent
			end
			return table.concat(parts, ".")
		end
	end
	return tostring(obj)
end

local function GetTableCount(tab)
	local count = 0
	if type(tab) == "table" then
		for k,v in next, tab do
			count += 1
		end
	end
	return count
end

function _G.Discover(obj, maxDepth, depth)
	depth = depth or 0
	maxDepth = maxDepth or 100
	if maxDepth == depth then return end
	
	if type(obj) == "table" then
		if GetTableCount(obj) > 0 then
			depth += 1
			local parts = {}
			for k, v in pairs(obj) do
				if k ~= "__index" then
					local f, err = pcall(function()
						local discovery = _G.Discover(v, maxDepth, depth)
						if discovery ~= nil then
							table.insert(parts,
								tostring(k):NeedsQuotas() and
								string.format("%s[%s] = %s",
									string.rep("\t", depth),
									_G.Stringify(k),
									discovery
								) or
								string.format("%s%s = %s",
									string.rep("\t", depth),
									_G.Stringify(k, true),
									discovery
								)
							)
						else
							warn("Out of memory")
							return nil
						end
					end)
					if not f then
						warn(err)
						return nil
					end
				end
			end
			return "{\n" .. table.concat(parts, ",\n") .. "\n" .. string.rep("\t", math.max(0, depth-1)) .. "}"
		else
			return "{}"
		end
	else
		return _G.Stringify(obj)
	end
end

function _G.SearchForName(obj, name, exact)
	obj = obj or game
	if not name then warn("No name given.") return end
	for k,v in pairs(obj:GetDescendants()) do
		if v and (v.Name == name or (not exact and v.Name:lower():find(name:lower()) or false) ) then
			warn(v:GetFullName() .. " (" .. (typeof(v) == "Instance" and v.ClassName or typeof(v)) .. ")" )
		end
	end
end

function _G.SearchForClassName(obj, className)
	obj = obj or game
	if not className then warn("No class name given.") return end
	for k,v in pairs(obj:GetDescendants()) do
		if v and v.ClassName == className then
			warn(v:GetFullName())
		end
	end
end

function _G.SearchForValue(obj, className, value)
	obj = obj or game
	if not className then warn("No class name given.") return end
	if not value then warn("No value given.") return end
	local results = {}
	for k,v in pairs(obj:GetDescendants()) do
		if v and v.ClassName == className and v.Value == value then
			table.insert(results, v)
		end
	end
	warn("Found " .. tostring(#results) .. " objects with value:")
	for k,v in pairs(results) do
		warn(v:GetFullName() .. " = " .. tostring(v.Value))
	end
end

function _G.TeleportPlayerTo(pos, facing)
	if not pos then return end
	if not plr or not plr.Character then return end
	--[[
	if game.Workspace.StreamingEnabled then
		local TargetPos = typeof(pos) == "CFrame" and pos.Position or pos
		plr:RequestStreamAroundAsync(TargetPos, 1)
	end
	]]
	local originalPos = plr.Character:GetPivot()
	if typeof(pos) == "CFrame" then
		plr.Character:PivotTo(pos)
	elseif typeof(pos) == "Vector3" then
		plr.Character:PivotTo(facing and CFrame.new(pos, facing) or CFrame.new(pos) * plr.Character:GetPivot().Rotation)
	end
	return originalPos
end

function _G.AimCameraAt(pos)
	if not pos then return end
	if not game.Workspace.CurrentCamera then return end
	local camera = game.Workspace.CurrentCamera
	local old = camera.CameraType
	camera.CameraType = Enum.CameraType.Scriptable
	camera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.Position, pos)
	camera.CameraType = old
end

function _G.SetCharAnchored(anchored)
	if not plr or not plr.Character then return end
	local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
	if not human or not human.RootPart then return end
	human.RootPart.Anchored = anchored
end

function _G.DisableSignal(signal)
	for k,v in pairs(getconnections(signal)) do
		v:Disable()
	end
end

function _G.EnableSignal(signal)
	for k,v in pairs(getconnections(signal)) do
		v:Enable()
	end
end

function _G.TouchObject(object)
	if not object then return end
	--if not object or not object:FindFirstChildWhichIsA("TouchTransmitter") then return end
	if plr.Character then
		local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
		if human and human.RootPart then
			firetouchinterest(human.RootPart, object, 0)
			firetouchinterest(human.RootPart, object, 1)
			return true
		end
	end
end

function _G.TouchObjects(objectA, objectB)
	if not objectA or not objectB then return end
	--if not objectB:FindFirstChildWhichIsA("TouchTransmitter") then return end
	firetouchinterest(objectA, objectB, 0)
	firetouchinterest(objectA, objectB, 1)
	return true
end

function _G.ScriptSearch_CopyResults(target)
	if _G.SCRIPTSEARCH_RESULTS and target then
		local resultsFolder = target:FindFirstChild("ScriptSearchResults") or Instance.new("Folder", target)
		resultsFolder.Name = "ScriptSearchResults"
		resultsFolder:ClearAllChildren()
		for k,v in pairs(_G.SCRIPTSEARCH_RESULTS) do
			local copy = v:Clone()
			copy.Name = v:GetFullName()
			copy.Parent = resultsFolder
		end
	end
end

if not _G.SCRIPTSEARCH_STATUS then
	_G.SCRIPTSEARCH_STATUS = Drawing.new("Text")
end
function _G.StopScriptSearch()
	_G.SCRIPTSEARCH = false
	_G.SCRIPTSEARCH_STATUS.Visible = false
	_G.SCRIPTSEARCH_STATUS.Size = 24
	_G.SCRIPTSEARCH_STATUS.Center = true
	_G.SCRIPTSEARCH_STATUS.Color = Color3.new(1, 1, 1)
	_G.SCRIPTSEARCH_STATUS.Outline = true
	_G.SCRIPTSEARCH_STATUS.OutlineColor = Color3.new(0, 0, 0)
end
_G.StopScriptSearch()
function _G.ScriptSearch(text, ignoreCase, whitelist, blacklist)
	_G.StopScriptSearch()
	task.wait(1)
	_G.SCRIPTSEARCH = true
	_G.SCRIPTSEARCH_STATUS.Visible = true
	local found = {}
	local blacklisted
	local toSearch = game:GetDescendants()
	if whitelist then
		toSearch = {}
		for k,v in pairs(whitelist) do
			for _,child in pairs(v:GetDescendants()) do
				table.insert(toSearch, child)
			end
		end
	end
	for k,v in pairs(toSearch) do
		if v:IsA("LocalScript") or v:IsA("ModuleScript") then
			blacklisted = false
			if blacklist then
				for _,b in pairs(blacklist) do
					if v:IsDescendantOf(b) then
						blacklisted = true
						break
					end
				end
			end
			if not blacklisted then
				table.insert(found, v)
			end
		end
	end
	_G.SCRIPTSEARCH_RESULTS = {}
	local lastTime, timeNow, eta_s, eta_m = tick(), tick()
	for k, v in pairs(found) do
		if not _G.SCRIPTSEARCH then break end
		timeNow = tick()
		eta_s = math.floor((#found-k)*(timeNow-lastTime))
		eta_m = math.floor(eta_s/60)
		eta_s = eta_s - (eta_m*60)
		_G.SCRIPTSEARCH_STATUS.Position = game.Workspace.CurrentCamera.ViewportSize * .5
		_G.SCRIPTSEARCH_STATUS.Text = string.format("ScriptSearch :: %d / %d | ETA: %02dm:%02ds | FND: %d", k, #found, eta_m, eta_s, #_G.SCRIPTSEARCH_RESULTS)
		local code = decompile(v, 5)
		if (ignoreCase and code:lower():find(text:lower())) or (not ignoreCase and code:find(text)) then
			table.insert(_G.SCRIPTSEARCH_RESULTS, v)
		end
		lastTime = timeNow
		task.wait()
	end
	warn("Script search finished. Found", #_G.SCRIPTSEARCH_RESULTS, "results.")
	warn("List of found localscripts/modules is in _G.SCRIPTSEARCH_RESULTS")
	_G.StopScriptSearch()
end

function _G.LocalLoadAnimationTrack(animId)
	local anim = Instance.new("Animation")
	anim.AnimationId = animId
	if plr.Character then
		local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
		if human then
			local animator = human:FindFirstChildWhichIsA("Animator")
			if animator then
				return animator:LoadAnimation(anim)
			end
		end
	end
end

function loadCoreModule(address, moduleName)
	local f, err = loadstring(game:HttpGet(address, true), "="..(moduleName or "Unknown module"))
	if not f then
		warn("Failed to load core module '" .. address .. "':\n" .. err)
		return nil
	end
	return assert(f)()
end

local isSpectating = false
local isStalking = false

if _G.SenHub ~= nil then
	_G.SenHub:Destroy()
end

local gameModule = nil
local gameModuleConnections = {}
if game.GameId == 0 then
	repeat task.wait(0) until game.GameId ~= 0
end

_G.GAMEINFO = _G.SafeGetService("MarketplaceService"):GetProductInfo(game.PlaceId)

if repository[game.GameId] then
	gameModule = loadCoreModule(BaseUrl .. "Games/" .. repository[game.GameId], repository[game.GameId])
	if gameModule and gameModule.PreInit then
		local result, err = pcall(gameModule.PreInit)
		if not result then
			warn(_G.Discover(gameModule))
			warn("Failed Pre-Init: " .. tostring(err))
			error(err)
		else
			print("Pre-Init done")
		end
	end
end

if not plr then
	repeat
		task.wait()
		plr = game.Players.LocalPlayer
	until plr ~= nil
end

local mg = loadCoreModule(BaseUrl .. "MeltinGui.lua", "MeltinGui")
if not mg then warn("Could not load meltingui") return end

if not _G.IndexEmulatorLoaded then
	_G.IndexEmulator = loadCoreModule(BaseUrl .. "IndexEmulator.lua", "Index Emulator")
	if not _G.IndexEmulator then warn("Could not load index emulator") return end
	_G.IndexEmulatorLoaded = true -- uncomment for release, comment for debugging
end

if not _G.MethodEmulatorLoaded then
	_G.MethodEmulator = loadCoreModule(BaseUrl .. "MethodEmulator.lua", "Method Emulator")
	if not _G.MethodEmulator then warn("Could not load method emulator") return end
	_G.MethodEmulatorLoaded = true -- uncomment for release, comment for debugging
end

_G.MethodEmulator:SetMethodOverride(plr, "Kick", function(self, hook, message)
	warn("Intercepted kick attempt.")
	print("Kick message:", message)
	if NUKE_KICKATTEMPTS then
		return task.wait(10e1)
	end
end)

if not _G.MouseEmulatorLoaded then
	_G.MouseEmulator = loadCoreModule(BaseUrl .. "MouseEmulator.lua", "Mouse Emulator")
	if not _G.MouseEmulator then warn("Could not load mouse emulator") return end
	_G.MouseEmulatorLoaded = true -- uncomment for release, comment for debugging
end

if not _G.KeyboardEmulatorLoaded then
	_G.KeyboardEmulator = loadCoreModule(BaseUrl .. "KeyboardEmulator.lua", "Keyboard Emulator")
	if not _G.KeyboardEmulator then warn("Could not load keyboard emulator") return end
	_G.KeyboardEmulatorLoaded = true
end

--_G.Autopilot = loadCoreModule(BaseUrl .. "Autopilot.lua", "Autopilot")
--if not _G.Autopilot then warn("Could not load autopilot") return end

local aimbotModule = loadCoreModule(BaseUrl .. "AimbotModule.lua", "Aimbot Module")
if not aimbotModule then warn("Could not load aimbot module") return end

local espModule = loadCoreModule(BaseUrl .. "ESPModule_3.lua", "ESP Module")
if not espModule then warn("Could not load esp module") return end

local flightModule = loadCoreModule(BaseUrl .. "FlightModule.lua", "Flight Module")
if not flightModule then warn("Could not load flight module") return end

local UserInputService = _G.SafeGetService("UserInputService")

_G.SenHub = mg.New("MeltinHub v" .. tostring(Version) .. (isDev and " [DEV]" or ""))
if gethgui then
	_G.SenHub.Parent = gethgui()
else
    --_G.SenHub.Parent = cloneref(_G.SafeGetService("CoreGui"))
	_G.SenHub.Parent = game.CoreGui
end

local connections = {}

--[[
task.spawn(function() -- anti-lag
	repeat task.wait() until game:IsLoaded()
	local vim = _G.SafeGetService("VirtualInputManager")
	--setfpscap(60)
	
	_G.ANTILAG = true
	_G.ANTILAG_PAUSE = false
	
	table.insert(connections, game.CoreGui.DescendantAdded:Connect(function(child)
		if child.Name == "MainView" and child.Parent.Name == "DevConsoleUI" then
			task.wait()
			local screen = child.Parent.Parent.Parent
			screen.Enabled = _G.ANTILAG_PAUSE
		end
	end))
	
	vim:SendKeyEvent(true, "F9", 0, game)
	task.wait()
	vim:SendKeyEvent(false, "F9", 0, game)
	
	local paused = false
	while task.wait() and _G.ANTILAG do
		if _G.ANTILAG_PAUSE then
			if not paused then
				paused = true
				local devConsole = game.CoreGui:FindFirstChild("DevConsoleUI", true)
				if devConsole then
					local mainView = devConsole:FindFirstChild("MainView")
					if mainView then
						mainView.Parent.Parent.Parent.Enabled = true
					end
				end
			end
			continue
		end
		warn("")
		paused = false
		if not game.CoreGui:FindFirstChild("DevConsoleUI", true):FindFirstChild("MainView") then
			vim:SendKeyEvent(true, "F9", 0, game)
			task.wait()
			vim:SendKeyEvent(false, "F9", 0, game)
		end
	end
	local devConsole = game.CoreGui:FindFirstChild("DevConsoleUI", true)
	if devConsole then
		local mainView = devConsole:FindFirstChild("MainView")
		if mainView then
			mainView.Parent.Parent.Parent.Enabled = true
		end
	end
end)]]

local VUService = _G.SafeGetService("VirtualUser")
table.insert(connections, plr.Idled:Connect(function()
	VUService:ClickButton1(Vector2.new(0, 0), game.Workspace.CurrentCamera.CFrame)
end))
--_G.Notify("Anti-afk enabled", "Anti-afk")

local blacklistOptions = blacklisted[game.GameId] or {}

plr.CameraMaxZoomDistance = 1000

--[[if UserInputService.TouchEnabled then
	loadCoreModule(BaseUrl .. "AndroidPatches.lua", "AndroidPatches")
end]]

do -- 								CHARACTER CATEGORY
	local characterCategory = _G.SenHub:AddCategory("Character")
	
	local flightToggle, flightBalancer
	
	flightToggle = characterCategory:AddCheckbox("[LAlt] Flight", function(checked)
		flightModule.SetEnabled(checked)
		--flightBalancer.Visible = checked
	end)
	
	local flingToggle = characterCategory:AddCheckbox("[F4] Fling", function(checked)
		flightModule.SetFling(checked)
	end)
	flingToggle.Inline = true
	
	local aimbotToggle = characterCategory:AddCheckbox("[F7] Aimbot", function(checked)
		aimbotModule.SetEnabled(checked)
	end)
	
	table.insert(connections, UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Keyboard then
			if input.KeyCode == Enum.KeyCode.F4 then
				flingToggle:SetChecked(not flingToggle.Checked)
				flightModule.SetFling(flingToggle.Checked)
			elseif input.KeyCode == Enum.KeyCode.F7 then
				aimbotModule.SetEnabled(not aimbotModule.Enabled)
				aimbotToggle:SetChecked(aimbotModule.Enabled)
			end
		end
	end))
	
	flightToggle:SetChecked(true)

	local fBoost = nil
	local defaultStartBoost = 500
	fBoost = characterCategory:AddSlider("Flight Boost Speed", defaultStartBoost, 80, 20000, function(newValue)
		flightModule.BoostSpeed = newValue
	end)
	flightModule.BoostSpeed = defaultStartBoost
	
	local speedSlider = nil
	local jumpSlider = nil
	
	local defaultSpeed = 16
	local defaultJH = 7.2
	local defaultJP = 50
	local useJP = true
	
	if plr.Character then
		local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
		if human then
			defaultSpeed = human.WalkSpeed
			defaultJH = human.JumpHeight
			defaultJP = human.JumpPower
			useJP = human.UseJumpPower
		end
	end
	
	local lastSpeedVal = defaultSpeed
	speedSlider = characterCategory:AddSlider("WalkSpeed", defaultSpeed, 1, 1000, function(newValue)
		if plr.Character then
			local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
			if human then
				human.WalkSpeed = newValue
			end
			lastSpeedVal = newValue
		end
		--speedSlider.Text = "WalkSpeed: " .. tostring(newValue)
	end)
	
	local lastJumpVal = useJP and defaultJP or defaultJH
	jumpSlider = characterCategory:AddSlider("Jump Boost", useJP and defaultJP or defaultJH, 1, 500, function(newValue)
		if plr.Character then
			local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
			if human then
				if human.UseJumpPower then
					human.JumpPower = newValue
				else
					human.JumpHeight = newValue
				end
				lastJumpVal = newValue
			end
		end
		--jumpSlider.Text = (useJP and "JumpPower" or "JumpHeight")
	end)
	
	characterCategory:AddButton("Trip", function()
		if plr and plr.Character then
			local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
			if human then
				if human:GetState() ~= Enum.HumanoidStateType.Physics then
					human:ChangeState(Enum.HumanoidStateType.Physics)
					local animate = plr.Character:FindFirstChild("Animate")
					if animate then
						
					end
				else
					human:ChangeState(Enum.HumanoidStateType.GettingUp)
				end
			end
		end
	end)
	
	local saveValues = characterCategory:AddCheckbox("Save Slider Values")
	saveValues:SetChecked(true)
	
	local function updateCharMods(chr)
		repeat task.wait() until chr:FindFirstChildWhichIsA("Humanoid")
		local human = chr:FindFirstChildWhichIsA("Humanoid")
		if human then
			useJP = human.UseJumpPower
			
			if saveValues.Checked then
				human.WalkSpeed = lastSpeedVal
				if human.UseJumpPower then
					human.JumpPower = lastJumpVal
				else
					human.JumpHeight = lastJumpVal
				end
			end
			
			speedSlider:SetSliderValue(human.WalkSpeed)
			if human.UseJumpPower then
				jumpSlider:SetSliderValue(human.JumpPower)
			else
				jumpSlider:SetSliderValue(human.JumpHeight)
			end
			table.insert(connections, human.Changed:Connect(function(property)
				if property == "WalkSpeed" or property == "JumpPower" or property == "JumpHeight" then
					speedSlider:SetSliderValue(human.WalkSpeed)
					if human.UseJumpPower then
						jumpSlider:SetSliderValue(human.JumpPower)
					else
						jumpSlider:SetSliderValue(human.JumpHeight)
					end
				end
			end))
		end
	end
	
	if plr.Character then
		updateCharMods(plr.Character)
	end
	table.insert(connections, plr.CharacterAdded:Connect(updateCharMods))
	
	local forceClassicCam = characterCategory:AddCheckbox("Force Classic-Camera")
	forceClassicCam:SetChecked(false)
	
	task.spawn(function()
		local senhub = _G.SenHub
		local human
		while task.wait(2) and senhub and senhub.Parent do
			if forceClassicCam.Checked then
				plr.CameraMode = Enum.CameraMode.Classic
			end
		end
	end)
end

do -- 								ENVIRONMENT CATEGORY
	local RunService = _G.SafeGetService("RunService")
	local environmentCategory = _G.SenHub:AddCategory("Environment")
	
	environmentCategory:AddCheckbox("Humanoids ESP", function(checked)
		espModule.SetEnabled(checked)
	end)
	
	environmentCategory:AddButton("Fake-Freeze", function()
		if plr.Character then
			local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
			if human and human.RootPart then
				human.RootPart.Anchored = true
			end
		end
	end).Inline = true
	
	environmentCategory:AddButton("Full-Thaw", function()
		if plr.Character then
			for k,v in pairs(plr.Character:GetDescendants()) do
				if v:IsA("BasePart") then
					v.Anchored = false
				end
			end
		end
	end)
	
	environmentCategory:AddLabel("Player-Specific")
	
	local playerSelectionPopup
	local targetPlayer = nil
	local selectPlayerBtn
	local function UpdatePlayersList()
		if playerSelectionPopup then
			local list = {}
			for k,v in pairs(game.Players:GetPlayers()) do
				if v ~= plr then
					local espData = _G.ESPModule_GetESPData(v)
					table.insert(list, {
						Value = v,
						Text = v.DisplayName .. "\n(@" .. v.Name .. ")",
						Image = function()
							return game.Players:GetUserThumbnailAsync(v.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size180x180)
						end,
						Color = espData and espData.Color or v.TeamColor.Color
					})
				end
			end
			table.sort(list, function(a,b)
				return a.Text < b.Text
			end)
			playerSelectionPopup.UpdateList(list)
		end
		targetPlayer = (targetPlayer and targetPlayer.Parent) and targetPlayer or nil
		selectPlayerBtn.Text = targetPlayer and targetPlayer.DisplayName or "Select Player"
	end
	local spectateTarget = nil
	selectPlayerBtn	= environmentCategory:AddButton("Select Player", function()
		selectPlayerBtn:SetEnabled(false)
		playerSelectionPopup = _G.SenHub:CreatePopup("GridList", {
			Title = "Player Selection",
			List = nil,
			UserChoice = function(result)
				targetPlayer = result
				selectPlayerBtn:SetText(targetPlayer and targetPlayer.DisplayName or "Select Player")
				selectPlayerBtn._GuiObject.TextColor3 = targetPlayer and targetPlayer.TeamColor.Color or Color3.new(1, 1, 1)
				selectPlayerBtn:SetEnabled(true)
				playerSelectionPopup = nil
			end
		})
		UpdatePlayersList()
	end)
	
	table.insert(connections, game.Players.PlayerAdded:Connect(function()
		UpdatePlayersList()
	end))
	table.insert(connections, game.Players.PlayerRemoving:Connect(function()
		UpdatePlayersList()
	end))
	
	environmentCategory:AddButton("Freeze", function()
		if targetPlayer then
			local target = targetPlayer
			if target.Character then
				for k,v in pairs(target.Character:GetDescendants()) do
					if v:IsA("BasePart") then
						v.Anchored = true
					end
				end
			end
		end
	end).Inline = true
	
	environmentCategory:AddButton("Thaw", function()
		if targetPlayer then
			local target = targetPlayer
			if target.Character then
				for k,v in pairs(target.Character:GetDescendants()) do
					if v:IsA("BasePart") then
						v.Anchored = false
					end
				end
			end
		end
	end)
	
	environmentCategory:AddButton("Bring", function()
		if targetPlayer then
			local target = targetPlayer
			if plr.Character and target.Character then
				target.Character:PivotTo(plr.Character:GetPivot() * CFrame.new(0, 0, -2))
			end
		end
	end).Inline = true
	
	environmentCategory:AddButton("Tp To", function()
		if targetPlayer then
			local target = targetPlayer
			if plr.Character and targetPlayer.Character then
				_G.TeleportPlayerTo(target.Character:GetPivot())
			end
		end
	end).Enabled = not blacklistOptions["TeleportToPlayer"]
	
	local toolKill = environmentCategory:AddCheckbox("Tool Kill")
	toolKill.Inline = true
	
	task.spawn(function()
		local senhub = _G.SenHub
		local tool, handle, targetRoot, targetHandle
		local targetHuman
		while task.wait(0.05) and _senhub and _senhub.Parent do
			found = false
			if toolKill.Checked and plr.Character and targetPlayer and targetPlayer.Character then
				targetHuman = targetPlayer.Character:FindFirstChildWhichIsA("Humanoid")
				if targetHuman and targetHuman.RootPart then
					tool = plr.Character:FindFirstChildWhichIsA("Tool")
					if tool and tool.RequiresHandle then
						handle = tool:FindFirstChild("Handle")
						if handle and handle:IsA("BasePart") then
							for k,v in pairs(targetPlayer.Character:GetChildren()) do
								if v:IsA("BasePart") then
									firetouchinterest(v, handle, 1)
									firetouchinterest(v, handle, 0)
								end
							end
						end
					end
				end
			end
		end
	end)
	
	local stalkerBtn = environmentCategory:AddCheckbox("Stalker")
	stalkerBtn.Enabled = not blacklistOptions["Stalker"]
	
	table.insert(connections, RunService.RenderStepped:Connect(function()
		if stalkerBtn.Checked and plr.Character and targetPlayer and targetPlayer.Character then
			local targetHuman, myHuman = targetPlayer.Character:FindFirstChildWhichIsA("Humanoid"), plr.Character:FindFirstChildWhichIsA("Humanoid")
			if targetHuman and myHuman and targetHuman.RootPart and myHuman.RootPart then
				myHuman.RootPart.CFrame = targetHuman.RootPart.CFrame * CFrame.new(0, 0, 2)
				myHuman.RootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
				myHuman.RootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			end
		end
	end))
	
	local spectateBtn = nil
	
	spectateBtn = environmentCategory:AddButton("Spectate", function()
		if isSpectating then
			isSpectating = false
			spectateBtn.Text = "Spectate"
			spectateTarget = nil
			delay(0.05, function()
				if plr and plr.Character then
					local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
					if human then
						game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
						game.Workspace.CurrentCamera.CameraSubject = human
					end
				end
			end)
		else
			spectateTarget = targetPlayer
			isSpectating = true
			spectateBtn.Text = "Stop Spectating"
		end
	end)
	
	table.insert(connections, RunService.RenderStepped:Connect(function()
		if isSpectating and spectateTarget and spectateTarget.Character then
			local human = spectateTarget.Character:FindFirstChildWhichIsA("Humanoid")
			if human then
				game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
				game.Workspace.CurrentCamera.CameraSubject = human
			end
		end
	end))
end

do -- 								OTHER CATEGORY
	local otherCategory = _G.SenHub:AddCategory("Other")
	otherCategory:AddButton("Rejoin this server", function()
		_G.SafeGetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
	end)
	otherCategory:AddButton("Rejoin this game (random server)", function()
		_G.SafeGetService("TeleportService"):Teleport(game.PlaceId)
	end)
	otherCategory:AddButton("Bring to camera", function()
		local cam = game.Workspace.CurrentCamera
		if cam then
			_G.TeleportPlayerTo(cam.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, math.pi, 0))
		end
	end)
	otherCategory:AddButton("Restart MeltinHub", function()
		loadstring(game:HttpGet(BaseUrl .. "MeltinHub.lua", true))()
	end)
	if setfpscap then
		local fpsUnlock = otherCategory:AddCheckbox("FPS Unlock", function(state)
			setfpscap(144)
		end)
		--fpsUnlock:SetChecked(true)
	end
end

if repository[game.GameId] then
	gameModule = loadCoreModule(BaseUrl .. "Games/" .. repository[game.GameId])
	if gameModule and gameModule.Init then
		print("Initializing Game Module v" .. tostring(gameModule.ModuleVersion or "1.0"))
		local category = _G.SenHub:AddCategory(_G.GAMEINFO.Name)
		task.spawn(function()
			repeat task.wait() until game:IsLoaded()
			gameModule.On = true
			local result, err = pcall(gameModule.Init, category, gameModuleConnections)
			if not result then
				warn("Failed to initialize Game Module: " .. tostring(err))
				error(err)
			end
		end)
	end
end

_G.SenHub.OnDestroy = function()
	warn("MeltinHub shutting down")
	_G.StopScriptSearch()
	
	isStalking = false
	for k,v in pairs(connections) do
		if v then
			v:Disconnect()
		end
	end
	for k,v in pairs(gameModuleConnections) do
		if v then
			v:Disconnect()
		end
	end
	
	espModule.SetEnabled(false)
	aimbotModule.SetEnabled(false)
	flightModule.SetEnabled(false)
	
	if gameModule then
		gameModule.On = false
		local f, err = pcall(gameModule.Shutdown)
		if not f then
			warn(err)
			error(err)
		end
	end
	
	_G.IndexEmulator:Reset()
	_G.MethodEmulator:Reset()
	_G.KeyboardEmulator:Reset()
	--_G.Autopilot:Reset()
	
	--_G.ANTILAG = false
end