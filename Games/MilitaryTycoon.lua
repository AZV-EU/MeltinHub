local module = {
	GameName = "Military Tycoon",
	ModuleVersion = "1.0"
}

local moduleOn = true

local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local events = game.ReplicatedStorage:WaitForChild("Events")

local gunShootEvent = events:WaitForChild("ShootEvent")
local rpgShootEvent = events:WaitForChild("RPG")

local gunReloadEvent = events:WaitForChild("ReloadEvent")

local models = game.ReplicatedStorage.Models
local modules = game.ReplicatedStorage.Modules
local gunsInfo = require(modules:FindFirstChild("GunInfo")) 
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local characters = game.Workspace:WaitForChild("Characters")
local KnitModule = require(game.ReplicatedStorage.Packages.Knit)
KnitModule.OnStart():expect()
local DataController = KnitModule.GetController("DataController")

local connections2 = {}

local currentTool, currentTarget = nil, nil
local function generateRaycast(origin, target, vehicle)
	local filter = {plr.Character, mouse.TargetFilter}
	if vehicle then
		table.insert(filter, vehicle)
	end
	if game.Workspace.CurrentCamera:FindFirstChild("ViewModel") then
		table.insert(filter, game.Workspace.CurrentCamera.ViewModel)
	end
	for k,v in pairs(game.Workspace:GetChildren()) do
		if v:FindFirstChild("Humanoid") then
			for x,o in pairs(v:GetChildren()) do
				if o:IsA("Accessory") or o:IsA("Tool") or o.Name == "ArmorFolder" then
					table.insert(filter, o)
				end
			end
		end
	end

	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.FilterDescendantsInstances = filter
	raycastParams.IgnoreWater = true
	return game.Workspace:Raycast(
		origin,
		target,
		raycastParams
	)
end

local function GetPlayerTycoon()
	for k,v in pairs(game.Workspace:WaitForChild("PlayerTycoons"):GetChildren()) do
		if v:GetAttribute("Player") == plr.UserId then
			return v
		end
	end
end

local function GetEquipmentGiver(equipmentName)
	local myTycoon = GetPlayerTycoon()
	if myTycoon and myTycoon:FindFirstChild("Unlocks") then
		local equipment = myTycoon.Unlocks:FindFirstChild(equipmentName)
		if equipment then
			local armorData = equipment:FindFirstChild("Armor", true)
			if armorData then
				return armorData.Parent:FindFirstChild("Torso")
			end
		end
		for _, model in pairs(myTycoon.Unlocks:GetChildren()) do
			if model:FindFirstChild("Giver") and model:FindFirstChild("Gear") and model.Gear:IsA("StringValue") and model.Gear.Value == equipmentName then
				return model.Giver
			end
		end
	end
end

