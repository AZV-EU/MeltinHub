local module = {
	GameName = "Lucky Block Tycoon",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer
if not plr then return end

local mouse = plr:GetMouse()
local inputService = game:GetService("UserInputService")
local VUService = game:GetService("VirtualUser")

local connections = {}
local lastNotify = tick()
local crates = game.Workspace:WaitForChild("CrateParent")
local crates2 = game.Workspace:FindFirstChild("Crates")
local meteors = game.Workspace:WaitForChild("Map Decoration Examples"):WaitForChild("Super Villian Tycoon")
do
	for k,v in pairs(meteors:GetChildren()) do
		if v.Name == "Meteorite" and v:IsA("BasePart") then
			v.Transparency = 0.5
			v.CanCollide = false
		end
	end
end

function findNearestToPoint(point)
	if not plr.Character then return end
	
	local closest, closestDistance = nil, 0
	for k,v in pairs(game.Workspace:GetChildren()) do
		local human = v:FindFirstChildWhichIsA("Humanoid")
		if human and human.RootPart and not human:IsDescendantOf(plr.Character) then
			local distance = (human.RootPart.Position - point).Magnitude
			if not closest or distance < closestDistance then
				closest = v
				closestDistance = distance
			end
		end
	end
	return closest, closestDistance
end

function hijackTool(tool)
	if tool.Name == "Gravity Inducer" then
		tool:WaitForChild("LocalScript").Disabled = true
	elseif tool.Name == "DynamicallyLitLaserGun" then
		tool:WaitForChild("Client").Disabled = true
		spawn(function()
			tool.Equipped:Wait()
			tool.Unequipped:Wait()
			if plr.Character then
				local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
				if human then
					for k,v in pairs(human.Animator:GetPlayingAnimationTracks()) do
						v:Stop(0)
					end
				end
			end
		end)
	end
end

for k,v in pairs(plr.Backpack:GetChildren()) do
	if v:IsA("Tool") then
		spawn(function()
			hijackTool(v)
		end)
	end
end

local autoTakeConns = {}

function getGivers()
	local givers = {}
	for k,v in pairs(game.Workspace.Tycoons:GetDescendants()) do
		if v:IsA("BasePart") and v.Name == "Giver" and v.Parent.Name:sub(1, 5) == "Giver" then
			table.insert(givers, v)
		end
	end
	return givers
end

function autoOpenAll()
	if plr.Character and plr.Character:FindFirstChildWhichIsA("Tool") then return end
	local luckyBlocksOpened = 0
	if plr.Backpack and plr.Character then
		local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
		for k, tool in pairs(plr.Backpack:GetChildren()) do
			if tool:IsA("Tool") and tool.Name:find("Block") then
				human:EquipTool(tool)
				tool:Activate()
				luckyBlocksOpened += 1
			end
		end
	end
	return luckyBlocksOpened
end

function collectGiver(giver)
	if giver.BrickColor ~= BrickColor.new("Really red") and giver.BrickColor ~= BrickColor.new("Bright red") then
		local result = _G.TouchObject(giver)
		if result then
			delay(0.1, autoOpenAll)
		end
		return result
	end
end

function module.Init(category)
	if game.ReplicatedStorage.Events:FindFirstChild("IntroDone") then
		game.ReplicatedStorage.Events.IntroDone:FireServer()
	end
	if plr.PlayerGui:FindFirstChild("tutorial") then
		plr.PlayerGui.tutorial:Destroy()
	end

	local collectCratesButton = category:AddButton("Collect Crates", function()
		local cratesCollected = 0
		if crates then
			for k,v in pairs(crates:GetChildren()) do
				if (_G.TouchObject(v)) then
					cratesCollected += 1
				end
			end
		end
		if crates2 then
			for k,v in pairs(crates2:GetChildren()) do
				if (_G.TouchObject(v.CashCrate)) then
					cratesCollected += 1
				end
			end
		end
		_G.SystemChat("Collected ".. tostring(cratesCollected) .." crates.")
	end)
	collectCratesButton._GuiObject.Active = #crates:GetChildren() > 0
	
	table.insert(connections, crates.ChildAdded:Connect(function(child)
		if child.Name == "CashCrate" and tick() - lastNotify > 1 then
			_G.SystemChat("New crates have spawned!")
			lastNotify = tick()
		end
		collectCratesButton._GuiObject.Active = #crates:GetChildren() > 0
	end))
	table.insert(connections, crates.ChildRemoved:Connect(function(child)
		collectCratesButton._GuiObject.Active = #crates:GetChildren() > 0
	end))
	
	local collectGiversButton = category:AddButton("Collect Givers", function()
		local f, err = pcall(function()
			local giversCollected = 0
			for k,v in pairs(getGivers()) do
				if collectGiver(v) then
					giversCollected += 1
				end
			end
			_G.SystemChat("Collected ".. tostring(giversCollected) .." givers.")
		end)
		if not f then
			warn(err)
		end
	end)
	
	local openLuckyBlocksButton = category:AddButton("Open Lucky Blocks", function()
		_G.SystemChat("Opened ".. tostring(autoOpenAll()) .." lucky blocks.")
	end)
	
	category:AddButton("Throw All Items (!!!DANGER!!!)", function()
		keypress(8)
		wait()
		keyrelease(8)
		for k,v in pairs(plr.Backpack:GetChildren()) do
			if v:IsA("Tool") then
				plr.Character.Humanoid:EquipTool(v)
				wait()
				keypress(8)
				wait()
				keyrelease(8)
			end
		end
	end)
	
	category:AddButton("Collect all items on map", function()
		for k,v in pairs(game.Workspace:GetChildren()) do
			if v:IsA("Tool") and v:FindFirstChild("Handle") then
				_G.TouchObject(v.Handle)
			end
		end
	end)
	
	local autoTakeCheckbox = category:AddCheckbox("Auto-Take Givers", function(state)
		if state then
			for k,v in pairs(getGivers()) do
				table.insert(autoTakeConns, v.Changed:Connect(function()
					collectGiver(v)
				end))
				collectGiver(v)
			end
			table.insert(autoTakeConns, game.Workspace.Tycoons.DescendantAdded:Connect(function(child)
				if child:IsA("BasePart") and child.Name == "Giver" then
					table.insert(autoTakeConns, child.Changed:Connect(function()
						collectGiver(child)
					end))
				end
			end))
			_G.SystemChat("Auto-take enabled")
		else
			for k,v in pairs(autoTakeConns) do
				if v then
					v:Disconnect()
				end
			end
			_G.SystemChat("Auto-take disabled")
		end
	end)

	table.insert(connections, plr.Backpack.ChildAdded:Connect(function(tool)
		if not tool:IsA("Tool") then return end
		spawn(function() hijackTool(tool) end)
	end))

	table.insert(connections, inputService.InputBegan:Connect(function(inputObject)
		if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
			local tool = plr.Character:FindFirstChildWhichIsA("Tool")
			if tool then
				
				if tool.Name == "DynamicallyLitLaserGun" then
					local target = findNearestToPoint(mouse.Hit.Position)
					tool:WaitForChild("Remote"):FireServer("LeftDown", target and target.Humanoid.RootPart.Position or mouse.Hit.Position, target and target.Humanoid.RootPart or mouse.Target)
				end
				
			end
		end
	end))
	
	local fireAllEnabled = category:AddCheckbox("F1 - Fire All Enabled")
	fireAllEnabled:SetChecked(true)
	local fireSequentialEnabled = category:AddCheckbox("F2 - Toggle Sequential Fire")
	
	category:AddLabel("Laser gun and gravity gun are upgraded.")

	table.insert(connections, inputService.InputEnded:Connect(function(inputObject)
		if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
			local tool = plr.Character:FindFirstChildWhichIsA("Tool")
			if tool then
				if tool.Name == "DynamicallyLitLaserGun" then
					local target = findNearestToPoint(mouse.Hit.Position)
					tool:WaitForChild("Remote"):FireServer("LeftUp", target and target.Humanoid.RootPart.Position or mouse.Hit.Position, target and target.Humanoid.RootPart or mouse.Target)
				end
			end
		elseif inputObject.UserInputType == Enum.UserInputType.Keyboard then
			--if iswindowactive() then
				if fireAllEnabled.Checked and inputObject.KeyCode == Enum.KeyCode.F1 then
					local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
					for k, tool in pairs(plr.Backpack:GetChildren()) do
						if tool:IsA("Tool") then
							human:EquipTool(tool)
							wait()
							mouse1click()
						end
					end
				end
			--end
		end
	end))

	table.insert(connections, game:GetService("RunService").RenderStepped:Connect(function()
		if inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
			if plr.Character then
				local tool = plr.Character:FindFirstChildWhichIsA("Tool")
				if tool then
					
					if tool.Name == "Gravity Inducer" then
						local target = findNearestToPoint(mouse.Hit.Position)
						tool:WaitForChild("WeaponEvent"):FireServer("Fire", target and target.Humanoid.RootPart.Position or mouse.Hit.Position)
					elseif tool.Name == "DynamicallyLitLaserGun" then
						local target = findNearestToPoint(mouse.Hit.Position)
						tool:WaitForChild("Remote"):FireServer("LeftMoved", target and target.Humanoid.RootPart.Position or mouse.Hit.Position, target and target.Humanoid.RootPart or mouse.Target)
					end
					
				end
			end
		end
	end))
end

function module.Shutdown()
	for k,v in pairs(autoTakeConns) do
		if v then
			v:Disconnect()
		end
	end
	for k,v in pairs(connections) do
		if v then
			v:Disconnect()
		end
	end
end

return module