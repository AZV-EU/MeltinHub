local plr = game.Players.LocalPlayer

local module = {
	Enabled = false,
	Mode = 1 -- [1: Any] [2: All Players] [3: Enemy Players]
}

local storagelock = _G.ESPModule_DontParent[game.GameId]

local AllyTeamColor = Color3.new(0, 1, 0)
local FriendTeamColor = Color3.new(0, 1, 1)
local EnemyTeamColor = Color3.new(1, 0, 0)
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

	if #PresentHighlights > 27 then
		warn("ESPModule: TOO MANY HIGHLIGHTS DETECTED! PRE-PRESENT HIGHLIGHTS:" .. tostring(#PresentHighlights))
	else
		print("ESPModule: found", tostring(#PresentHighlights), "highlights pre-present in this game.")
	end
end

local AlliesStorage = ESPStorage:FindFirstChild("Allies") or Instance.new("Model", ESPStorage)
AlliesStorage.Name = "Allies"
local AlliesHighlight = AlliesStorage:FindFirstChild("Highlight") or Instance.new("Highlight", AlliesStorage)
AlliesHighlight.FillColor = AllyTeamColor
AlliesHighlight.OutlineColor = AllyTeamColor
AlliesHighlight.Adornee = AlliesStorage

local FriendsStorage = ESPStorage:FindFirstChild("Friends") or Instance.new("Model", ESPStorage)
FriendsStorage.Name = "Friends"
local FriendsHighlight = FriendsStorage:FindFirstChild("Highlight") or Instance.new("Highlight", FriendsStorage)
FriendsHighlight.FillColor = FriendTeamColor
FriendsHighlight.OutlineColor = FriendTeamColor
FriendsHighlight.Adornee = FriendsStorage

local NeutralStorage = ESPStorage:FindFirstChild("Neutral") or Instance.new("Model", ESPStorage)
NeutralStorage.Name = "Neutral"
local NeutralHighlight = NeutralStorage:FindFirstChild("Highlight") or Instance.new("Highlight", NeutralStorage)
NeutralHighlight.FillColor = NeutralTeamColor
NeutralHighlight.OutlineColor = NeutralTeamColor
NeutralHighlight.Adornee = NeutralStorage

local EnemiesStorage = ESPStorage:FindFirstChild("Enemies") or Instance.new("Model", ESPStorage)
EnemiesStorage.Name = "Enemies"
local EnemiesHighlight = EnemiesStorage:FindFirstChild("Highlight") or Instance.new("Highlight", EnemiesStorage)
EnemiesHighlight.FillColor = EnemyTeamColor
EnemiesHighlight.OutlineColor = EnemyTeamColor
EnemiesHighlight.Adornee = EnemiesStorage

local DeadStorage = ESPStorage:FindFirstChild("Dead") or Instance.new("Model", ESPStorage)
DeadStorage.Name = "Dead"
local DeadHighlight = DeadStorage:FindFirstChild("Highlight") or Instance.new("Highlight", DeadStorage)
DeadHighlight.FillColor = DeadTeamColor
DeadHighlight.OutlineColor = DeadTeamColor
DeadHighlight.Adornee = DeadStorage

local connections = {}
local esp_db = {}

local function UpdateColors()
	local f, err = pcall(function()
		for target, data in pairs(esp_db) do
			if target and target.Parent ~= nil and data and data.Humanoid ~= nil and data.Gui ~= nil then
				local storage = nil
				data.Gui.Adornee = data.Humanoid.RootPart
				local tl = data.Gui:FindFirstChild("TextLabel")
				if not tl then continue end
				if module.Mode == 1 then
					if _G.ESPModule_IsTargetAlive(target, data.Humanoid) then
						storage = NeutralStorage
						tl.TextColor3 = NeutralTeamColor
					else
						storage = DeadStorage
						tl.TextColor3 = DeadTeamColor
					end
				elseif module.Mode >= 2 and module.Mode <= 3 then -- ready for expansion here
					if _G.ESPModule_IsTargetAlive(target, data.Humanoid) then
						local player = game.Players:GetPlayerFromCharacter(target)
						if player then
							if module.Mode == 2 then
								if plr:IsFriendsWith(player.UserId) then
									storage = FriendsStorage
									tl.TextColor3 = FriendTeamColor
								else
									if _G.MeltinHub_ValidAllyCheck(player) then
										storage = AlliesStorage
										tl.TextColor3 = AllyTeamColor
									else
										storage = EnemiesStorage
										tl.TextColor3 = EnemyTeamColor
									end
								end
							elseif module.Mode == 3 then
								if _G.MeltinHub_ValidAllyCheck(player) then
									DestroyESP(target)
								else
									storage = EnemiesStorage
									tl.TextColor3 = EnemyTeamColor
								end
							end
						else
							storage = NeutralStorage
							tl.TextColor3 = NeutralTeamColor
						end
					else
						storage = DeadStorage
						tl.TextColor3 = DeadTeamColor
					end
				end
				if storage and not storagelock then
					target.Parent = storage
				end
			end
		end
	end)
	if not f then
		warn("ESPModule:", err)
	end
end


local ghostPartTemplate = Instance.new("Part")
ghostPartTemplate.Massless = true
ghostPartTemplate.Anchored = true
ghostPartTemplate.Locked = true
ghostPartTemplate.CanCollide = false
ghostPartTemplate.CanTouch = false
ghostPartTemplate.CastShadow = false
ghostPartTemplate.BottomSurface = Enum.SurfaceType.Smooth
ghostPartTemplate.TopSurface = Enum.SurfaceType.Smooth
ghostPartTemplate.Color = Color3.new(1, 1, 1)

local ghostMeshPartTemplate = Instance.new("MeshPart")
ghostMeshPartTemplate.Massless = true
ghostMeshPartTemplate.Anchored = true
ghostMeshPartTemplate.Locked = true
ghostMeshPartTemplate.CanCollide = false
ghostMeshPartTemplate.CanTouch = false
ghostMeshPartTemplate.CastShadow = false
ghostMeshPartTemplate.BottomSurface = Enum.SurfaceType.Smooth
ghostMeshPartTemplate.TopSurface = Enum.SurfaceType.Smooth
ghostMeshPartTemplate.Color = Color3.new(1, 1, 1)

local function CreateESP(target)
	if target and not esp_db[target] then
		local human = target:FindFirstChildWhichIsA("Humanoid")
		if human then
			local root = human.RootPart
			if root then
				local player = game.Players:GetPlayerFromCharacter(target)
				local ngtCopy = NameGuiTemplate:Clone()
				ngtCopy.Parent = NameGuiStorage
				local tl = ngtCopy:FindFirstChild("TextLabel")
				tl.Text = player and player.DisplayName or target.Name
				ngtCopy.Adornee = root
				
				esp_db[target] = {
					Humanoid = human,
					Gui = ngtCopy,
					Source = target.Parent,
					Signals = {}
				}
				for k,v in pairs(target:GetChildren()) do
					if v ~= root and v:IsA("BasePart") and human:GetLimb(v) ~= Enum.Limb.Unknown then
						table.insert(esp_db[target].Signals, v:GetPropertyChangedSignal("Transparency"):Connect(function()
							v.Transparency = 0
						end))
						v.Transparency = 0
					end
				end
				table.insert(esp_db[target].Signals, target:GetPropertyChangedSignal("Name"):Connect(function()
					tl.Text = player and player.DisplayName or target.Name
				end))
				table.insert(esp_db[target].Signals, human.Died:Connect(UpdateColors))
				UpdateColors()
			end
		end
	end
end

local function DestroyESP(target)
	if target and esp_db[target] then
		for k,v in pairs(esp_db[target].Signals) do
			v:Disconnect()
		end
		if esp_db[target].Gui then
			esp_db[target].Gui:Destroy()
		end
		if target.Parent ~= nil then
			pcall(function()
				target.Parent = esp_db[target].Source
			end)
		end
		esp_db[target] = nil
	end
end

local defaultRaycastParams = RaycastParams.new()
defaultRaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
defaultRaycastParams.IgnoreWater = true
do
	local result
	_G.ESPModule_IsTargetObscured = function(target)
		defaultRaycastParams.FilterDescendantsInstances = {game.Workspace.CurrentCamera, plr.Character}
		local result = game.Workspace:Raycast(game.Workspace.CurrentCamera.CFrame, target.Position, defaultRaycastParams)
		return result and result.Instance and not result.Instance:IsDescendantOf(target)
	end
end

local function MonitorPlayer(player)
	if not player or player == plr then return end
	local function OnSpawn()
		if not player.Character or not player.Character.Parent or not
			player.Character:FindFirstChildWhichIsA("Humanoid") or not
			player.Character:FindFirstChildWhichIsA("Humanoid").RootPart then
			repeat wait() until
				player.Character and
				player.Character.Parent and
				player.Character:FindFirstChildWhichIsA("Humanoid") and
				player.Character:FindFirstChildWhichIsA("Humanoid").RootPart
		end
		if module.Mode < 3 or (module.Mode == 3 and not _G.MeltinHub_ValidAllyCheck(player)) then
			CreateESP(player.Character)
		end
	end
	table.insert(connections, player.CharacterAdded:Connect(OnSpawn))
	table.insert(connections, player.CharacterRemoving:Connect(function(oldChr)
		DestroyESP(oldChr)
		pcall(function()
			oldChr:Destroy()
		end)
	end))
	
	local teamChangedSignal = _G.ESPModule_TargetTeamChangedSignal(player)
	if teamChangedSignal then
		if type(teamChangedSignal) == "table" then
			for k, signal in pairs(teamChangedSignal) do
				if signal then
					table.insert(connections, signal:Connect(UpdateColors))
				end
			end
		else
			table.insert(connections, teamChangedSignal:Connect(UpdateColors))
		end
	else
		warn("Could not get TeamChangedSignal for player:", player.Name)
	end
	
	local aliveChangedSignal = _G.ESPModule_TargetAliveChangedSignal(player)
	if aliveChangedSignal then
		if type(aliveChangedSignal) == "table" then
			for k, signal in pairs(aliveChangedSignal) do
				if signal then
					table.insert(connections, signal:Connect(UpdateColors))
				end
			end
		else
			table.insert(connections, aliveChangedSignal:Connect(UpdateColors))
		end
	else
		warn("Could not get AliveChangedSignal for player:", player.Name)
	end
	
	coroutine.resume(coroutine.create(OnSpawn))
end

function module.SetEnabled(state)
	if state and not module.Enabled then
		if module.Mode == 1 then
			for k,v in pairs(game.Workspace:GetDescendants()) do
				if v:IsA("Humanoid") then
					local player = game.Players:GetPlayerFromCharacter(v.Parent)
					if player then
						spawn(function()
							MonitorPlayer(player)
						end)
					else
						CreateESP(v.Parent)
						local updateSignal = _G.ESPModule_TargetTeamChangedSignal(player)
						if updateSignal then
							updateSignal:Connect(UpdateColors)
						end
					end
				end
			end
			
			table.insert(connections, game.Workspace.DescendantAdded:Connect(function(descendant)
				if descendant:IsA("Humanoid") then
					local player = game.Players:GetPlayerFromCharacter(descendant.Parent)
					if player then
						MonitorPlayer(player)
					else
						CreateESP(descendant.Parent)
						local updateSignal = _G.ESPModule_TargetTeamChangedSignal(player)
						if updateSignal then
							updateSignal:Connect(UpdateColors)
						end
					end
				end
			end))
			table.insert(connections, game.Workspace.DescendantRemoving:Connect(function(descendant)
				if esp_db[descendant] then
					DestroyESP(descendant)
				end
			end))
		elseif module.Mode == 2 or module.Mode == 3 then
			for k,v in pairs(game.Players:GetPlayers()) do
				spawn(function()
					MonitorPlayer(v)
				end)
			end
			table.insert(connections, game.Players.PlayerAdded:Connect(function(player)
				MonitorPlayer(player)
			end))
			table.insert(connections, game.Players.PlayerRemoving:Connect(function(player)
				DestroyESP(player.Character)
			end))
		end
		
		do
			local targetTeamChanged = _G.ESPModule_TargetTeamChangedSignal(plr)
			if targetTeamChanged then
				table.insert(connections, targetTeamChanged:Connect(UpdateColors))
			else
				warn("CRITICAL: cannot get TeamChangedSignal for local player!")
			end
		end
		
		do
			--[[
			game:GetService("RunService"):BindToRenderStep("_mh_boundary_esp", Enum.RenderPriority.Camera.Value - 2, function(dt)
				for target, data in pairs(esp_db) do
					if target and target:FindFirstChild("Head") and target:FindFirstChild("HumanoidRootPart") then
						if _G.ESPModule_IsTargetObscured(target.Head) or _G.ESPModule_IsTargetObscured(target.HumanoidRootPart) then
							
						end
					end
				end
			end)
			]]
		end
	elseif not state and module.Enabled then
		for k,v in pairs(connections) do
			v:Disconnect()
		end
		for target, data in pairs(esp_db) do
			DestroyESP(target)
		end
		NameGuiStorage:ClearAllChildren()
		esp_db = {}
		game:GetService("RunService"):UnbindFromRenderStep("_mh_esp")
	end
	
	module.Enabled = state
end

function module.SetMode(mode)
	module.Mode = mode
	if module.Enabled then
		module.SetEnabled(false)
		module.SetEnabled(true)
	end
end

return module