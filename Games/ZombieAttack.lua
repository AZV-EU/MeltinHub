local module = {
	GameName = "Zombie Attack",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer

local UserInputService = game:GetService("UserInputService")

function module.PreInit()

end

local moduleOn = true
function module.Init(category, connections)
	local zombiesFolder = game.Workspace:WaitForChild("enemies")
	local bossFolder = game.Workspace:WaitForChild("BossFolder")

	local remoteEventContainer = game.ReplicatedStorage:WaitForChild("RemoteEventContainer")
	local commE = remoteEventContainer:WaitForChild("CommunicationE")
	local commF = remoteEventContainer:WaitForChild("CommunicationF")
	local gunRemote = game.ReplicatedStorage:WaitForChild("Gun")
	local gunRemote_Client = getconnections(gunRemote.OnClientEvent)[1]
	
	local knivesDb = require(game.ReplicatedStorage:WaitForChild("KnifeData"))
	local gunsDb = require(game.ReplicatedStorage:WaitForChild("GunData"))
	local tasksDb = require(game.ReplicatedStorage:WaitForChild("tasks"))
	
	plr:WaitForChild("PlayerScripts"):WaitForChild("GlitchCheck").Disabled = true
	
	local autoAim
	local autoFire
	
	for _, weaponData in pairs(gunsDb) do
		weaponData.Automatic = true
		weaponData.Spread = { Min = 0, Rec = 0, Inc = 0, Max = 0 }
	end
	print("Updated weapons data")
	
	
	for k,v in pairs(game:GetDescendants()) do
		if v:IsA("LocalScript") and v.Name == "GunController" and not v.Disabled then
			v.Disabled = true
			v.Disabled = false
		end
	end
	print("Reset gun controllers")
	
	
	local mainInterface = plr:WaitForChild("PlayerGui"):WaitForChild("MainInterface")
	local mainMenu = mainInterface:WaitForChild("MenuHolder"):WaitForChild("Main")
	local shopMainGui = mainMenu:WaitForChild("ShopMain"):WaitForChild("ItemHolder")
	local tasksMainGui = mainMenu:WaitForChild("TasksMain"):WaitForChild("ScrollingFrame")
	local gunsGui = shopMainGui:WaitForChild("Primary")
	local knivesGui = shopMainGui:WaitForChild("Secondary")
	
	for k,v in pairs(gunsGui:GetChildren()) do
		if v:IsA("ImageLabel") and v:FindFirstChild("NameLower") then
			local weaponData = gunsDb[v.Name]
			if weaponData then
				v.NameLower.Text = string.format("%d DPS", weaponData.Damage * weaponData.Firerate)
				v.NameLower.Visible = true
			end
		end
	end
	for k,v in pairs(knivesGui:GetChildren()) do
		if v:IsA("ImageLabel") and v:FindFirstChild("NameLower") then
			local knifeData = knivesDb[v.Name]
			if knifeData then
				v.NameLower.Text = string.format("%d|%d DPS", knifeData.Damage * knifeData.Speed, knifeData.ThrowDamage * knifeData.Speed)
				v.NameLower.Visible = true
			end
		end
	end
	print("Update DPS in shop UI")
	
	_G.AIMBOT_Raycast_GetFilterDescendantsInstances = function()
		local filter = {game.Workspace.CurrentCamera, plr.Character, game.Workspace.deadenemies}
		for k,v in pairs(game.Players:GetPlayers()) do
			if v.Character then
				table.insert(filter, v.Character)
			end
		end
		return filter
	end
	
	local lastFired = tick()
	local function fireWeapon(weapon, ray)
		if not weapon or not ray then return end
		
		local weaponData = gunsDb[weapon.Name]
		if not weaponData or tick() - lastFired < (1/weaponData.Firerate) then return end
		
		local originPart = weapon:FindFirstChild("Origin")
		if not originPart then return end
		local origin = originPart.Position
		
		local dataPacket = {
			["Normal"] = ray.Normal,
			["Direction"] = (ray.Instance.Position - origin).Unit,
			["Name"] = weapon.Name,
			["Hit"] = ray.Instance,
			["Origin"] = origin,
			["Pos"] = ray.Position
		}
		
		gunRemote:FireServer(dataPacket)
		pcall(gunRemote_Client.Function, dataPacket)
		
		local handle = weapon:FindFirstChild("Handle")
		if handle and handle:FindFirstChild("Fire") then
			handle.Fire.Volume = 0.1
			handle.Fire:Play()
		end
		
		lastFired = tick()
	end
	
	local currentWeapon
	
	_G.AIMBOT_FireSource = function()
		if currentWeapon and currentWeapon:FindFirstChild("Origin") then
			return currentWeapon.Origin.Position
		end
	end
	
	local function selectBestTarget(targetPool)
		--[[ priorities reminder:
			#1 : distance < 20 studs
			#2 : tasks (missions priorities)
			#3 : bosses
			#4 : other (by lowest health)
		]]
		
		-- absolute first priority
		for k,v in pairs(targetPool.normal) do
			if plr:DistanceFromCharacter(v[1]:GetPivot().Position) < 20 then
				return v[1], v[2]
			end
		end
		
		local sortedPool = {}
		
		local tasksTargets = {}
		for k,v in pairs(tasksMainGui:GetChildren()) do
			if v.Name == "taskTemplate" and v:FindFirstChild("name") then
				local task = tasksDb.nameSorted[v.name.Text]
				if task then
					local list = task.kill or task.killBoss
					if list then
						for target, _ in pairs(list) do
							tasksTargets[target] = true
						end
					end
				end
			end
		end
		
		-- bosses
		for k,v in pairs(targetPool.boss) do
			table.insert(sortedPool, v)
		end
		
		-- tasks
		for k,v in pairs(targetPool.normal) do
			if tasksTargets[v[1].Name] then
				table.insert(sortedPool, v)
			end
		end
		for k,v in pairs(targetPool.boss) do
			if tasksTargets[v[1].Name] then
				table.insert(sortedPool, v)
			end
		end
		
		-- other zombies
		
		table.sort(targetPool.normal, function(a,b) return a[1].Humanoid.Health < b[1].Humanoid.Health end)
		for k,v in pairs(targetPool.normal) do
			table.insert(sortedPool, v)
		end
		
		if #sortedPool > 0 then
			return sortedPool[1][3], sortedPool[1][2]
		end
	end
	
	local knifeController
	local function setupCharacter()
		plr:WaitForChild("PlayerGui"):WaitForChild("Aim"):WaitForChild("hitsound").Volume = 0
	end
	setupCharacter(plr.Character)
	table.insert(connections, plr.CharacterAdded:Connect(deafenHits))
	
	local forHackers = ReplicatedStorage:WaitForChild("forhackers")
	autoAim = category:AddCheckbox("Auto-aim", function(state)
		if state then
			task.spawn(function()
				while task.wait() and autoAim.Checked and module.On do
					_G.MouseEmulator:FreeMouseControl()
					if plr.Character then
						currentWeapon = plr.Character:FindFirstChildWhichIsA("Tool")
					end
					if currentWeapon then
						knifeController = currentWeapon:FindFirstChild("KnifeController")
						if knifeController then 	-- knife attack
							local targetPool = {
								normal = {},
								boss = {}
							}
							
							for k,v in pairs(zombiesFolder:GetChildren()) do
								if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
									table.insert(targetPool.normal, {v, nil, v.Humanoid.RootPart})
								end
							end
							for k,v in pairs(game.Players:GetPlayers()) do
								if v ~= plr and v.Character and v.Character:FindFirstChild("plr_animator") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
									pcall(function() v.Character.Parent = zombiesFolder end)
									table.insert(targetPool.normal, {v.Character, nil, v.Character.Humanoid.RootPart})
								end
							end
							for k,v in pairs(bossFolder:GetChildren()) do
								if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
									table.insert(targetPool.boss, {v, nil, v.Humanoid.RootPart})
								end
							end
							local targetPart = selectBestTarget(targetPool)
							if targetPart and autoFire.Checked then
								forHackers:InvokeServer("hit", currentWeapon.Name, targetPart)
								task.wait(.3)
							end
						else 				-- gun attack
							local targetPool = {
								normal = {},
								boss = {}
							}
							
							local los, ray, part
							for k,v in pairs(zombiesFolder:GetChildren()) do
								if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
									los, ray, part = _G.AIMBOT_CheckLoS(v)
									if los then
										table.insert(targetPool.normal, {v, ray, part})
									end
								end
							end
							for k,v in pairs(game.Players:GetPlayers()) do
								if v ~= plr and v.Character and v.Character:FindFirstChild("plr_animator") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
									los, ray, part = _G.AIMBOT_CheckLoS(v.Character)
									if los then
										pcall(function() v.Character.Parent = zombiesFolder end)
										table.insert(targetPool.normal, {v.Character, ray, part})
									end
								end
							end
							for k,v in pairs(bossFolder:GetChildren()) do
								if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
									los, ray, part = _G.AIMBOT_CheckLoS(v)
									if los then
										table.insert(targetPool.boss, {v, ray, part})
									end
								end
							end
							local targetPart, targetRay = selectBestTarget(targetPool)
							if targetPart then
								if autoFire.Checked then
									fireWeapon(currentWeapon, targetRay)
								else
									_G.MouseEmulator:TakeMouseControl()
									_G.MouseEmulator:TargetPart(targetPart)
									return
								end
							end
						end
					end
				end
			end)
		else
			_G.MouseEmulator:FreeMouseControl()
		end
	end)
	autoAim.Inline = true
	autoFire = category:AddCheckbox("Auto-fire")
	autoAim:SetChecked(true)
	autoFire:SetChecked(true)
	
	do
		local tasksNames = {}
		for k,v in pairs(tasksDb.nameSorted) do
			table.insert(tasksNames, v.name)
		end
		local rolling = false
		
		local function rollTask(taskId, slot)
			rolling = true
			local requestedTask = tasksDb.nameSorted[tasksNames[taskId]]
			print("Rolling requested task '" .. requestedTask.name .. "' on slot", slot)
			while moduleOn and rolling and task.wait(0) do
				commF:InvokeServer("discardTask", slot)
				
				for k,v in pairs(tasksMainGui:GetChildren()) do
					if k == slot and v.Name == "taskTemplate" and v:FindFirstChild("name") and v.name.Text == requestedTask.name then
						rolling = false
						break
					end
				end
			end
			rolling = false
		end
		local slot1Selection = category:AddDropdown("Desired Task #1", tasksNames, 1, print)
		slot1Selection.Inline = true
		local slot2Selection = category:AddDropdown("Desired Task #2", tasksNames, 1, print)
		
		local rollSlot1
		rollSlot1 = category:AddButton("Roll Task #1 & #2", function()
			if not rolling then
				rollSlot1:SetText("Rolling...")
				rollTask(slot1Selection.SelectedIndex, 1)
			end
			rolling = false
			rollSlot1:SetText("Roll Task #1")
		end)
		rollSlot1.Inline = true
		
		local rollSlot2
		rollSlot2 = category:AddButton("Roll Task #2", function()
			if not rolling then
				rollSlot2:SetText("Rolling...")
				rollTask(slot2Selection.SelectedIndex, 2)
			end
			rolling = false
			rollSlot2:SetText("Roll Task #2")
		end)
	end
end

function module.Shutdown()
	moduleOn = false
end

return module