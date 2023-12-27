local module = {
	On = false
}

local plr = game.Players.LocalPlayer

local ReplicatedStorage = _G.SafeGetService("ReplicatedStorage")
local RunService = _G.SafeGetService("RunService")

function module.PreInit()
	
end

function module.Init(category, connections)
	local Remotes = ReplicatedStorage:WaitForChild("Remote")
	local CoinsRemote = Remotes:WaitForChild("Drops"):WaitForChild("Coins")
	local ItemsRemote = Remotes:WaitForChild("Drops"):WaitForChild("Items")
	local CaughtSpiritRemote = Remotes:WaitForChild("Drops"):WaitForChild("CaughtSpirit")
	local TeleportRemote = Remotes:WaitForChild("Player"):WaitForChild("Teleport")
	local SetTargetRemote = Remotes:WaitForChild("Pets"):WaitForChild("SetTarget")
	local OpenOrbsRemote = Remotes:WaitForChild("Orbs"):WaitForChild("OpenOrbs")
	
	local RaidRemotes = {
		SetInRaid = Remotes:WaitForChild("Raid"):WaitForChild("SetInRaid"),
		SetRaidSetting = Remotes:WaitForChild("Raid"):WaitForChild("SetRaidSetting"),
		StartRaidFromRoom = Remotes:WaitForChild("Raid"):WaitForChild("StartRaidFromRoom")
	}
	
	local ModuleScripts = ReplicatedStorage:WaitForChild("ModuleScripts")
	local RaidData = require(ModuleScripts:WaitForChild("Config"):WaitForChild("RaidData"))
	local DifficultiesData = require(ModuleScripts:WaitForChild("Config"):WaitForChild("Difficulties"))
	
	local Bindables = ReplicatedStorage:WaitForChild("Bindable")
	local TeleportedBindable = Bindables:WaitForChild("Player"):WaitForChild("Teleported")
	local SendAllPetsBindable = Bindables:WaitForChild("Pets"):WaitForChild("SendAllPets")
	local SetPetTargetBindable = Bindables:WaitForChild("Pets"):WaitForChild("SetPetTarget")
	
	local Worlds = game.Workspace:WaitForChild("Worlds")
	local Effects = game.Workspace:WaitForChild("Effects")
	local Pets = game.Workspace:WaitForChild("Pets")
	
	local WorldInstanceId = plr:WaitForChild("WorldInstanceId")
	local PlayerPets = plr:WaitForChild("Pets")
	
	--[[
	local function UpdateWorlds()
		task.wait(2)
		for _,world in pairs(Worlds:GetChildren()) do
			for _,obj in pairs(world:GetChildren()) do
				
				if obj.Name == "SpiritPositions" and v:IsA("Model") then
					for _,sPos in pairs(obj:GetChildren()) do
						if v:IsA("BasePart") then
							v.Transparency = 0
						end
					end
				end
				
			end
		end
	end
	table.insert(connections, TeleportedBindable.Event:Connect(UpdateWorlds))]]
	
	local autoTower = category:AddCheckbox("Auto Tower")
	autoTower:SetChecked(true)
	autoTower.Inline = true
	local autoPickup = category:AddCheckbox("Auto Pickup")
	autoPickup:SetChecked(true)
	local autoSpirit = category:AddCheckbox("Auto Spirit")
	--autoSpirit:SetChecked(true)
	
	task.spawn(function()
		while task.wait(5) and module.On do
			if autoSpirit.Checked then
				for _,spirit in pairs(Effects:GetChildren()) do
					if spirit.Name == "Spirit" or spirit.Name == "SpecialSpirit" then
						_G.TeleportPlayerTo(spirit:GetPivot().Position)
						break
					end
				end
			end
			if autoPickup.Checked then
				local dist
				for _,drop in pairs(Effects:GetChildren()) do
					if drop:IsA("BasePart") and drop:FindFirstChild("Pickup") and drop.Pickup:IsA("BindableEvent") and not drop:FindFirstChild("Main.Attachment") then
						dist = plr:DistanceFromCharacter(drop.Position)
						if dist >= 50 and dist < 1000 then
							drop.Pickup:Fire()
						end
					end
				end
			end
			if autoTower.Checked then
				local towerWorld = Worlds:FindFirstChild("Tower")
				if towerWorld then
					local subTowerWorld = towerWorld:FindFirstChild(WorldInstanceId.Value)
					if subTowerWorld then
						local chest = subTowerWorld:FindFirstChild("TowerChest")
						if chest and chest:FindFirstChild("HumanoidRootPart") and chest.HumanoidRootPart:FindFirstChild("ChestPrompt") then
							--_G.TeleportPlayerTo(chest.HumanoidRootPart.Position)
							fireproximityprompt(chest.HumanoidRootPart.ChestPrompt)
						end
					end
				end
			end
		end
	end)
	
	--[[
	local talentReroll = category:AddCheckbox("Talent Reroll")
	local targetTalent = category:AddDropdown("Target Rank", {"B", "A", "S", "SS", "SSS"}, 1)
	]]
	
	
	
	do -- raids
		local category = _G.SenHub:AddCategory("Raids")
		
		local targetHoldCFrame
		
		local autoRaid = category:AddCheckbox("Auto Raid", function(state)
			if state then
				RunService:BindToRenderStep("raidcframehold", Enum.RenderPriority.Camera.Value - 2, function()
					if targetHoldCFrame and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
						plr.Character.HumanoidRootPart.CFrame = targetHoldCFrame
						plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
						plr.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
					end
				end)
			else
				RunService:UnbindFromRenderStep("raidcframehold")
			end
		end)
		autoRaid.Inline = true
		local autoStart = category:AddCheckbox("Auto Start")
		local autoRaidStatus = category:AddLabel("Idle")
		
		local validRaids = {}
		local raidsDisplayList = {}
		for raidTag,raidData in pairs(RaidData) do
			if not raidData.IsTournament then
				setreadonly(raidData, false)
				raidData.RaidTag = raidTag
				raidData.CustomDropdownDisplayName = raidData.DisplayName
				table.insert(validRaids, raidData)
			end
		end
		table.sort(validRaids, function(a, b)
			return a.RaidNum < b.RaidNum
		end)
		
		local targetRaid = category:AddDropdown("Selected Raid", validRaids, #validRaids)
		
		local validDifficulties = {}
		for _,difficultyData in pairs(DifficultiesData) do
			table.insert(validDifficulties, difficultyData.DisplayName)
		end
		table.insert(validDifficulties, "Nightmare")
		local targetDifficulty = category:AddDropdown("Raid Difficulty", validDifficulties, 3)
		
		local titanTrial = category:AddCheckbox("Titan trial")
		titanTrial.Inline = true
		local useRaidKeys = category:AddCheckbox("Use Raid Keys")
		
		local function GetRaidRooms()
			local hub = Worlds:FindFirstChild("Hub")
			if not hub then return end
			local dt = hub:FindFirstChild("DungeonTemple")
			if not dt then return end
			local fm = dt:FindFirstChild("1")
			if not fm then return end
			
			local raidRoomsModel = fm:FindFirstChild("RaidRooms")
			if not raidRoomsModel then return end
			
			local raidRooms = {}
			for _,room in pairs(raidRoomsModel:GetChildren()) do
				raidRooms[room] = {
					Owner = room:FindFirstChild("Owner").Value,
					Players = {},
					CooldownTimer = room:FindFirstChild("CooldownTimer").Value,
					Settings = room:FindFirstChild("Settings"):GetAttributes()
				}
				for _,player in pairs(room.Players:GetChildren()) do
					if player:IsA("ObjectValue") and player.Value ~= nil then
						table.insert(raidRooms[room].Players, player.Value)
					end
				end
			end
			return raidRooms
		end
		
		local function GetPets()
			local pets = {}
			for _,petValue in pairs(PlayerPets:GetChildren()) do
				if petValue:IsA("ObjectValue") and petValue.Value ~= nil then
					table.insert(pets, petValue.Value)
				end
			end
			return pets
		end
		
		local function SetPetsTarget(enemy)
			for _,pet in pairs(GetPets()) do
				local currentTarget = pet:FindFirstChild("Target")
				if currentTarget and currentTarget.Value ~= enemy then
					--SetTargetRemote:FireServer(pet, enemy, enemy:GetPivot().Position)
					SetPetTargetBindable:Fire(pet, enemy)
				end
			end
		end
		
		task.spawn(function()
			local endedRaidTime
			local lastEnemy
			while task.wait(.3) and module.On do
				if autoRaid.Checked then
					local raidsWorld = Worlds:FindFirstChild("Raids")
					if raidsWorld then
						local currentRaidWorld = raidsWorld:FindFirstChild(WorldInstanceId.Value)
						if not currentRaidWorld then
							autoRaidStatus:SetText("Waiting for Raid World")
							continue
						end
						local chests = {}
						local hidden = currentRaidWorld:FindFirstChild("Hidden")
						if hidden then
							local hiddenChests = hidden:FindFirstChild("Chests", true)
							if hiddenChests then
								for _,chest in pairs(hiddenChests:GetChildren()) do
									if chest:IsA("Model") and chest:FindFirstChild("ChestPrompt", true) then
										table.insert(chests, chest)
									end
								end
							end
						end
						for _,zone in pairs(currentRaidWorld:GetChildren()) do
							if zone:FindFirstChild("Chests") then
								for _,chest in pairs(zone.Chests:GetChildren()) do
									if chest:IsA("Model") and chest:FindFirstChild("ChestPrompt", true) then
										table.insert(chests, chest)
									end
								end
							end
						end
						for _,chest in pairs(chests) do
							if not autoRaid.Checked then break end
							if not chest:GetAttribute("Collected") then
								if chest.Name == "RaidChest" or (chest.Name == "RaidChest2" and useRaidKeys.Checked) then
									local chestRoot = chest.HumanoidRootPart
									local chestPrompt = chestRoot:FindFirstChild("ChestPrompt")
									if chestPrompt then
										autoRaidStatus:SetText("Collecting chest...")
										_G.TeleportPlayerTo(chestRoot.Position)
										task.wait(.3)
										fireproximityprompt(chestPrompt)
										task.wait(7)
									else
										chest:SetAttribute("Collected", true)
									end
								end
							end
						end
						
						local endTime = currentRaidWorld:GetAttribute("EndTime")
						if autoRaid.Checked and endTime and endTime <= 0 then
							if endedRaidTime and tick() - endedRaidTime > 3 then
								autoRaidStatus:SetText("Teleporting back...")
								TeleportRemote:FireServer("Hub")
								repeat task.wait(.3) until Worlds:FindFirstChild("Hub") ~= nil or not module.On
								continue
							elseif not endedRaidTime then
								endedRaidTime = tick()
							end
						end
						
						-- ENEMY SPAWN POINTS DISTANCE
						local enemiesModel = raidsWorld:FindFirstChild("Enemies")
						if autoRaid.Checked and enemiesModel then
							local enemies = {}
							for _,zone in pairs(currentRaidWorld:GetChildren()) do
								if zone:FindFirstChild("EnemySpawners") then
									for _,spawner in pairs(zone.EnemySpawners:GetChildren()) do
										for _,enemy in pairs(enemiesModel:GetChildren()) do
											if enemy.Name == spawner.Name and enemy:GetAttribute("Health") ~= nil and enemy:GetAttribute("Health") > 0 and enemy:FindFirstChild("HumanoidRootPart") and (spawner.Position - enemy.HumanoidRootPart.Position).Magnitude < 200 then
												table.insert(enemies, enemy)
											end
										end
									end
								end
							end
							local closest, cDist
							for _,enemy in pairs(enemies) do
								local root = enemy:FindFirstChild("HumanoidRootPart")
								if root then
									local dist = plr:DistanceFromCharacter(root.Position)
									if not closest or dist < cDist then
										closest = enemy
										cDist = dist
									end
								end
							end
							if closest then
								autoRaidStatus:SetText("Attacking enemy")
								if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
									--local autoAttack = Effects:FindFirstChild("AutoAttack")
									--if autoAttack and autoAttack:FindFirstChild("Radius") then
										--targetHoldCFrame = CFrame.new(closest:GetPivot().Position + Vector3.new(0, autoAttack.Radius.Size.X*.25, 0))
										targetHoldCFrame = CFrame.new(closest:GetPivot().Position + Vector3.new(0, 40, 0))
										--SendAllPetsBindable:Fire(closest)
										SetPetsTarget(closest)
									--end
								end
							else
								targetHoldCFrame = nil
								if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
									plr.Character.HumanoidRootPart.Anchored = false
								end
								autoRaidStatus:SetText("Waiting for enemy")
							end
							lastEnemy = closest
						end
					else
						targetHoldCFrame = nil
						local currentRoom, currentRoomData
						local raidRooms = GetRaidRooms()
						if not raidRooms then
							autoRaidStatus:SetText("No rooms available")
							continue
						end
						for room,roomData in pairs(raidRooms) do
							if roomData.Owner == plr then
								currentRoom = room
								currentRoomData = roomData
								break
							end
						end
						if not currentRoom then
							autoRaidStatus:SetText("Selecting room...")
							for room,roomData in pairs(raidRooms) do
								if roomData.Owner == nil then
									_G.TeleportPlayerTo(room.Position)
									break
								end
							end
						end
						if currentRoom and currentRoomData then
							if targetRaid.SelectedOption then
								
								if currentRoomData.CooldownTimer > 0 then
									autoRaidStatus:SetText("Waiting for cooldown...")
									task.wait(.7)
									continue
								end
								
								if not currentRoomData.Settings.Private then
									autoRaidStatus:SetText("Setting Raid Room Private")
									RaidRemotes.SetRaidSetting:FireServer(currentRoom, "Private", true)
									task.wait(.3)
									continue
								end
								
								if currentRoomData.Settings.TargetWorld ~= targetRaid.SelectedOption.RaidTag then
									autoRaidStatus:SetText(string.format("Selecting raid '%s'", targetRaid.SelectedOption.DisplayName))
									RaidRemotes.SetRaidSetting:FireServer(currentRoom, "TargetWorld", targetRaid.SelectedOption.RaidTag)
									task.wait(.3)
									continue
								end
								
								if currentRoomData.Settings.Giant ~= titanTrial.Checked then
									autoRaidStatus:SetText("Selecting Titan Trial")
									RaidRemotes.SetRaidSetting:FireServer(currentRoom, "Giant", titanTrial.Checked)
									task.wait(.3)
									continue
								end
								
								if not titanTrial.Checked and currentRoomData.Settings.Difficulty ~= targetDifficulty.SelectedOption then
									autoRaidStatus:SetText(string.format("Selecting difficulty '%s'", targetDifficulty.SelectedOption))
									RaidRemotes.SetRaidSetting:FireServer(currentRoom, "Difficulty", targetDifficulty.SelectedOption)
									task.wait(.3)
									continue
								end
								
								if autoStart.Checked then
									autoRaidStatus:SetText("Starting raid...")
									endedRaidTime = nil
									RaidRemotes.StartRaidFromRoom:FireServer(currentRoom)
									task.wait(3)
								else
									autoRaidStatus:SetText("Ready")
									task.wait(.7)
								end
							else
								autoRaidStatus:SetText("Raid not selected...")
								continue
							end
						end
					end
				else
					targetHoldCFrame = nil
					autoRaidStatus:SetText("Idle")
				end
			end
		end)
	end
end

function module.Shutdown()
	RunService:UnbindFromRenderStep("raidcframehold")
end

return module