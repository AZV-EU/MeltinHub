local plr = game.Players.LocalPlayer

local module = {
	Enabled = false
}

local storagelock = _G.ESPModule_DontParent[game.GameId]

local AlliesTeamColor = Color3.new(0, 1, 0)
local FriendsTeamColor = Color3.new(0, 1, 1)
local EnemiesTeamColor = Color3.new(1, 0, 0)
local NeutralTeamColor = Color3.new(1, 1, 1)
local DeadTeamColor = Color3.new(0.15, 0.15, 0.15)

local NameGuiTemplate = Instance.new("BillboardGui")
NameGuiTemplate.AlwaysOnTop = true
NameGuiTemplate.Size = UDim2.new(0, 100, 0, 20)
NameGuiTemplate.ResetOnSpawn = false
NameGuiTemplate.LightInfluence = 0
NameGuiTemplate.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
do
	local tl = Instance.new("TextLabel", NameGuiTemplate)
	tl.BackgroundTransparency = 1
	tl.Size = UDim2.new(1, 0, 1, 0)
	tl.Font = Enum.Font.Roboto
	tl.TextScaled = true
	tl.TextColor3 = Color3.new(1, 1, 1)
	tl.TextStrokeTransparency = 0
end

local NameGuiStorage = game.CoreGui:FindFirstChild("_MH_NGS") or Instance.new("Folder", game.CoreGui)
NameGuiStorage.Name = "_MH_NGS"
local ESPStorage = game.Workspace:FindFirstChild("_MH_ESPS") or Instance.new("Model", game.Workspace)
ESPStorage.Name = "_MH_ESPS"