local cooldown, reloading, reloadStart = tick(), false, tick()
local function fireAt(originPos, targetPos, object, normal)
	if gunsInfo[currentTool.Name] and tick() - cooldown < gunsInfo[currentTool.Name].RateOfFire then return end
	if not currentTool:FindFirstChild("Ammo") then return end
	if currentTool.Ammo.Value <= 0 and reloading then
		if reloading and tick() - reloadStart > 30 then reloading = false warn("Over 30 seconds reload for", currentTool.Name) end
		return
	end
	if currentTool.Ammo.Value > 0 then
		reloading = false
		local tracer = models:FindFirstChild("Tracer"):Clone()
		local originTracerCFrame = CFrame.lookAt(originPos, targetPos)
		tracer.CFrame = originTracerCFrame
		tracer.Parent = game.Workspace:FindFirstChild("MouseFilter")
		game.Debris:AddItem(tracer, 10)
		
		if gunsInfo[currentTool.Name] then
			local dist = (originPos - targetPos).Magnitude
			spawn(function()
				RunService.Heartbeat:Wait()
				local conn = nil
				conn = RunService.Heartbeat:Connect(function(deltaTime)
					tracer.CFrame = tracer.CFrame * CFrame.new(CFrame.new(0, 0, -1000).Position * deltaTime)
					if not tracer or dist <= (tracer.Position - originTracerCFrame.Position).Magnitude then
						if tracer and tracer:FindFirstChild("Trail") then
							game.Debris:AddItem(tracer, 1)
							tracer.Trail.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0),
								NumberSequenceKeypoint.new(1, 1) });
						end
						conn:Disconnect()
						if object and object:IsDescendantOf(game.Workspace:FindFirstChild("Map")) then
							local dust = models:FindFirstChild("Dust"):Clone()
							dust.CFrame = CFrame.new(targetPos, targetPos + normal)
							dust.Effect.Color = ColorSequence.new(object.Color)
							dust.Parent = game.Workspace:FindFirstChild("MouseFilter")
							game.Debris:AddItem(dust, 2)
							spawn(function()
								wait(0.2);
								dust.Effect.Enabled = false;
							end)
						end
					end
				end)
				table.insert(connections2, conn)
			end)
			gunShootEvent:FireServer(
				{
					targetPos
				},
				{
					originPos
				},
				{
					object
				},
				{
					targetPos
				},
				{
					normal
				}
			)
		elseif currentTool.Name == "RPG" then
			rpgShootEvent:FireServer(CFrame.new(targetPos))
		else
			local shootEvent = events:FindFirstChild(currentTool.Name)
			if shootEvent then
				shootEvent:FireServer(CFrame.new(targetPos))
			end
		end
		cooldown = tick()
		task.wait()
		if currentTool.Ammo.Value <= 0 then
			reloading = true
			reloadStart = tick()
			gunReloadEvent:FireServer()
			if gunsInfo[currentTool.Name] then
				gunReloadEvent:FireServer()
			else
				local reloadEvent = events:FindFirstChild(currentTool.Name .. "Reload")
				if reloadEvent then
					reloadEvent:FireServer()
				end
			end
		end
	else
		reloading = true
		reloadStart = tick()
		if gunsInfo[currentTool.Name] then
			gunReloadEvent:FireServer()
		else
			local reloadEvent = events:FindFirstChild(currentTool.Name .. "Reload")
			if reloadEvent then
				reloadEvent:FireServer()
			end
		end
	end
end

local function FindTargetAtMouse(maxDist, vehicle)
	local target, targetDistToMouse, targetDist, targetRaycast = nil, 0, 0, nil
	
	local possibleTargets = {}
	for k,v in pairs(game.Players:GetPlayers()) do
		if v ~= plr and not plr:IsFriendsWith(v.UserId) and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("Head") then
			table.insert(possibleTargets, v.Character.Head)
		end
	end
	for k,v in pairs(characters:GetChildren()) do
		if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("Head") then
			if v:GetAttribute("ID") ~= plr.UserId then
				table.insert(possibleTargets, v.Head)
			end
		end
	end
	local mousePos = Vector2.new(mouse.X, mouse.Y)
	local targetScreenPos
	local outPos = plr.Character.Humanoid.RootPart.Position
	local distToMouse, dist, raycastHit
	for k,v in pairs(possibleTargets) do
		if v ~= nil then
			dist = plr:DistanceFromCharacter(v.Position)
			if dist and dist < maxDist then
				targetScreenPos = game.Workspace.CurrentCamera:WorldToScreenPoint(v.Position)
				if targetScreenPos.Z > 0 then
					raycastHit = generateRaycast(outPos, (v.Position - outPos).Unit * maxDist, vehicle)
					if raycastHit and raycastHit.Instance and (raycastHit.Instance:IsDescendantOf(v.Parent) or raycastHit.Instance:IsDescendantOf(game.Workspace.Vehicles)) then
						distToMouse = (Vector2.new(targetScreenPos.X, targetScreenPos.Y) - mousePos).Magnitude
						if not target or distToMouse < targetDistToMouse then
							target = v
							if raycastHit.Instance:IsDescendantOf(game.Workspace.Vehicles) then
								for k, vehicle in pairs(game.Workspace.Vehicles:GetChildren()) do
									if raycastHit.Instance:IsDescendantOf(vehicle) then
										target = (vehicle.PrimaryPart or vehicle:FindFirstChild("DriverSeat")) or v
										break
									end
								end
							end
							targetDist = dist
							targetDistToMouse = distToMouse
							targetRaycast = raycastHit
						end
					end
				end
			end
		end
	end
	return target, targetRaycast
end

