local module = {
	GameName = "Color Or Die",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer

function module.PreInit()

end

function module.Init(category, connections)
	
	local gameplayParts = game.Workspace:WaitForChild("GameplayParts")
	local doors = gameplayParts:WaitForChild("Doors")
	local paintableDoors = doors:WaitForChild("Normal"):WaitForChild("Paintable")
	local unlockableDoors = doors:WaitForChild("Normal"):WaitForChild("Unlockable")
	local collectables = gameplayParts:WaitForChild("Items"):WaitForChild("Collectable"):WaitForChild("Collectable")
	
	local _gameplayParts = game.Workspace:WaitForChild("_GameplayParts")
	local _doors = _gameplayParts:WaitForChild("Doors")
	local _paintableDoors = _doors:WaitForChild("Normal"):WaitForChild("Paintable")
	local _unlockableDoors = _doors:WaitForChild("Normal"):WaitForChild("Unlockable")
	
	for k,v in pairs(_paintableDoors:GetChildren()) do
		if v.Core.SurfaceGui:FindFirstChild("Color") then
			_G.ESPModule_Create(v.Name.." Door", v.Core.SurfaceGui.Color.TextColor3, function(target) return target:IsDescendantOf(paintableDoors) and target.Parent.Name == v.Name end, 0, true)
		end
	end
	for k,v in pairs(_unlockableDoors:GetChildren()) do
		_G.ESPModule_Create(v.Name.." Unlockable Door", Color3.new(1, 1, 1), function(target) return target:IsDescendantOf(unlockableDoors) and target.Parent.Name == v.Name end, 0, true)
	end
	
	_G.ESPModule_Create("Collectables", Color3.new(1, 0, 1), function(target) return target:IsDescendantOf(collectables) end, 0, true)
	
	_G.ESPModule_GetDisplayName = function(target)
		if target:IsA("Player") then
			return target.DisplayName
		end
		return target.Parent.Name
	end
	
	_G.ESPModule_GetValidTargets = function()
		local targets = game.Players:GetPlayers()
		for k,v in pairs(paintableDoors:GetChildren()) do
			if v:FindFirstChild("Core") then
				table.insert(targets, v:FindFirstChild("Core"))
			end
		end
		for k,v in pairs(unlockableDoors:GetChildren()) do
			if v:FindFirstChild("Core") then
				table.insert(targets, v:FindFirstChild("Core"))
			end
		end
		for k,v in pairs(collectables:GetChildren()) do
			if v and v.Transparency <= 0 then
				table.insert(targets, v)
			end
		end
		return targets
	end
	
	for k,v in pairs(collectables:GetChildren()) do
		table.insert(connections, v:GetPropertyChangedSignal("Transparency"):Connect(function()
			task.wait(1)
			_G.ESPModule_Update()
		end))
	end
	
	_G.ESPModule_Connect(paintableDoors.ChildRemoved)
	_G.ESPModule_Connect(unlockableDoors.ChildRemoved)
	_G.ESPModule_Connect(plr.CharacterAdded)
	--[[
	table.insert(connections, paintableDoors.ChildRemoved:Connect(function(child)
		task.wait(1)
		_G.ESPModule_Update()
	end))
	table.insert(connections, unlockableDoors.ChildRemoved:Connect(function(child)
		task.wait(1)
		_G.ESPModule_Update()
	end))
	table.insert(connections, plr.CharacterAdded:Connect(function()
		task.wait(1)
		_G.ESPModule_Update()
	end))
	]]
end

function module.Shutdown()
	
end

return module