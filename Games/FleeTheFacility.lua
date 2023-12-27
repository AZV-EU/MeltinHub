local module = {
	GameName = "Flee the Facility",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer
local moduleOn = true

function module.PreInit()
end

function module.Init(category, connections)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local IsGameActive = ReplicatedStorage:WaitForChild("IsGameActive")
	local CurrentMap = ReplicatedStorage:WaitForChild("CurrentMap")

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
	
	local autoFree = category:AddCheckbox("Auto-free")
	--autoFree:SetChecked(true)
	
	--[[
	local args = {
		[1] = "Input",
		[2] = "Trigger",
		[3] = true,
		[4] = workspace:WaitForChild("Abandoned Facility Remake by Daniel_H407"):WaitForChild("FreezePod"):WaitForChild("PodTrigger"):WaitForChild("Event")
	}

	game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))

	]]
	
	task.spawn(function()
		while moduleOn and task.wait(2) do
			plr.CameraMode = Enum.CameraMode.Classic
			if CurrentMap.Value and autoFree.Checked then
				for k,v in pairs(CurrentMap.Value:GetChildren()) do
					if v:IsA("Model") and v.Name == "FreezePod" and v:FindFirstChild("PodTrigger") and v.PodTrigger:FindFirstChild("CapturedTorso") and v.PodTrigger.CapturedTorso.Value ~= nil and v.PodTrigger:FindFirstChild("Event") then
						print("Freeing", v.PodTrigger.CapturedTorso.Value.Parent:GetFullName())
						game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(
							"Input", "Trigger", false,
							v.PodTrigger.Event
						)
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