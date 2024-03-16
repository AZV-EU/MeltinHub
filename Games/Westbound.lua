local module = {
	GameName = "Westbound",
	ModuleVersion = "1.0"
}

local hopping = false
local objects = {}
function module.Init(category, connections)
	local plr = game.Players.LocalPlayer
	local Backpack = plr:WaitForChild("Backpack")
	local PlayerScripts = plr:WaitForChild("PlayerScripts")
	local PlayerInventory = plr:WaitForChild("Inventory")
	local mouse = plr:GetMouse()
	
	local sharedModules = ReplicatedStorage:WaitForChild("SharedModules")
	local generalEvents = ReplicatedStorage:WaitForChild("GeneralEvents")
	
	local gunScripts = ReplicatedStorage:WaitForChild("GunScripts")
	local gunLocalModule = gunScripts:WaitForChild("GunLocalModule")
	local GLM = require(gunLocalModule)
	
	do -- curentGunData snapshot for reference
		--[[
		{
			Humanoid = game.Workspace.RBChancelor.Humanoid,
			TotalAmmo = game.Players.RBChancelor.PlayerGui.AmmoHud.Frame.ImageLabel.Total,
			Tool = game.Workspace.RBChancelor["Winter's Bounty"],
			AmmoType = "SniperAmmo",
			CurrentAmmo = game.Players.RBChancelor.PlayerGui.AmmoHud.Frame.ImageLabel.Current,
			Mobile = {
				RemoveFireButton = function RemoveFireButton() end,
				SetUpFireButton = function SetUpFireButton() end,
				RaycastScreenCenter = function RaycastScreenCenter() end,
				IsInputEnded = function IsInputEnded() end,
				ToggleAimIcon = function ToggleAimIcon() end
			},
			Mouse = Instance,
			unequipConnection = RBXScriptConnection.new(Connection),
			shotDebounce = false,
			reloading = false,
			AmmoVal = game.Players.RBChancelor.Consumables.SniperAmmo,
			Character = game.Workspace.RBChancelor,
			Root = game.Workspace.RBChancelor.HumanoidRootPart,
			TotalAmmoClient = 186,
			walkStateChanged = RBXScriptConnection.new(Connection),
			Equipped = true,
			ImageLabel = game.Players.RBChancelor.PlayerGui.AmmoHud.Frame.ImageLabel,
			Animations = {
				Zoom = Animation,
				Hold = Animation,
				Equip = Animation,
				Fire = Animation,
				Idle = Animation,
				Reload = Animation
			},
			Firing = false,
			cancelReloading = false,
			isVibrationSupported = true,
			NewAmmoGui = game.Players.RBChancelor.PlayerGui.AmmoHud,
			humanoidDied = RBXScriptConnection.new(Connection),
			Sounds = {
				CloseLever = game.Workspace.RBChancelor["Winter's Bounty"].Handle.CloseLever,
				Prep = game.Workspace.RBChancelor["Winter's Bounty"].Handle.Prep,
				Empty = game.Workspace.RBChancelor["Winter's Bounty"].Handle.Empty,
				Equip = game.Workspace.RBChancelor["Winter's Bounty"].Handle.Equip,
				Fire = game.Workspace.RBChancelor["Winter's Bounty"].Handle.Fire,
				OpenLever = game.Workspace.RBChancelor["Winter's Bounty"].Handle.OpenLever,
				Reload = game.Workspace.RBChancelor["Winter's Bounty"].Handle.Reload
			},
			AmmoChangedConnection = RBXScriptConnection.new(Connection),
			Handle = game.Workspace.RBChancelor["Winter's Bounty"].Handle,
			zooming = false,
			GunInfo = {
				Sounds = "loopback -> table:10",
				Tool = game.Workspace.RBChancelor["Winter's Bounty"],
				GunStats = {
					camShakeResist = 250,
					FullReload = true,
					AutoFire = true,
					ReloadSpeed = 0.1,
					BulletSpeed = 120,
					MaxShots = 1000,
					InstantFireAnimation = true,
					ForceZoom = false,
					FiringOffset = CFrame.new(-2.70000005, 0.300000012, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					prepTime = 0.05,
					GunType = "Sniper",
					Spread = 0,
					Damage = 75,
					EquipDelay = 0.3,
					ZoomMouseSpeed = 0.07,
					Scope = game.Players.RBChancelor.PlayerGui.Scope.Scope,
					FireAnimationType = "RifleZoom",
					ZoomAccuracy = 0,
					equipTime = 0,
					toolIdleAnimationType = "Rifle",
					ScopeGui = game.Players.RBChancelor.PlayerGui.Scope,
					ZoomFOVSpeed = 5,
					ZoomFOV = 10,
					toolZoomAnimationType = "RifleZoom",
					AmmoName = "SniperAmmo",
					ReloadAnimationSpeed = 1,
					HipFireAccuracy = 20
				}
			},
			GunStats = "loopback -> table:12",
			PlayAnimation = function PlayAnimation() end,
			Shots = 1000,
			reloadManual = false,
			NewFrame = game.Players.RBChancelor.PlayerGui.AmmoHud.Frame
		}
		]]
	end
	
	local animals = game.Workspace:WaitForChild("Animals")
	local horses = game.Workspace:WaitForChild("Horses")
	local shops = game.Workspace:WaitForChild("Shops")
	
	local GeneralEvents = {
		LassoEvents = generalEvents:WaitForChild("LassoEvents"),
		SkinAnimal = generalEvents:WaitForChild("SkinAnimal"),
		SitDown = generalEvents:WaitForChild("SitDown"),
		MountHorse = generalEvents:WaitForChild("MountHorse"),
		Rob = generalEvents:WaitForChild("Rob"),
		Inventory = generalEvents:WaitForChild("Inventory"),
		BuyItem = generalEvents:WaitForChild("BuyItem")
	}
	
	local stats = plr:WaitForChild("Stats")
	local states = plr:WaitForChild("States")
	local settings = plr:WaitForChild("Settings")
	local stateConfig = plr:WaitForChild("StateConfig")
	
	local lassod = states:WaitForChild("Lassod")
	local lassoTarget = states:WaitForChild("LassoTarget")
	local hogtied = states:WaitForChild("Hogtied")
	
	local inventoryLimit = stats:WaitForChild("InventorySizeLevel"):WaitForChild("CurrentAmount")
	
	local mle = stateConfig:WaitForChild("MouseLockEnabled")
	_G.IndexEmulator:SetKeyValue(mle, "Value", false)
	_G.IndexEmulator:SetKeyValue(mle:WaitForChild("MouseRotateEnabled"), "Value", false)
	_G.IndexEmulator:SetKeyValue(settings:WaitForChild("AimLock"), "Value", false)
	_G.IndexEmulator:SetKeyValue(states:WaitForChild("BackpackDisabled"), "Value", false)
	
	do -- buggy context streaming override, let roblox handle performance
		local gs = PlayerScripts:WaitForChild("GeneralStreaming")
		
		if gs.Enabled then
			gs.Enabled = false
			
			local cs = ReplicatedStorage:WaitForChild("ContextStreaming")
			for _,obj in pairs(cs:GetChildren()) do
				obj.Parent = game.Workspace
			end
		end
	end
	
	do -- anti-ragdoll
		local ragdoll = require(sharedModules:WaitForChild("Ragdoll"))
		if _G.OriginalRagdoll then
			for key,func in pairs(_G.OriginalRagdoll) do
				ragdoll[key] = func
			end
			_G.OriginalRagdoll = nil
		end
		
		_G.OriginalRagdoll = {}
		for key,func in pairs(ragdoll) do
			_G.OriginalRagdoll[key] = func
			ragdoll[key] = function()
				if _G.MeltinENV == 1 then
					print("Prevented", key, "execution.")
				end
			end
		end
		
		_G.MethodEmulator:SetMethodOverride("ChangeCharacter", "FireServer", function(self, orig, key, value, ...)
			if key == "Damage" or key == "Ragdoll" then return end
			return orig(self, key, value, ...)
		end)
	end
	
	pcall(function()
		RunService:UnbindFromRenderStep("CameraOffset")
	end)
	
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
	
	do -- aimbot
		_G.AIMBOT_Raycast_GetFilterDescendantsInstances = function()
			return {game.Workspace.CurrentCamera, plr.Character, horses}
		end
		
		do
			local tool
			_G.AIMBOT_CanUse = function()
				if plr.Character then
					tool = plr.Character:FindFirstChildWhichIsA("Tool")
					return tool and (tool:FindFirstChild("GunType") or tool.Name == "Bow")
				end
				return false
			end
		end
		
		do
			local targets
			_G.AIMBOT_GetTargets = function()
				targets = animals:GetChildren()
				for _,v in pairs(game.Players:GetPlayers()) do
					if v ~= plr and v.Character and v.Character.Parent and not plr:IsFriendsWith(v.UserId) and
						_G.ESPModule_Database.Storages["Enemies"].Rule(v) then
						table.insert(targets, v.Character)
					end
				end
				return targets
			end
		end
		
		_G.AIMBOT_AimFunc = nil
		
		-- TODO: !!! BOW !!!
		
		_G.GLM_Fire_ORIG = GLM.Fire
		GLM.Fire = function(...)
			if not _G.AimbotModule.Enabled or _G.AIMBOT_CurrentTarget then
				_G.GLM_Fire_ORIG(...)
			end
		end
		
		local createShot = require(gunScripts:WaitForChild("CreateShot"))
		_G.CreateShot_ORIG = createShot.CreateShot
		createShot.CreateShot = function(shotInfo)
			if shotInfo.BulletOwner == plr then
				if _G.AIMBOT_CurrentTarget then
					shotInfo.cframe = CFrame.new(shotInfo.cframe.Position, _G.AIMBOT_CurrentTarget.Position)
				else
					local mouseRay = game.Workspace.CurrentCamera:ScreenPointToRay(mouse.X, mouse.Y)
					local raycastHit = _G.AIMBOT_Raycast(mouseRay.Origin, mouseRay.Direction * 1000)
					if raycastHit then
						shotInfo.cframe = CFrame.new(shotInfo.cframe.Position, raycastHit.Position)
					else
						shotInfo.cframe = CFrame.new(shotInfo.cframe.Position, mouse.Hit.Position)
					end
				end
				if shotInfo.GunType and shotInfo.GunType == "Bow" then
					shotInfo.Speed = 20
					shotInfo.DamageModifier = 1
				end
			end
			_G.CreateShot_ORIG(shotInfo)
		end
	end
	
	do -- auto-lasso
		table.insert(connections, lassoTarget:GetPropertyChangedSignal("Value"):Connect(function()
			local target = lassoTarget.Value
			while task.wait(.3) and target do
				if target:FindFirstChild("States") and target.States:FindFirstChild("Hogtied") then
					if not target.States.Hogtied.Value then
						GeneralEvents.LassoEvents:FireServer("Hogtie", target)
					else
						break
					end
				end
			end
		end))
	end
	
	local hijackedTools = {}
	local weaponsData = {}
	local function hijackTool(tool)
		if tool:IsA("Tool") and not hijackedTools[tool] then
			hijackedTools[tool] = true
			
			local equipped = false
			local function OnEquipped()
				equipped = true
				task.wait(.33)
				if not weaponsData[tool] then
					for _,func in pairs(getfunctions(gunLocalModule)) do
						pcall(function()
							local gunTbl = getupvalue(func, 1)
							if gunTbl and type(gunTbl) == "table" and gunTbl.Tool and gunTbl.Tool == tool then
								weaponsData[tool] = gunTbl
							end
						end)
						if weaponsData[tool] ~= nil then
							break
						end
					end
				end
				
				local weaponData = weaponsData[tool]
				if weaponData then
					if weaponData.AmmoVal and weaponData.AmmoVal:FindFirstChild("Clip") then
						weaponData.Shots = weaponData.AmmoVal.Clip.Value
					end
				end
				
				while task.wait() and equipped and module.On do
					if plr.Character and plr.Character.PrimaryPart then
						if _G.AIMBOT_CurrentTarget then
							plr.Character.PrimaryPart.CFrame = CFrame.new(plr.Character.PrimaryPart.Position, Vector3.new(_G.AIMBOT_CurrentTarget.Position.X, plr.Character.PrimaryPart.Position.Y, _G.AIMBOT_CurrentTarget.Position.Z))
						else
							plr.Character.PrimaryPart.CFrame = CFrame.new(plr.Character.PrimaryPart.Position, Vector3.new(mouse.Hit.Position.X, plr.Character.PrimaryPart.Position.Y, mouse.Hit.Position.Z))
						end
					end
				end
			end
			if plr.Character and plr.Character.Parent and tool.Parent == plr.Character then
				task.spawn(OnEquipped)
			end
			
			table.insert(connections, tool.Equipped:Connect(OnEquipped))
			table.insert(connections, tool.Unequipped:Connect(function()
				equipped = false
			end))
			
			if tool.Name == "Bow" then
				local fl = tool:WaitForChild("FullyLoaded")
				fl.Value = true
				_G.IndexEmulator:SetKeyValue(fl, "Value", true)
			elseif tool.Name == "Health Potion" then
				local hc = tool:WaitForChild("HealClient")
				for _,func in pairs(getfunctions(hc)) do
					for idx,const in pairs(debug.getconstants(func)) do
						if const == 3.6 then
							debug.setconstant(func, idx, 0.1)
						end
					end
				end
			end
		end
	end
	table.insert(connections, plr.Backpack.ChildAdded:Connect(hijackTool))
	
	local function setupCharacter(chr)
		local human = chr:WaitForChild("Humanoid")
		local charLocal = chr:WaitForChild("CharacterLocal")
		task.wait(1)
		_G.DisableConnections(human.Jumping)
		_G.DisableConnections(human.Died)
		hijackedTools = {}
		for k,v in pairs(plr.Backpack:GetChildren()) do
			hijackTool(v)
		end
		for k,v in pairs(chr:GetChildren()) do
			hijackTool(v)
		end
		for _,func in pairs(getfunctions(charLocal)) do
			for idx,upvalue in pairs(getupvalues(func)) do
				if type(upvalue) == "table" and upvalue.RunSpeed then
					--upvalue.ZoomSpeed = upvalue.RunSpeed
					upvalue.GunOutRunSpeed = upvalue.RunSpeed
					upvalue.WalkSpeed = upvalue.RunSpeed
				end
			end
			--[[for idx,constant in pairs(getconstants(func)) do
				if constant == "Kick" then
					setconstant(func, idx, "")
				end
			end]]
		end
		human.WalkSpeed = 30
	end
	if plr.Character then
		setupCharacter(plr.Character)
	end
	table.insert(connections, plr.CharacterAdded:Connect(setupCharacter))
	
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
	
	-- auto-skin
	task.spawn(function()
		while task.wait(.3) and module.On do
			for animal, data in pairs(animalsList) do
				if #PlayerInventory:GetChildren() >= inventoryLimit.Value then break end
				if data and data.Humanoid and data.Humanoid.Health <= 0 and data.Humanoid.RootPart and
					plr:DistanceFromCharacter(data.Humanoid.RootPart.Position) <= 10 then
					GeneralEvents.SkinAnimal:FireServer(animal)
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
	
	do -- animals ESP
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
							if objects[model] and objects[model]:FindFirstChild("TextLabel") then
								objects[model].TextLabel.TextColor3 = Color3.new(0.2, 0.2, 0.2) 
							end
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
		category:AddCheckbox("Animals ESP", function(state)
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
	
	do -- treasures ESP
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
		category:AddCheckbox("Treasures ESP", function(state)
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
	
	do -- auto-trash & throw all
		local autoTrash
		local throwAll
		
		local function filterTrash(item)
			if not item or not item:IsA("IntValue") then return end
			task.wait(.25)
			if autoTrash.Checked and (item.Value < 50 or throwAll.Checked) then
				GeneralEvents.Inventory:InvokeServer("Drop", item)
			end
		end
		
		autoTrash = category:AddCheckbox("Auto-trash")
		throwAll = category:AddCheckbox("Throw all")
		autoTrash:SetChecked(true)
		autoTrash.Inline = true
		
		for _,item in pairs(PlayerInventory:GetChildren()) do
			filterTrash(item)
		end
		
		table.insert(connections, PlayerInventory.ChildAdded:Connect(filterTrash))
	end
	
	do -- auto-free
		local freeYourselfConn
		local autoFree = category:AddCheckbox("Auto-free", function(state)
			if state then
				GeneralEvents.LassoEvents:FireServer("BreakFree")
				freeYourselfConn = lassod.Changed:Connect(function()
					if lassod.Value then
						task.wait(.1)
						if lassod.Value or hogtied.Value then
							GeneralEvents.LassoEvents:FireServer("BreakFree")
						end
					end
				end)
				table.insert(connections, freeYourselfConn)
			else
				if freeYourselfConn then freeYourselfConn:Disconnect() end
			end
		end)
		autoFree.Inline = true
		autoFree:SetChecked(true)
	end
	
	do -- superweapons
		for gunName,gunData in pairs(require(gunScripts:WaitForChild("GunStats"))) do
			gunData.AutoFire = true
			gunData.ReloadSpeed = 0.1
			gunData.equipTime = 0
			gunData.EquipDelay = 0
			gunData.Spread = 0
			gunData.FullReload = true
			gunData.MaxShots = 1000
		end
		
		local superWeapons = category:AddCheckbox("SuperWeapons", function(state)
			for gunName,gunData in pairs(require(gunScripts:WaitForChild("GunStats"))) do
				gunData.prepTime = state and 0.05 or 0.3
			end
		end)
	end
	
	do -- misc
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
			local closest, closestDist = nil, 0
			for _,piano in pairs(game.Workspace:GetChildren()) do
				if piano.Name == "Piano" and piano.PrimaryPart then
					local dist = plr:DistanceFromCharacter(piano.PrimaryPart.Position)
					if not closest or dist < closestDist then
						closest = piano
						closestDist = dist
					end
				end
			end
			if closest and closest:FindFirstChild("Seat") then
				GeneralEvents.SitDown:FireServer(closest.Seat)
			end
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
				GeneralEvents.MountHorse:InvokeServer(
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
		end).Inline = true
		
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
								GeneralEvents.Rob:FireServer("Safe", v)
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
							GeneralEvents.Rob:FireServer("Register",
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
		end)
		
		category:AddButton("Sell inventory", function()
			GeneralEvents.Inventory:InvokeServer("Sell")
		end).Inline = true
		
		do -- buy all preset gear
			local gear = {"Arrows", "RifleAmmo", "SniperAmmo", "BIG Dynamite", "Health Potion"}
			category:AddButton("Buy Max Gear", function()
				for _,item in pairs(gear) do
					GeneralEvents.BuyItem:InvokeServer(item, true)
				end
			end)
		end
		
		do -- autohopping
			local category = _G.SenHub:AddCategory("Auto-farm")
			
			local autoSell
			autoSell = category:AddCheckbox("Auto-sell", function(state)
				if state then
					task.spawn(function()
						while task.wait(.25) and autoSell.Checked and module.On do
							for _,store in pairs(shops:GetChildren()) do
								if store:IsA("Model") and store.PrimaryPart and plr:DistanceFromCharacter(store.PrimaryPart.Position) <= 15 then
									GeneralEvents.Inventory:InvokeServer("Sell")
									break
								end
							end
						end
					end)
				end
			end)
			autoSell:SetChecked(true)
			
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
							local maxHopDistance = 20
							local originalY = human.RootPart.Position.Y
							while hopping and module.On and human.Health > 0 and (human.RootPart.Position - targetPos).Magnitude > maxHopDistance do
								local nextHop = CFrame.new(Vector3.new(human.RootPart.Position.X, originalY, human.RootPart.Position.Z), targetPos) * CFrame.new(0, 0, -maxHopDistance)
								human.RootPart.CFrame = nextHop
								originalY = nextHop.Position.Y
								wait(0.1)
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
		if v ~= nil and v.Parent ~= nil then
			v:Destroy()
		end
	end
	hopping = false
	
	local gunScripts = ReplicatedStorage:FindFirstChild("GunScripts")
	if gunScripts then
		local gunLocalModule = require(gunScripts:FindFirstChild("GunLocalModule"))
		if gunLocalModule then
			if _G.GLM_Fire_ORIG then
				gunLocalModule.Fire = _G.GLM_Fire_ORIG
				_G.GLM_Fire_ORIG = nil
			end
			--[[
			if _G.GLM_CycleZoom_ORIG then
				gunLocalModule.cycleZoom = _G.GLM_CycleZoom_ORIG
				_G.GLM_CycleZoom_ORIG = nil
			end
			]]
		end
		local createShot = require(gunScripts:FindFirstChild("CreateShot"))
		if createShot then
			if _G.CreateShot_ORIG then
				createShot.CreateShot = _G.CreateShot_ORIG
				_G.CreateShot_ORIG = nil
			end
		end
	end
end

return module