function module.Init(category, connections)
	local precisionAim = category:AddCheckbox("Lock to valid targets only")
	precisionAim:SetChecked(true)
	do
		local target, outPos, raycastHit, range
		table.insert(connections, RunService.Stepped:Connect(function()
			if currentTool and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
				outPos = plr.Character.HumanoidRootPart.Position
				range = gunsInfo[currentTool.Name] and gunsInfo[currentTool.Name].DamageDropoff or 1000
				target, raycastHit = FindTargetAtMouse(range)
				if target then
					fireAt(outPos, raycastHit.Position, raycastHit.Instance, raycastHit.Normal)
				elseif not precisionAim.Checked then
					raycastHit = generateRaycast(outPos, (mouse.Hit.Position - outPos).Unit * range)
					if raycastHit and raycastHit.Instance then
						fireAt(outPos, raycastHit.Position, raycastHit.Instance, raycastHit.Normal)
					end
				end
			end
		end))
	end
	
	for k,v in pairs(plr:WaitForChild("PlayerGui"):GetChildren()) do
		if v:IsA("ScreenGui") and v:FindFirstChild("Sound") then
			v.Sound.Volume = 0
			break
		end
	end
	
	local autoEquip = category:AddCheckbox("Auto-loadout")
	autoEquip.Inline = true
	autoEquip:SetChecked(true)
	
	local LOADOUT = {"SydArmor", "Barrett", "Minigun", "RPG", "FirstAid", "Vehicle Repair"}
	local function equipLoadout()
		if plr and plr.Character and plr.Character:FindFirstChild("Humanoid") then
			plr.Character.Humanoid:UnequipTools()
		end
		for _, equipmentName in ipairs(LOADOUT) do
			if plr and plr:FindFirstChild("Backpack") and not plr.Backpack:FindFirstChild(equipmentName) then
				local giver = GetEquipmentGiver(equipmentName)
				if giver then
					local pp = giver:FindFirstChildWhichIsA("ProximityPrompt", true)
					if pp then
						_G.TeleportPlayerTo(giver.Position + Vector3.new(0, 3, 0))
						task.wait(0.33)
						fireproximityprompt(pp)
					end
				end
			end
		end
	end
	table.insert(connections, plr.CharacterAdded:Connect(function()
		task.wait(0.5)
		if autoEquip.Checked then
			equipLoadout()
		end
	end))
	
	category:AddButton("Equip Loadout", equipLoadout)

	if plr.Character and plr.Character:FindFirstChild("Humanoid") then
		plr.Character.Humanoid:UnequipTools()
	end
	
	local buying = false
	local buyAllBtn
	buyAllBtn = category:AddButton("Buy all buttons", function()
		if buying then
			buying = false
		else
			buying = true
			local tycoon = GetPlayerTycoon()
			if tycoon and tycoon:FindFirstChild("BuyButton") and tycoon:FindFirstChild("Buttons") then
				local buy = tycoon.BuyButton
				while buying do
					local cheapest = nil
					for k,v in pairs(tycoon.Buttons:GetChildren()) do
						if v:GetAttribute("Gems") == nil and v:GetAttribute("Price") and v:GetAttribute("Price") > 0 then
							local data = {Button = v, Price = v:GetAttribute("Price")}
							if not cheapest or data.Price < cheapest.Price then
								cheapest = data
							end
						end
					end
					if not cheapest then break end
					if DataController:Get().OldData.Cash < cheapest.Price then break end
					buyAllBtn._GuiObject.Text = "Buy '" .. cheapest.Button.Name .."'..."
					buy:InvokeServer(cheapest.Button.Name)
				end
				buying = false
			end
		end
		_G.SenHub:Update()
	end)
	
	category:AddButton("Begin raid", function()
		local closest, closestDist = nil, 0
		for k, tycoon in pairs(game.Workspace.PlayerTycoons:GetChildren()) do
			if tycoon:GetAttribute("Player") ~= plr.UserId then
				local raid = tycoon:FindFirstChild("Raid", true)
				if raid and raid:IsA("BasePart") then
					local dist = plr:DistanceFromCharacter(raid.Position)
					if not closest or dist < closestDist then
						closest = raid
						closestDist = dist
					end
				end
			end
		end
		if closest then
			_G.TouchObject(closest)
		end
	end).Inline = true
	
	category:AddButton("Loot raid", function()
		for k, tycoon in pairs(game.Workspace.PlayerTycoons:GetChildren()) do
			if tycoon:GetAttribute("Player") ~= plr.UserId then
				for k,v in pairs(tycoon.Unlocks:GetDescendants()) do
					if v.Name == "Safe" or v.Name == "DiamondMiner" then
						game.ReplicatedStorage.Events.Raid.LootSafe:FireServer(
							v
						)
					end
				end
			end
		end
	end)
	
	category:AddButton("Loot bank", function()
		for _, pile in pairs(game.Workspace.Bank.BankMission.Money:GetChildren()) do
			if pile:FindFirstChild("Main") and pile.Main:FindFirstChild("HackAttachment") then
				local pp = pile.Main.HackAttachment:FindFirstChildWhichIsA("ProximityPrompt")
				if pp then
					_G.TeleportPlayerTo(pile.Main.Position + Vector3.new(0, 3, 0))
					task.wait(0.33)
					for i = 1, 8 do
						if pp and pp.Parent then
							fireproximityprompt(pp)
							task.wait(0.33)
						end
					end
				end
			end
		end
		for _, safes in pairs(game.Workspace.BankModel:GetChildren()) do
			if safes.Name == "Safes" then
				for _, safe in pairs(safes:GetChildren()) do
					if safe:FindFirstChild("Enabled") and safe.Enabled:FindFirstChild("HackAttachment") then
						local pp = safe.Enabled.HackAttachment:FindFirstChildWhichIsA("ProximityPrompt")
						if pp then
							_G.TeleportPlayerTo(safe.Enabled.Position)
							task.wait(0.33)
							fireproximityprompt(pp)
						end
					end
				end
			end
		end
	end).Inline = true
	
	local missionRunning = false
	local autoMission
	autoMission = category:AddButton("Auto-mission", function()
		if missionRunning then
			autoMission:SetText("Auto-mission")
			missionRunning = false
		else
			missionRunning = true
			autoMission:SetText("Starting...")
			while moduleOn and missionRunning and task.wait(2) do
				local mission = game.Workspace:FindFirstChild("Mission")
				if not mission then
					autoMission:SetText("Intermission...")
					game:GetService("ReplicatedStorage").Packages.Knit.Services.MissionService.RF.Join:InvokeServer(1)
					task.wait(1)
					game:GetService("ReplicatedStorage").Packages.Knit.Services.MissionService.RF.Vote:InvokeServer(1, "Hard")
				else
					autoMission:SetText("Beginning...")
					task.wait(15)
					local stages = {}
					for _, stage in pairs(mission.Stages:GetChildren()) do
						table.insert(stages, stage)
					end
					table.sort(stages, function(a,b) return a.Name < b.Name end)
					local previousStageCompleted = true
					local previousStageTime = tick()
					for i, stage in ipairs(stages) do
						autoMission:SetText("Stage " .. tostring(stage.Name) .. "...")
						for _, objective in pairs(stage:GetChildren()) do
							
							if objective.Name == "C4Door" then
								local part = objective:FindFirstChild("C4")
								if part and part.Transparency ~= 1 then
									local pp = part:FindFirstChildWhichIsA("ProximityPrompt")
									if pp then
										previousStageTime = tick()
										_G.TeleportPlayerTo(part.CFrame * CFrame.new(-6, 0, 0))
										task.wait(0.33)
										if not previousStageCompleted then
											repeat task.wait() until not moduleOn or not missionRunning or previousStageCompleted or tick() - previousStageTime > 30
										end
										_G.TeleportPlayerTo(part.CFrame * CFrame.new(-6, 0, 0))
										task.wait(0.33)
										fireproximityprompt(pp)
										previousStageCompleted = false
										task.spawn(function()
											repeat task.wait() until not moduleOn or not missionRunning or part.Transparency == 1
											task.wait(1.5)
											previousStageCompleted = true
										end)
									end
								end
							elseif objective.Name == "MissionDrill" then
								local drillPart = objective:FindFirstChild("DrillPart")
								if drillPart then
									local pp = drillPart:FindFirstChildWhichIsA("ProximityPrompt")
									if pp then
										previousStageTime = tick()
										_G.TeleportPlayerTo(drillPart.Position)
										task.wait(0.33)
										if not previousStageCompleted then
											repeat task.wait(0.33) until not moduleOn or not missionRunning or previousStageCompleted or tick() - previousStageTime > 30
										end
										_G.TeleportPlayerTo(drillPart.Position)
										task.wait(0.33)
										fireproximityprompt(pp)
										task.wait(0.33)
									end
									local door = objective:FindFirstChild("Door")
									if door then
										--_G.TeleportPlayerTo((door:GetPivot() * CFrame.new(-10, 0, 0)).Position)
										_G.TeleportPlayerTo(Vector3.new(-6572.5, 125, 305))
									end
									local drill = objective:FindFirstChild("Drill")
									if drill and drill:FindFirstChild("Main") and drill.Main:FindFirstChild("Attachment") then
										drill.Main.Attachment.Parent = plr.Character.Humanoid.RootPart
									end
									break -- end of mission
								end
							end
							
						end
					end
					
					autoMission:SetText("Ending...")
					local rewardUI = plr:WaitForChild("PlayerGui"):WaitForChild("MissionSummary")
					repeat task.wait(1) until not moduleOn or not missionRunning or rewardUI.Enabled or mission.Parent == nil
					task.wait(0.33)
					firesignal(rewardUI.Background.CollectRewards.MouseButton1Click)
					rewardUI.Enabled = false
					repeat task.wait(1) until not moduleOn or not missionRunning or mission.Parent == nil
					task.wait(5)
				end
			end
			autoMission:SetText("Auto-mission")
			missionRunning = false
		end
	end)
	
	category:AddButton("Autobuild Outpost", function()
		for _, outpost in pairs(game.Workspace.TycoonModels:GetChildren()) do
			if outpost:GetAttribute("UserId") == plr.UserId and outpost:FindFirstChild("ClientButtons") then
				local tycoonFunc = outpost:FindFirstChild("TycoonFunc")
				if tycoonFunc then
					for _, button in pairs(outpost.ClientButtons:GetChildren()) do
						tycoonFunc:InvokeServer("Buy", button.Name)
					end
				end
			end
		end
	end)
	
	category:AddButton("Tp back to base", function()
		if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local tycoon = GetPlayerTycoon()
			if tycoon then
				local collect = tycoon:FindFirstChild("CollectButton", true)
				local target = collect and collect.Position or _G.lastKnownBaseTp
				if target then
					_G.TeleportPlayerTo(target + Vector3.new(0, 3, 0))
					_G.lastKnownBaseTp = target
				end
			end
		end
	end)
	
	local hijacked = {}
	local vehicleConn
	local function Hijack(tool)
		if hijacked[tool] then return end
		if tool:IsA("Tool") and tool:FindFirstChild("Client") and tool:FindFirstChild("Ammo") then
			table.insert(connections, tool.Equipped:Connect(function()
				task.wait()
				local f, err = pcall(function()
					ContextActionService:UnbindAction("Shoot")
				end)
				if not f then warn(err) end
				currentTool = tool
				print("Tool hijacked: " .. tostring(tool.Name))
			end))
			table.insert(connections, tool.Unequipped:Connect(function()
				currentTool = nil
			end))
			hijacked[tool] = true
		elseif tool:IsA("LocalScript") and tool.Name == "Shooter" then
			local vehicle = tool:WaitForChild("Car").Value
			local fireEvent = vehicle:WaitForChild("Fire")
			local seat = tool:WaitForChild("Seat").Value
			local gun = tool:WaitForChild("Gun").Value
			local ammo = gun.Ammo
			local shootParts = {}
			if gun then
				for k,v in pairs(gun:GetChildren()) do
					if v.Name == "ShootPart" then
						table.insert(shootParts, v)
					end
				end
			end
			wait()
			local function GetVehicleMousePoint()
				local v51, v52 = game.Workspace:FindPartOnRayWithIgnoreList(Ray.new(game.Workspace.CurrentCamera.CFrame.p, (mouse.Hit.Position - workspace.CurrentCamera.CFrame.Position).Unit * 50000), { vehicle, plr.Character })
				return v52
			end
			local function GetVehicleTargetPoint()
				local targetPoint = game.Workspace.CurrentCamera.CFrame.Position + (game.Workspace.CurrentCamera.CFrame.lookVector + Vector3.new(0, 0.1, 0)).Unit * 500;
				if not UserInputService.KeyboardEnabled then
					if UserInputService.GamepadEnabled then
						targetPoint = GetVehicleMousePoint()
					end
				else
					targetPoint = GetVehicleMousePoint()
				end;
				return targetPoint
			end
			
			local lastPrimaryFire = tick()
			local function BetterPrimaryAim()
				if tick() - lastPrimaryFire < 0 then
					return
				end
				if ammo.Value <= 0 then
					fireEvent:FireServer(3)
					return
				end
				local shootPart = shootParts[ammo.Value % #shootParts + 1] or shootParts[1]
				if not shootPart then
					fireEvent:FireServer(2, GetVehicleTargetPoint())
					return
				end
				local target, raycastHit = FindTargetAtMouse(1000, vehicle)
				if target then
					fireEvent:FireServer(2, raycastHit.Position, shootPart.Position, raycastHit.Instance, raycastHit.Position, raycastHit.Normal)
					lastPrimaryFire = tick()
				elseif not precisionAim.Checked then
					local outPos = plr.Character.Humanoid.RootPart.Position
					raycastHit = generateRaycast(outPos, (mouse.Hit.Position - outPos).Unit * 1000, vehicle)
					if raycastHit then
						fireEvent:FireServer(2, raycastHit.Position, shootPart.Position, raycastHit.Instance, raycastHit.Position, raycastHit.Normal)
						lastPrimaryFire = tick()
					else
						fireEvent:FireServer(2, mouse.Hit.Position, shootPart.Position, mouse.Target, mouse.Hit.Position, Vector3.Zero)
						lastPrimaryFire = tick()
					end
				end
			end
			--repeat wait() until getsenv(tool).heartbeat
			--getsenv(tool).heartbeat:Disconnect()
			ContextActionService:UnbindAction("Shoot")
			local secondaryOn = seat:FindFirstChild("Secondary") ~= nil
			if secondaryOn then
				ContextActionService:UnbindAction("Secondary")
				--ContextActionService:BindAction("Secondary", BetterSecondaryAim, false, Enum.KeyCode.F, Enum.KeyCode.ButtonR1);
			end
			local Lockon = plr.PlayerGui:FindFirstChild("Lockon")
			local function BetterSecondaryAim()
				Lockon = plr.PlayerGui:FindFirstChild("Lockon")
				local target, raycastHit = FindTargetAtMouse(1000, vehicle)
				if target then
					if Lockon then
						Lockon.Enabled = true
						Lockon.Adornee = target
					end
					fireEvent:FireServer("Secondary", target.Position, target)
				elseif Lockon then
					Lockon.Enabled = false
					Lockon.Adornee = nil
				end
			end
			if vehicleConn then
				vehicleConn:Disconnect()
				vehicleConn = nil
			end
			vehicleConn = RunService.RenderStepped:Connect(function()
				if not tool or tool.Parent == nil then
					vehicleConn:Disconnect()
					return
				end
				if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
					BetterPrimaryAim()
				end
				if secondaryOn and UserInputService:IsKeyDown(Enum.KeyCode.F) then
					BetterSecondaryAim()
				elseif Lockon then
					Lockon.Enabled = false
					Lockon.Adornee = nil
				end
			end)
			table.insert(connections, vehicleConn)
			print("Vehicle hijacked: " .. tostring(vehicle.Name))
			hijacked[tool] = true
		end
	end
	
	for k,v in pairs(plr.Backpack:GetChildren()) do
		Hijack(v)
	end
	
	local oldConn = nil
	table.insert(connections, plr.CharacterAdded:Connect(function()
		if oldConn then
			oldConn:Disconnect()
		end
		oldConn = plr:WaitForChild("Backpack").ChildAdded:Connect(Hijack)
		table.insert(connections, oldConn)
	end))
	oldConn = plr:WaitForChild("Backpack").ChildAdded:Connect(Hijack)
	_G.Notify("Aimbot enabled.", "Aimbot")
end

function module.Shutdown()
	moduleOn = false
	for k,v in pairs(connections2) do
		if v then
			v:Disconnect()
		end
	end
end

return module