do
	local PresentHighlights = {}

	local gameHighlights = 0
	for k,v in pairs(game:GetDescendants()) do
		if v:IsA("Highlight") then
			table.insert(PresentHighlights, v)
		end
	end

	for k,v in pairs(getnilinstances()) do
		if v:IsA("Highlight") then
			table.insert(PresentHighlights, v)
		end
	end

	print("ESPModule: found", tostring(#PresentHighlights), "highlights pre-present in this game.")
end

_G.ESPModule_Database = {
	Storages = {},
	TargetsInfo = {}
}

do
	local function getTeamIndex(team)
		local teams = game:GetService("Teams"):GetTeams()
		for k,v in pairs(teams) do
			if v == team then
				return k
			end
		end
		return 0
	end

	_G.ESPModule_GetTeam = function(target)
		if target:IsA("Player") and target.Team ~= nil then
			return getTeamIndex(target.Team)
		end
		return 0
	end
end

local StoragesOrdered = {}
_G.ESPModule_Create = function(name, color, rule, priority, noHighlight)
	local storage = ESPStorage:FindFirstChild("ESP_" .. name) or Instance.new("Model", ESPStorage)
	storage.Name = "ESP_" .. name
	
	local highlight
	if not noHighlight then
		highlight = storage:FindFirstChild("Highlight") or Instance.new("Highlight", storage)
		highlight.FillColor = color
		highlight.FillTransparency = 0.65
		highlight.OutlineColor = color
		highlight.OutlineTransparency = 0.65
		highlight.Adornee = storage
	end
	
	_G.ESPModule_Database.Storages[name] = {
		EspName = name,
		Color = color,
		Rule = rule,
		Storage = storage,
		Priority = priority or -1,
		Highlight = highlight,
		Enabled = true
	}
	
	if priority then
		table.insert(StoragesOrdered, math.max(1, math.min(#StoragesOrdered, priority)), name)
	else
		table.insert(StoragesOrdered, name)
	end
	
	return _G.ESPModule_Database.Storages[name]
end

do
	_G.ESPModule_Create("Enemies", EnemiesTeamColor, function(target)
		return target:IsA("Player") and _G.ESPModule_GetTeam(target) ~= _G.ESPModule_GetTeam(plr)
	end)
	
	_G.ESPModule_Create("Allies", AlliesTeamColor, function(target)
		return target:IsA("Player") and _G.ESPModule_GetTeam(target) == _G.ESPModule_GetTeam(plr)
	end)

	_G.ESPModule_Create("Neutral", NeutralTeamColor, function(target)
		return _G.ESPModule_GetTeam(target) == 0
	end)
	
	_G.ESPModule_Create("Dead", DeadTeamColor, function(target)
		local human
		if target:IsA("Player") then
			if target.Character then
				human = target.Character:FindFirstChildWhichIsA("Humanoid")
			end
		else
			human = target:FindFirstChildWhichIsA("Humanoid")
		end
		return human and human.Health <= 0
	end, 1)
	
	_G.ESPModule_Create("Friends", FriendsTeamColor, function(target)
		if target:IsA("Player") then
			return plr:IsFriendsWith(target.UserId)
		end
		return false
	end, 2)
end

function _G.ESPModule_GetDisplayName(target)
	if target:IsA("Player") then
		return target.DisplayName
	end
	return target.Name
end

function _G.ESPModule_GetValidTargets()
	return game.Players:GetPlayers()
end

function _G.ESPModule_GetESPData(target)
	for _, espName in ipairs(StoragesOrdered) do
		local espData = _G.ESPModule_Database.Storages[espName]
		if espData and espData.Enabled then
			local f, result = pcall(espData.Rule, target)
			if f then
				if result then
					return espData, espName
				end
			else
				warn("ESPModule: Rule for team", espData.EspName, "failed:", result)
			end
		end
	end
end

function _G.ESPModule_Update()
	if not module.Enabled then return end
	local validTargets = _G.ESPModule_GetValidTargets()
	
	for target, targetInfo in pairs(_G.ESPModule_Database.TargetsInfo) do
		local found = false
		for _, t in pairs(validTargets) do
			if target == t then
				found = true
				break
			end
		end
		if not found then
			if targetInfo.NameGui then
				targetInfo.NameGui:Destroy()
			end
			_G.ESPModule_Database.TargetsInfo[target] = nil
		end
	end
	
	for targetIndex, target in pairs(validTargets) do
		if target and target ~= plr then
			local espData = _G.ESPModule_GetESPData(target)
			if espData then
				local f, err = pcall(function()
					if not _G.ESPModule_Database.TargetsInfo[target] then
						local ng = NameGuiTemplate:Clone()
						ng.Parent = NameGuiStorage
						_G.ESPModule_Database.TargetsInfo[target] = {
							OriginalParent = nil,
							NameGui = ng
						}
					end
					local root, human
					if target:IsA("Player") then
						if target.Character then
							human = target.Character:FindFirstChildWhichIsA("Humanoid")
							if human then
								root = human.RootPart
							end
						end
					else
						human = target:FindFirstChildWhichIsA("Humanoid")
						if human then
							root = human.RootPart
						end
					end
					_G.ESPModule_Database.TargetsInfo[target].NameGui.Adornee = root or target
					_G.ESPModule_Database.TargetsInfo[target].NameGui.TextLabel.Text = _G.ESPModule_GetDisplayName(target)
					_G.ESPModule_Database.TargetsInfo[target].NameGui.TextLabel.TextColor3 = espData.Color
					
					if espData.Highlight and not storagelock then
						if not _G.ESPModule_Database.TargetsInfo[target].OriginalParent then
							if target:IsA("Player") then
								if target.Character then
									_G.ESPModule_Database.TargetsInfo[target].OriginalParent = target.Character.Parent
								end
							else
								_G.ESPModule_Database.TargetsInfo[target].OriginalParent = target.Parent
							end
						end
						if target:IsA("Player") then
							if target.Character then
								pcall(function()
									target.Character.Parent = espData.Storage
								end)
							end
						elseif target.Parent ~= espData.Storage and target.Parent ~= nil then
							task.spawn(function()
								pcall(function()
									target.Parent = nil
									task.wait(.1)
									target.Parent = espData.Storage
								end)
							end)
						end
					end
				end)
				if not f then
					warn(err)
				end
			end
		end
	end
end

local connections = {}

function _G.ESPModule_Connect(conn)
	table.insert(connections, conn:Connect(_G.ESPModule_Update))
end

function _G.ESPModule_SetupConnections(target)
	local function setupCharacter(chr)
		local startTime = tick()
		local human
		repeat
			task.wait(.33)
			human = chr:FindFirstChildWhichIsA("Humanoid")
		until human ~= nil or tick() - startTime > 20 -- over 20 seconds spawn time? -> give up
		if human then
			_G.ESPModule_Connect(human.Died)
		end
		_G.ESPModule_Update()
	end
	if target:IsA("Player") then
		if target.Character then
			setupCharacter(target.Character)
		end
		table.insert(connections, target.CharacterAdded:Connect(setupCharacter))
		_G.ESPModule_Connect(target:GetPropertyChangedSignal("Team"))
	end
	if _G.ESPModule_SetupConnections_Optional then
		local f, err = pcall(_G.ESPModule_SetupConnections_Optional, target)
		if not f then warn("_G.ESPModule_SetupConnections error:", err) end
	end
end

function _G.ESPModule_ClearConnections(target)
	local targetInfo = _G.ESPModule_Database.TargetsInfo[target]
	if targetInfo then
		if targetInfo.NameGui then
			targetInfo.NameGui:Destroy()
		end
	end
	_G.ESPModule_Database.TargetsInfo[target] = nil
	_G.ESPModule_Update()
end

function module.SetEnabled(state)
	if state and not module.Enabled then
		module.Enabled = true
		
		for k,v in pairs(_G.ESPModule_GetValidTargets()) do
			_G.ESPModule_SetupConnections(v)
		end
		
		table.insert(connections, game.Players.PlayerAdded:Connect(_G.ESPModule_SetupConnections))
		table.insert(connections, game.Players.PlayerRemoving:Connect(_G.ESPModule_ClearConnections))
		_G.ESPModule_Connect(plr:GetPropertyChangedSignal("Team"))
		_G.ESPModule_Update()
	elseif not state and module.Enabled then
		module.Enabled = false
		for k,v in pairs(connections) do
			v:Disconnect()
		end
		if not storagelock then
			for target, info in pairs(_G.ESPModule_Database.TargetsInfo) do
				if info.OriginalParent ~= nil then
					if target:IsA("Player") then
						if target.Character then
							pcall(function()
								target.Character.Parent = info.OriginalParent
							end)
						end
					else
						task.spawn(function()
							pcall(function()
								target.Parent = nil
								task.wait(.1)
								target.Parent = info.OriginalParent
							end)
						end)
					end
				--[[else
					warn("No original parent for", target)
					if target:IsA("Player") then
						if target.Character then
							target.Character.Parent = game.Workspace
						end
					else
						target.Parent = game.Workspace
					end]]
				end
			end
		end
		_G.ESPModule_Database.TargetsInfo = {}
		NameGuiStorage:ClearAllChildren()
	end
end

return module