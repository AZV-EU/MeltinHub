local module = {
	GameName = "Flee the Facility",
	ModuleVersion = "1.1"
}

local plr = game.Players.LocalPlayer
local moduleOn = true

function module.PreInit()
end

function module.Init(category, connections)
	--_G.IndexEmulator:SetKeyValue(_G.SafeGetService("UserInputService"), "TouchEnabled", false)
	local UserInputService = _G.SafeGetService("UserInputService")
	local ReplicatedStorage = _G.SafeGetService("ReplicatedStorage")
	local IsGameActive = ReplicatedStorage:WaitForChild("IsGameActive")
	local CurrentMap = ReplicatedStorage:WaitForChild("CurrentMap")
	local RemoteEvent = ReplicatedStorage:WaitForChild("RemoteEvent")

	local ScreenColorComplete = BrickColor.new("Dark green")
	_G.ESPModule_Database.Storages["Enemies"].Rule = function(target)
		if target:IsA("Player") and target.Character then
			return target.Character:FindFirstChild("Hammer") ~= nil
		end
		return false
	end
	
	_G.ESPModule_Create("IncompleteComputers", Color3.new(1, 1, 0), function(target)
		return target:IsA("Model") and target.Name == "ComputerTable" and target:FindFirstChild("Screen") and target.Screen.BrickColor ~= ScreenColorComplete
	end, 4)
	
	local function SetComputerTableUpdateHooks()
		if CurrentMap.Value ~= nil and CurrentMap.Value.Parent ~= nil then
			for k,v in pairs(game.Workspace:GetDescendants()) do
				if v:IsA("Model") and v.Name == "ComputerTable" and v:FindFirstChild("Screen") then
					table.insert(connections, v.Screen:GetPropertyChangedSignal("BrickColor"):Connect(function()
						task.wait(3)
						_G.ESPModule_Update()
					end))
				end
			end
		end
	end
	SetComputerTableUpdateHooks()
	
	_G.ESPModule_Connect(IsGameActive:GetPropertyChangedSignal("Value"))
	table.insert(connections, CurrentMap:GetPropertyChangedSignal("Value"):Connect(function()
		task.wait(7)
		SetComputerTableUpdateHooks()
		task.wait(1)
		_G.ESPModule_Update()
	end))
	
	_G.ESPModule_GetValidTargets = function()
		local targets = game.Players:GetPlayers()
		if CurrentMap.Value ~= nil then
			for k,v in pairs(game:GetDescendants()) do
				if v:IsA("Model") and v.Name == "ComputerTable" then
					table.insert(targets, v)
				end
			end
		end
		return targets
	end
	
	local function SetOldHammerEnabled(enabled)
		if plr and plr.Character and plr.Character:FindFirstChild("Hammer") and plr.Character.Hammer:FindFirstChild("LocalClubScript") then
			plr.Character.Hammer.LocalClubScript.Disabled = not enabled
		end
	end
	local betterHammer = category:AddCheckbox("Better Hammer", function(state)
		--SetOldHammerEnabled(not state)
	end)
	betterHammer:SetChecked(true)
	
	--[[
	table.insert(connections, plr.CharacterAdded:Connect(function(chr)
		table.insert(connections, chr.ChildAdded:Connect(function(child)
			if child.Name == "Hammer" then
				task.wait(1)
				SetOldHammerEnabled(not batterHammer.Checked)
			end
		end))
	end))
	]]
	
	local function GetCarriedPlayer()
		if plr.Character:FindFirstChild("CarriedTorso") and plr.Character.CarriedTorso.Value then
			return game.Players:GetPlayerFromCharacter(plr.Character.CarriedTorso.Value.Parent)
		end
	end
	
	local function GetNearestPlayer(range)
		local nearestPlayer, nearestHuman, nearDist = nil, nil, 0
		local carriedPlayer = GetCarriedPlayer()
		for k,p in pairs(game.Players:GetPlayers()) do
			if p ~= plr and p ~= carriedPlayer and p.Character then
				local human = p.Character:FindFirstChildWhichIsA("Humanoid")
				if human and human.RootPart then
					local dist = plr:DistanceFromCharacter(human.RootPart.Position)
					if dist <= range and (not nearestPlayer or dist < nearDist) then
						nearestPlayer = p
						nearestHuman = human
						nearDist = dist
					end
				end
			end
		end
		return nearestPlayer, nearestHuman
	end
	
	local function Attack()
		if plr and plr.Character then
			local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
			if human then
				local hammer = plr.Character:FindFirstChild("Hammer")
				if hammer then
					local event = hammer:FindFirstChild("HammerEvent")
					if event then
						event:FireServer("HammerClick", true)
						local animator = human:FindFirstChildWhichIsA("Animator")
						if animator and hammer:FindFirstChild("AnimSwing") then
							animator:LoadAnimation(hammer.AnimSwing):Play()
						end
						local target, tHuman = GetNearestPlayer(10)
						if target and target.Character and tHuman then
							local carriedPlayer = GetCarriedPlayer()
							local head = target.Character:FindFirstChild("Head")
							if head then
								if tHuman.PlatformStand and carriedPlayer == nil then
									event:FireServer("HammerTieUp", head, head.Position)
								elseif not tHuman.PlatformStand then
									event:FireServer("HammerHit", head)
								end
							end
						end
					end
				end
			end
		end
	end
	
	table.insert(connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if betterHammer.Checked and not gameProcessed then
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				Attack()
			end
		end
	end))
	
	local autoFree = category:AddCheckbox("Auto-free")
	--autoFree:SetChecked(true)
	local autoComputer = category:AddCheckbox("Auto-computer")
	autoComputer:SetChecked(true)
	
	_G.MethodEmulator:SetMethodOverride(RemoteEvent, "FireServer", function(self, orig, ...)
		local args = {...}
		if autoComputer.Checked then
			local func, param = args[1], args[2]
			if func and func == "SetPlayerMinigameResult" and not param then
				return orig(self, "SetPlayerMinigameResult", true)
			end
		end
		return orig(self, ...)
	end)
	
	task.spawn(function()
		while task.wait(2) and module.On do
			plr.CameraMode = Enum.CameraMode.Classic
			if CurrentMap.Value then
				if autoFree.Checked then
					for k,v in pairs(CurrentMap.Value:GetChildren()) do
						if v:IsA("Model") and v.Name == "FreezePod" and v:FindFirstChild("PodTrigger") and v.PodTrigger:FindFirstChild("CapturedTorso") and v.PodTrigger.CapturedTorso.Value ~= nil and v.PodTrigger:FindFirstChild("Event") then
							RemoteEvent:FireServer(
								"Input", "Trigger", true,
								v.PodTrigger.Event
							)
							RemoteEvent:FireServer("Input", "Action", false)
							RemoteEvent:FireServer("Input", "Action", true)
							RemoteEvent:FireServer(
								"Input", "Trigger", false,
								v.PodTrigger.Event
							)
						end
					end
				end
			end
		end
	end)
end

function module.Shutdown()
	moduleOn = false
end

return module