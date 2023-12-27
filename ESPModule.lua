local plr = game.Players.LocalPlayer

local AllyTeamColor = Color3.new(0, 1, 0)
local EnemyTeamColor = Color3.new(1, 0, 0)
local NeutralTeamColor = Color3.new(1, 1, 1)

local espGui = Instance.new("BillboardGui")
espGui.AlwaysOnTop = true
espGui.Size = UDim2.new(0, 100, 0, 20)
espGui.ResetOnSpawn = false
espGui.LightInfluence = 0
espGui.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
do
	local tl = Instance.new("TextLabel", espGui)
	tl.BackgroundTransparency = 1
	tl.Size = UDim2.new(1, 0, 1, 0)
	tl.Font = Enum.Font.Roboto
	tl.TextScaled = true
	tl.TextColor3 = Color3.new(1, 1, 1)
	tl.TextStrokeTransparency = 0
end

local espObject = Instance.new("SurfaceGui")
espObject.AlwaysOnTop = true
espObject.ResetOnSpawn = false
do
	local blank = Instance.new("Frame", espObject)
	blank.BorderSizePixel = 0
	blank.BackgroundTransparency = 0.85
	blank.BackgroundColor3 = Color3.new(1, 0, 0)
	blank.Size = UDim2.new(1, 0, 1, 0)
end

local module = {
	Enabled = false,
	Mode = 1
}

local connections = {}
local bguis = {}
local espObjects = {}

function SetESPColor(target, color)
	if not target then return end
	if not bguis[target] or not espObjects[target] then return end
	for k,v in pairs(espObjects[target]) do
		v.Frame.BackgroundColor3 = color
	end
	bguis[target].TextLabel.TextColor3 = color
end

function UpdateColors()
	for target,v in pairs(bguis) do
		local player = game.Players:GetPlayerFromCharacter(target)
		if player then
			v.TextLabel.Text = player.DisplayName
			if player.Team and plr.Team then
				SetESPColor(target, _G.MeltinHub_ValidAllyCheck(player) and AllyTeamColor or EnemyTeamColor)
			else
				SetESPColor(target, NeutralTeamColor)
			end
		else
			SetESPColor(target, NeutralTeamColor)
		end
	end
end

function ClearESP(target)
	if target and espObjects[target] then
		for k,v in pairs(espObjects[target]) do
			if v then
				v:Destroy()
			end
		end
		if bguis[target] then
			bguis[target]:Destroy()
		end
		espObjects[target] = nil
		bguis[target] = nil
	end
end

function ESPTarget(target)
	if not target then return end
	if plr.Character and target == plr.Character then return end

	ClearESP(target)

	local human = target:FindFirstChildWhichIsA("Humanoid")

	espObjects[target] = {}

	for k,v in pairs(target:GetDescendants()) do
		if v:IsA("BasePart") and v.Transparency == 0 then
			for _, enum in pairs(Enum.NormalId:GetEnumItems()) do
				local newEsp = espObject:Clone()
				newEsp.Face = enum
				newEsp.Parent = v
				newEsp.Adornee = v
				table.insert(espObjects[target], newEsp)
			end
		end
	end
	
	bguis[target] = espGui:Clone()
	local torso = target:FindFirstChild("Torso") or target:FindFirstChild("UpperTorso")
	bguis[target].Adornee = torso and torso or ((human and human.RootPart) and human.RootPart or target)
	bguis[target].TextLabel.Text = target.Name
	bguis[target].Parent = game.CoreGui
	
	UpdateColors()
end

function monitorPlayer(player)
	table.insert(connections, player.CharacterAdded:Connect(function(chr)
		repeat wait() until chr:FindFirstChildWhichIsA("Humanoid")
		wait(.1)
		if module.Mode < 3 then
			ESPTarget(chr)
		elseif module.Mode == 3 and not _G.MeltinHub_ValidAllyCheck(player) then
			ESPTarget(chr)
		end
		UpdateColors()
	end))
	table.insert(connections, player:GetPropertyChangedSignal("Team"):Connect(function()
		if not player.Character then return end
		if module.Mode == 3 then
			if _G.MeltinHub_ValidAllyCheck(player) then
				ClearESP(player.Character)
			else
				ESPTarget(player.Character)
			end
		end
		UpdateColors()
	end))
	if module.Mode ~= 3 or not _G.MeltinHub_ValidAllyCheck(player) then
		repeat wait() until player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
		wait(.1)
		ESPTarget(player.Character)
	end
end

function OnSelfTeamChange()
	if module.Mode == 3 then
		for target,v in pairs(espObjects) do
			local player = game.Players:GetPlayerFromCharacter(target)
			if player then
				if _G.MeltinHub_ValidAllyCheck(player) then
					ClearESP(player.Character)
				else
					ESPTarget(player.Character)
				end
			end
		end
	end
	UpdateColors()
end

_G.MeltinHub_ESPModule_SelfTeamChangedSignal = nil

function module.SetEnabled(state)
	if state and not module.Enabled then
		module.Enabled = true
		if module.Mode == 1 then
			for k,v in pairs(game.Workspace:GetDescendants()) do
				if v:IsA("Humanoid") then
					local player = game.Players:GetPlayerFromCharacter(v.Parent)
					if player then
						monitorPlayer(player)
					else
						ESPTarget(v.Parent)
					end
				end
			end

			table.insert(connections, game.Workspace.DescendantAdded:Connect(function(descendant)
				if descendant:IsA("Humanoid") then
					local player = game.Players:GetPlayerFromCharacter(descendant.Parent)
					if player then
						monitorPlayer(player)
					else
						ESPTarget(descendant.Parent)
					end
				end
			end))
			
			table.insert(connections, game.Workspace.DescendantRemoving:Connect(function(descendant)
				if espObjects[descendant] then
					ClearESP(descendant)
				end
			end))
		else
			for k,v in pairs(game.Players:GetPlayers()) do
				monitorPlayer(v)
			end
			table.insert(connections, game.Players.PlayerAdded:Connect(monitorPlayer))
			table.insert(connections, game.Players.PlayerRemoving:Connect(function(player)
				if player.Character then
					ClearESP(player.Character)
				end
			end))
		end
		
		if not _G.MeltinHub_ESPModule_SelfTeamChangedSignal then
			table.insert(connections, plr:GetPropertyChangedSignal("Team"):Connect(OnSelfTeamChange))
		else
			table.insert(connections, _G.MeltinHub_ESPModule_SelfTeamChangedSignal:Connect(OnSelfTeamChange))
		end
	else
		module.Enabled = false
		for k,v in pairs(connections) do
			if v then v:Disconnect() end
		end
		for k,v in pairs(bguis) do
			if v and v.Parent then
				v:Destroy()
			end
		end
		for k,v in pairs(espObjects) do
			for x, o in pairs(v) do
				if o then
					o:Destroy()
				end
			end
		end
		bguis = {}
		espObjects = {}
	end
end

function module.SetMode(mode)
	mode = math.min(3, math.max(1, mode))
	module.Mode = mode
	if module.Enabled then
		module.SetEnabled(false)
		module.SetEnabled(true)
	end
end

return module