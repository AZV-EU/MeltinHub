local module = {
	GameName = "Westbound",
	ModuleVersion = "1.0"
}

local hopping = false
local objects = {}
function module.Init(category, connections)
	local plr = game.Players.LocalPlayer
	local mouse = plr:GetMouse()
	
	local animals = game.Workspace:WaitForChild("Animals")
	--[[_G.AIMBOT_GetTargets = function()
		local targets = {}
		for _,v in pairs(game.Players:GetPlayers()) do
			if v ~= plr and v.Character and v.Character.Parent and
				_G.ESPModule_Database.Storages["Enemies"].Rule(v) then
				table.insert(targets, v.Character)
			end
		end
		for _,v in pairs(animals:GetChildren()) do
			local human = v:FindFirstChildWhichIsA("Humanoid")
			if human and human.Health > 0 then
				table.insert(targets, v)
			end
		end
		return targets
	end]]

	_G.ESPModule_Database.Storages["Enemies"].Rule = function(target)
		if target:IsA("Player") and plr.Team and target.Team
			and target.Team.Name ~= "Civilians" and
			(plr.Team.Name == "Outlaws" or _G.ESPModule_GetTeam(target) ~= _G.ESPModule_GetTeam(plr)) then
			return true
		end
		return false
	end
	
	_G.ESPModule_Database.Storages["Allies"].Rule = function(target)
		if target:IsA("Player") and plr.Team and target.Team
			and (target.Team.Name == "Civilians" or
			(plr.Team.Name == "Cowboys" and _G.ESPModule_GetTeam(target) == _G.ESPModule_GetTeam(plr))) then
			return true
		end
		return false
	end
	
	do
		local tool
		_G.AIMBOT_CanUse = function()
			if plr.Character then
				tool = plr.Character:FindFirstChildWhichIsA("Tool")
				return tool and tool:FindFirstChild("GunType")
			end
		end
		_G.AIMBOT_AimFunc = nil
		
		local gunScripts = ReplicatedStorage:WaitForChild("GunScripts")
		for gunName,gunData in pairs(require(gunScripts:WaitForChild("GunStats"))) do
			gunData.AutoFire = true
		end
		
		local createShot = require(ReplicatedStorage:WaitForChild("GunScripts"):WaitForChild("CreateShot"))
		if _G.CreateShot_ORIG then
			createShot.CreateShot = _G.CreateShot_ORIG
			_G.CreateShot_ORIG = nil
		end
		_G.CreateShot_ORIG = createShot.CreateShot
		createShot.CreateShot = function(shotInfo)
			if shotInfo.BulletOwner == plr then
				if _G.AIMBOT_CurrentTarget then
					shotInfo.cframe = CFrame.new(shotInfo.cframe.Position, _G.AIMBOT_CurrentTarget.Position)
					pcall(_G.CreateShot_ORIG, shotInfo)
				end
			end
			_G.CreateShot_ORIG(shotInfo)
		end
	end
	
	local stats = plr:WaitForChild("Stats")
	local states = plr:WaitForChild("States")
	local settings = plr:WaitForChild("Settings")
	local stateConfig = plr:WaitForChild("StateConfig")
	
	local lassod = states:WaitForChild("Lassod")
	local lassoTarget = states:WaitForChild("LassoTarget")
	local hogtied = states:WaitForChild("Hogtied")
	
	local mle = stateConfig:WaitForChild("MouseLockEnabled")
	_G.IndexEmulator:SetKeyValue(mle, "Value", false)
	_G.IndexEmulator:SetKeyValue(mle:WaitForChild("MouseRotateEnabled"), "Value", false)
	_G.IndexEmulator:SetKeyValue(settings:WaitForChild("AimLock"), "Value", false)
	
	repeat wait() until plr.Character
	--plr.Character:WaitForChild("LookAnimate").Disabled = true
	plr.Character:WaitForChild("CharacterLocal")
	wait(1)
	plr.Character.CharacterLocal.Disabled = true
	local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
	if human then
		human.WalkSpeed = 38
		table.insert(connections, human:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
			human.WalkSpeed = 38
		end))
	end
	pcall(function()
		RunService:UnbindFromRenderStep("CameraOffset")
	end)
	
	table.insert(connections, lassoTarget:GetPropertyChangedSignal("Value"):Connect(function()
		task.wait(.3) -- wait for ping
		local target = lassoTarget.Value
		if target and target:FindFirstChild("States") and target.States:FindFirstChild("Hogtied") and not target.States.Hogtied.Value then
			ReplicatedStorage.GeneralEvents.LassoEvents:FireServer("Hogtie", target)
		end
	end))
	
	local hijackFuncs = {}
	local hijackedTools = {}
	local function hijackTool(tool)
		if tool:IsA("Tool") and not hijackedTools[tool] then
			hijackedTools[tool] = true
			
			if tool:FindFirstChild("GunType") then
				table.insert(connections, tool.Equipped:Connect(function()
					_G.AimbotModule.SetEnabled(true)
				end))
				table.insert(connections, tool.Unequipped:Connect(function()
					_G.AimbotModule.SetEnabled(false)
				end))
			end
			
			local func = hijackFuncs[tool.Name]
			if func then
				local f, err = pcall(func, tool)
				if not f then
					warn("Failed to hijack tool:", err)
				end
			end
		end
	end
	
	for k,v in pairs(plr.Backpack:GetChildren()) do
		hijackTool(v)
	end
	
	table.insert(connections, plr.CharacterAdded:Connect(function()
		--plr.Character:WaitForChild("LookAnimate").Disabled = true
		plr.Character:WaitForChild("CharacterLocal")
		wait(1)
		plr.Character.CharacterLocal.Disabled = true
		for k,v in pairs(plr.Backpack:GetChildren()) do
			hijackTool(v)
		end
		local human = plr.Character:WaitForChild("Humanoid")
		for k,v in pairs(getconnections(human.Jumping)) do
			v:Disable()
		end
		human.WalkSpeed = 38
		table.insert(connections, human.Changed:Connect(function()
			human.WalkSpeed = 38
		end))
	end))
	table.insert(connections, plr.Backpack.ChildAdded:Connect(hijackTool))
	
	local autoSkin = category:AddCheckbox("Auto-skin")
	autoSkin:SetChecked(true)
	autoSkin.Inline = true
	
	local animalsList = {}
	local function checkAnimals()
		for k, animal in pairs(animals:GetChildren()) do
			if animal:IsA("Model") then
				local human = animal:FindFirstChildWhichIsA("Humanoid")
				if human then
					local pelt, atype = animal:FindFirstChild("PeltQuality"), animal:FindFirstChild("AnimalType")
					if pelt and atype then
						animalsList[animal] = {
							PeltQuality = pelt.Value,
							AnimalType = atype.Value,
							Humanoid = human
						}
					end
				end
			end
		end
	end
	table.insert(connections, animals.ChildAdded:Connect(function(child)
		wait(.5)
		checkAnimals()
	end))
	table.insert(connections, animals.ChildRemoved:Connect(function(child)
		if animalsList[child] then
			animalsList[child] = nil
		end
	end))
	checkAnimals()
	
	spawn(function()
		while module.On and task.wait(.3) do
			if autoSkin.Checked then
				for animal, data in pairs(animalsList) do
					if data and data.Humanoid and data.Humanoid.Health <= 0 and data.Humanoid.RootPart and
						plr:DistanceFromCharacter(data.Humanoid.RootPart.Position) <= 10 then
						game.ReplicatedStorage.GeneralEvents.SkinAnimal:FireServer(animal)
					end
				end
			end
		end
	end)
	
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
	
	do
		local function highlightChests()
			for k,v in pairs(game.Workspace.ChestFolder:GetChildren()) do
				if v:IsA("Model") and v.Name == "TreasureChest" and v.PrimaryPart then
					if objects[v] ~= nil then
						objects[v]:Destroy()
					end
					if not v.Opened.Value then
						objects[v] = espGui:Clone()
						objects[v].Parent = v
						objects[v].Adornee = v
						objects[v].TextLabel.Text = "Treasure Chest"
						objects[v].TextLabel.TextColor3 = Color3.new(0.95, 0.95, 0)
						connections[v] = v.Opened.Changed:Connect(highlightChests)
					end
				end
			end
		end
		
		local refreshChestsConn
		category:AddCheckbox("Treasures", function(state)
			if state then
				highlightChests()
				refreshChestsConn = game.Workspace.ChestFolder.ChildAdded:Connect(highlightChests)
				table.insert(connections, refreshChestsConn)
			else
				if refreshChestsConn then refreshChestsConn:Disconnect() end
				for k,v in pairs(game.Workspace.ChestFolder:GetChildren()) do
					if objects[v] then
						objects[v]:Destroy()
					end
					if connections[v] then
						connections[v]:Disconnect()
					end
				end
			end
		end)
	end
	
	do
		local function highlightAnimals()
			for model, data in pairs(objects) do
				if objects[model] and not objects[model].Parent then
					objects[model]:Destroy()
					objects[model] = nil
				end
			end
			for model,v in pairs(animalsList) do
				if v.PeltQuality > 10 then
					if not objects[model] then
						objects[model] = espGui:Clone()
						table.insert(connections, v.Humanoid.Died:Connect(function()
							objects[model].TextLabel.TextColor3 = Color3.new(0.2, 0.2, 0.2) 
						end))
					end
					objects[model].Parent = model
					objects[model].Adornee = model
					objects[model].TextLabel.Text = v.AnimalType .. " (" .. tostring(v.PeltQuality) .. ")"
					objects[model].TextLabel.TextColor3 = v.Humanoid.Health > 0 and Color3.fromHSV(math.min(0.8, 0.05 + (v.PeltQuality / 1000)), 1, 1) or Color3.new(0.2, 0.2, 0.2)
				end
			end
		end
		
		local refreshAnimalsConn
		category:AddCheckbox("Animals", function(state)
			if state then
				highlightAnimals()
				refreshAnimalsConn = game.Workspace.Animals.ChildAdded:Connect(function()
					wait(1)
					highlightAnimals()
				end)
				table.insert(connections, refreshAnimalsConn)
			else
				if refreshAnimalsConn then refreshAnimalsConn:Disconnect() end
				for model,v in pairs(animalsList) do
					if objects[model] then
						objects[model]:Destroy()
						objects[model] = nil
					end
				end
			end
		end).Inline = true
	end
		
	do
		local function freeYourself()
			game.ReplicatedStorage.GeneralEvents.LassoEvents:FireServer("BreakFree")
		end
		
		local freeYourselfConn
		category:AddCheckbox("Auto-free", function(state)
			if state then
				freeYourself()
				freeYourselfConn = lassod.Changed:Connect(function()
					if lassod.Value then
						task.wait(.1)
						if lassod.Value or hogtied.Value then
							freeYourself()
						end
					end
				end)
				table.insert(connections, freeYourselfConn)
			else
				if freeYourselfConn then freeYourselfConn:Disconnect() end
			end
		end):SetChecked(true)
	end
	
	do
		local Safes = {}
		for k,v in pairs(game.Workspace:GetChildren()) do
			if v:IsA("Model") and v.Name == "Safe" and v:FindFirstChild("BankLocation") then
				if Safes[v.BankLocation.Value] then
					table.insert(Safes[v.BankLocation.Value], v)
				else
					Safes[v.BankLocation.Value] = {v}
				end
			end
		end
		local CashRegisters = {}
		for k,v in pairs(game.Workspace:GetChildren()) do
			if v:IsA("Model") and v.Name == "CashRegister" and v:FindFirstChild("Active") then
				table.insert(CashRegisters, {Model = v, Active = v.Active, Union = v:FindFirstChild("Union"), Open = v:FindFirstChild("Open")})
			end
		end
		
		category:AddButton("Sit on piano", function()
			game.ReplicatedStorage.GeneralEvents.SitDown:FireServer(game.Workspace.Piano.Seat)
		end).Inline = true
		
		category:AddButton("Sit on horseback", function()
			local closestHorse, dist
			for k,v in pairs(game.Workspace.Horses:GetChildren()) do
				if v.Name == "Horse" then
					local human = v:FindFirstChildWhichIsA("Humanoid")
					if human then
						local root = human.RootPart
						if root then
							local dst = plr:DistanceFromCharacter(root.Position)
							if not closestHorse or dst < dist then
								dist = dst
								closestHorse = v
							end
						end
					end
				end
			end
			if closestHorse then
				game:GetService("ReplicatedStorage").GeneralEvents.MountHorse:InvokeServer(
					closestHorse,
					"Back"
				)
			end
		end)
		
		category:AddButton("Open all safes", function()
			for location, safes in pairs(Safes) do
				for k,v in pairs(safes) do
					if not v.Open.Value then
						v.OpenSafe:FireServer("Complete")
						v.Open.Value = true
						wait(.1)
					end
				end
			end
		end)
		
		local stealing = false
		category:AddButton("Steal", function()
			if states.Bag.Value >= stats.BagSizeLevel.CurrentAmount.Value then
				stealing = false
				return
			end
			if not stealing and plr.Character then
				for i = 1, 20 do
					for location, safes in pairs(Safes) do
						for k,v in pairs(safes) do
							if states.Bag.Value >= stats.BagSizeLevel.CurrentAmount.Value then
								stealing = false
								return
							end
							if plr:DistanceFromCharacter(v.Safe.Position) < (v:GetExtentsSize().Magnitude / 2) and v.Amount.Value > 0 then
								stealing = true
								if not v.Open.Value then
									v.OpenSafe:FireServer("Complete")
									v.Open.Value = true
									wait(1)
								end
								game.ReplicatedStorage.GeneralEvents.Rob:FireServer("Safe", v)
								wait()
								stealing = false
								break
							end
						end
					end
					for k,v in pairs(CashRegisters) do
						if states.Bag.Value >= stats.BagSizeLevel.CurrentAmount.Value then
							stealing = false
							return
						end
						if v and v.Active.Value == true and plr:DistanceFromCharacter(v.Union.Position) < 5 then
							game.ReplicatedStorage.GeneralEvents.Rob:FireServer("Register",
								{
									Part = v.Union,
									OpenPart = v.Open,
									ActiveValue = v.Active,
									Active = true
								}
							)
						end
					end
				end
			end
		end).Inline = true
		
		category:AddButton("Sell inventory", function()
			game.ReplicatedStorage.GeneralEvents.Inventory:InvokeServer("Sell")
		end)
		
		local hopLocation = category:AddDropdown("Location", {"Fort Arthur", "Grayridge Bank"}, 1)
		local locations = {
			[1] = (game.Workspace.FortArthurSpawn1.CFrame * CFrame.new(0, 3, 0)).Position,
			[2] = Vector3.new(1621, 121.5, 1580)
		}
		
		local hopButton
		hopButton = category:AddButton("Hop to", function()
			if hopping then
				hopping = false
				hopButton.Text = "Hop to"
			else
				if plr.Character then
					local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
					if human and human.RootPart then
						hopButton.Text = "Hopping..."
						hopButton:Update()
						hopping = true
						local targetPos = locations[hopLocation.SelectedIndex]
						local maxHopDistance = 30
						local originalY = human.RootPart.Position.Y
						while hopping and module.On and human.Health > 0 and (human.RootPart.Position - targetPos).Magnitude > maxHopDistance do
							local nextHop = CFrame.new(Vector3.new(human.RootPart.Position.X, originalY, human.RootPart.Position.Z), targetPos) * CFrame.new(0, 0, -maxHopDistance)
							human.RootPart.CFrame = nextHop
							originalY = nextHop.Position.Y
							wait(0.05)
						end
						if hopping then
							human.RootPart.CFrame = CFrame.new(targetPos)
						end
						hopping = false
						hopButton.Text = "Hop to"
					end
				end
			end
		end)
	end
	
	local Christmas = game.Workspace:FindFirstChild("Christmas")
	if Christmas then
		local autoChristmas = category:AddCheckbox("Auto Collect Presents")
		autoChristmas:SetChecked(true)
		
		task.spawn(function()
			while task.wait(5) and module.On do
				local lostPresents = Christmas:FindFirstChild("LostPresents")
				if lostPresents then
					for _,desc in pairs(lostPresents:GetDescendants()) do
						if desc:IsA("BasePart") and desc.Name == "ChristmasPresent" then
							_G.TouchObject(desc)
						end
					end
				end
			end
		end)
	end
end

function module.Shutdown()
	for k,v in next, objects do
		v:Destroy()
	end
	hopping = false
end

return module