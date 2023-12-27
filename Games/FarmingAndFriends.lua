local module = {}

local plr = game.Players.LocalPlayer

function module.PreInit()
	
end

local autofarm = {
	raycastPart = nil,
	raycastPartOrigin = CFrame.new()
}
function module.Init(category, connections)
	local sharedModules = game.ReplicatedStorage:WaitForChild("SharedModules")
	local tagModule = require(sharedModules:WaitForChild("TagModule"))
	local itemModule = require(sharedModules:WaitForChild("ItemModule"))
	local vehicleLogic = require(sharedModules:WaitForChild("VehicleLogic"))
	local constants = require(sharedModules:WaitForChild("Constants"))
	local misc = require(sharedModules:WaitForChild("Misc"))
	local permissionsModule = require(sharedModules:WaitForChild("PermissionsModule"))
	
	local PresetGuis = game.ReplicatedStorage:WaitForChild("PresetGuis")
	local fieldProgressGuis = plr:WaitForChild("PlayerGui"):WaitForChild("FieldProgressGuis")
	
	local SellValues = game.ReplicatedStorage:WaitForChild("SellValues")
	
	local Vehicles = game.Workspace:WaitForChild("Vehicles")
	local Equipment = game.workspace:WaitForChild("Equipment")
	local Fields = game.Workspace:WaitForChild("Fields")
	local Buildings = game.Workspace:WaitForChild("Buildings")
	local DraggableObjects = game.Workspace:WaitForChild("DraggableObjects")
	
	local function IsAllowed(obj)
		if not obj then return false end
		local ownerVal = obj:FindFirstChild("Owner", true)
		if ownerVal and ownerVal.Value then
			local owner = ownerVal.Value
			if ownerVal:IsA("IntValue") or ownerVal:IsA("NumberValue") then
				owner = game.Players:GetPlayerByUserId(ownerVal.Value)
			end
			if owner and (owner == plr or permissionsModule.IsWhitelistedBy(owner, plr)) then
				return true
			end
		end
		return false
	end
	
	local function GetVehicles()
		local vehicles = {}
		for _,vehicle in pairs(Vehicles:GetChildren()) do
			if IsAllowed(vehicle) then
				table.insert(vehicles, vehicle)
			end
		end
		return vehicles
	end
	
	local function GetEquipment()
		local eqs = {}
		for _,equipment in pairs(Equipment:GetChildren()) do
			if IsAllowed(equipment) then
				table.insert(eqs, equipment)
			end
		end
		return eqs
	end
	
	local function GetVehiclesAndEquipment()
		local allMachines = {}
		for k,v in pairs(GetVehicles()) do
			table.insert(allMachines, v)
		end
		for k,v in pairs(GetEquipment()) do
			table.insert(allMachines, v)
		end
		return allMachines
	end
	
	local function GetFields()
		local fields = {}
		for _,field in pairs(Fields:GetChildren()) do
			if IsAllowed(field) then
				table.insert(fields, field)
			end
		end
		return fields
	end
	
	local function GetBuildings()
		local buildings = {}
		for _,building in pairs(Buildings:GetChildren()) do
			if IsAllowed(building) then
				table.insert(buildings, building)
			end
		end
		return buildings
	end
	
	local function GetDraggableObjects()
		local draggables = {}
		for _,draggable in pairs(DraggableObjects:GetChildren()) do
			if IsAllowed(draggable) then
				table.insert(draggables, draggable)
			end
		end
		return draggables
	end
	
	local function GetCurrentVehicle()
		if plr and plr.Character then
			local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
			if human and human.SeatPart then
				local vehicle = human.SeatPart.Parent
				local vehicleConfig = vehicle:FindFirstChild("Configurations")
				if vehicle and vehicle:IsDescendantOf(Vehicles) and vehicleConfig then
					return vehicle, vehicleConfig
				end
			end
		end
	end
	
	local function GetCurrentEquipment()
		local vehicle, vehicleConfig = GetCurrentVehicle()
		if vehicle then
			local equipment = vehicleLogic.GetEquipmentFromVehicle(vehicle)
			if equipment and equipment:FindFirstChild("Configurations") and equipment.Configurations:FindFirstChild("Type") then
				return equipment, vehicle, equipment.Configurations.Type.Value
			end
			if vehicleConfig and vehicleConfig:FindFirstChild("Type") then
				return nil, vehicle, vehicleConfig.Type.Value
			end
		end
	end
	
	do -- anti-fling detector
		task.spawn(function()
			plr:WaitForChild("PlayerScripts")
			task.wait(5)
			game:GetService("RunService"):UnbindFromRenderStep("NoFling")
			if plr.PlayerScripts:FindFirstChild("CmdrClient") then
				plr.PlayerScripts.CmdrClient.Disabled = true
			end
			if plr.PlayerScripts:FindFirstChild("NoFling") then
				plr.PlayerScripts.NoFling.Disabled = true
			end
		end)
	end
	
	do -- anti-char detector
		_G.DisableSignal(plr.CharacterAdded)
		if plr.Character then
			_G.DisableSignal(plr.Character.ChildAdded)
		end
	end
	
	do -- anti-monitor
		for k, vehicle in pairs(Vehicles:GetChildren()) do
			local stats = vehicle:WaitForChild("Stats")
			for k,v in pairs(stats:GetChildren()) do
				_G.DisableSignal(v.Changed)
				_G.DisableSignal(v:GetPropertyChangedSignal("Name"))
			end
		end
		table.insert(connections, Vehicles.ChildAdded:Connect(function(vehicle)
			local stats = vehicle:WaitForChild("Stats")
			for k,v in pairs(stats:GetChildren()) do
				_G.DisableSignal(v.Changed)
				_G.DisableSignal(v:GetPropertyChangedSignal("Name"))
			end
		end))
		_G.DisableSignal(Vehicles.ChildAdded)
	end
	
	do -- Vehicles
		local customVehicleStats = {
			["MediumLiquidTruck"] = {
				TurnRadius = 45,
				MaxSpeed = 60
			},
			["ChallengerMT9"] = {
				TurnRadius = 35,
				Torque = 99999999
			}
		}
		local function UpdateVehicleSettings()
			for k,v in pairs(Vehicles:GetChildren()) do
				if v:FindFirstChild("Configurations") and v:FindFirstChild("Stats") then
					if customVehicleStats[v.Name] then
						for stat,value in pairs(customVehicleStats[v.Name]) do
							_G.IndexEmulator:SetKeyValue(v.Stats[stat], "Value", value)
						end
					elseif v.Configurations:FindFirstChild("Type") and v.Configurations.Type.Value == "Truck" then
						_G.IndexEmulator:SetKeyValue(v.Stats.MaxSpeed, "Value", v.Stats.MaxSpeed.Value*1.5)
					end
				end
			end
		end
		task.delay(5, UpdateVehicleSettings)
		table.insert(connections, Vehicles.ChildAdded:Connect(UpdateVehicleSettings))
	end
	
	local UpdateStatistics
	do -- statistics
		local category = _G.SenHub:AddCategory("Statistics")
		
		local namesTransform = {
			["EggBox"] = "Eggs"
		}
		
		if not _G.LastRefreshTime then
			_G.LastRefreshTime = tick()
		end
		--local lastTime = 0
		local timerLabel = category:AddLabel("Time To Update")
		table.insert(connections, game.ReplicatedStorage:WaitForChild("Remote"):WaitForChild("UpdateSellValues").OnClientEvent:Connect(function()
			--lastTime = tick() - _G.LastRefreshTime
			_G.LastRefreshTime = tick()
			--print(string.format("Last time: %ds", lastTime))
		end))
		
		task.spawn(function()
			while module.On and task.wait(1) do
				local secondsLeft = math.floor(300 - (tick() - _G.LastRefreshTime))
				local minutesLeft = math.floor(secondsLeft/60)
				secondsLeft -= minutesLeft*60
				timerLabel:SetText(string.format("Refresh in %02dm:%02ds", minutesLeft, secondsLeft))
			end
		end)
		
		local sellablesLabels = {}
		local categories = {"Crop", "Item", "Milk", "Log"}
		for _,categoryName in pairs(categories) do
			local sellableCategory = SellValues:FindFirstChild(categoryName)
			if sellableCategory then
				sellablesLabels[sellableCategory.Name] = {}
				category:AddLabel(string.format("<====== %s ======>", sellableCategory.Name))
				
				for _, sellable in pairs(sellableCategory:GetChildren()) do
					if sellable:IsA("IntValue") then
						sellablesLabels[sellableCategory.Name][sellable.Name] = category:AddLabel("NaN")
					end
				end
			end
		end
		
		local lowEffCol = Color3.fromRGB(157, 12, 12)
		local neutralEffCol = Color3.fromRGB(122, 122, 122)
		local highEffCol = Color3.fromRGB(85, 170, 0)
		UpdateStatistics = function()
			local sellables = {}
			
			local currentEq = GetCurrentEquipment()
			if currentEq and currentEq:FindFirstChild("Configurations") and currentEq.Configurations:FindFirstChild("Carrying") and currentEq.Configurations:FindFirstChild("Capacity") and currentEq.Configurations.Capacity.Value > 0 then
				local config = currentEq:FindFirstChild("Configurations")
				local sellable = config.Carrying.Value
				if sellable ~= "" then
					local sellableName = sellable
					if not sellables[sellableName] then
						sellables[sellableName] = 0
					end
					sellables[sellableName] += config.Capacity.Value
				end
			else
				for _,draggable in pairs(GetDraggableObjects()) do
					local config = draggable:FindFirstChild("Configurations")
					if config then
						if draggable.Name == "Pallet" then
							if config:FindFirstChild("ItemType") and config:FindFirstChild("Capacity") then
								local sellableName = config.ItemType.Name
								if not sellables[sellableName] then
									sellables[sellableName] = 0
								end
								sellables[sellableName] += config.Capacity.Value
							end
						else
							local sellableName = draggable.Name
							if draggable.Name == "EggBox" then
								sellableName = "Eggs"
							elseif draggable.Name == "MilkContainer" then
								sellableName = config.MilkType.Value
							end
							if not sellables[sellableName] then
								sellables[sellableName] = 0
							end
							sellables[sellableName] += 1
						end
					end
				end
				
				for _,field in pairs(GetFields()) do
					for _,fieldCell in pairs(field:GetChildren()) do
						local config = fieldCell:FindFirstChild("Configurations")
						if config and config:FindFirstChild("SeedType") then
							local seedType = config.SeedType.Value
							if seedType ~= "" then
								if not sellables[seedType] then
									sellables[seedType] = 0
								end
								sellables[seedType] += 1
							end
						end
					end
				end
				
				for _,building in pairs(GetBuildings()) do
					local config = building:FindFirstChild("Configurations")
					if config and config:FindFirstChild("Capacity") then
						local sellableVal = config:FindFirstChild("CropType") or config:FindFirstChild("Carrying")
						if sellableVal and sellableVal.Value ~= "" then
							if not sellables[sellableVal.Value] then
								sellables[sellableVal.Value] = 0
							end
							sellables[sellableVal.Value] += config.Capacity.Value
						end
					end
				end
				
				for _,machine in pairs(GetVehiclesAndEquipment()) do
					local config = machine:FindFirstChild("Configurations")
					if config and config:FindFirstChild("Carrying") and config:FindFirstChild("Capacity") then
						local sellable = config.Carrying.Value
						if sellable ~= "" then
							if not sellables[sellable] then
								sellables[sellable] = 0
							end
							sellables[sellable] += config.Capacity.Value
						end
					end
				end
			end
			
			for sellableCategory, labels in pairs(sellablesLabels) do
				for sellable, label in pairs(labels) do
					if sellables[sellable] and sellable ~= "Wheat" and sellable ~= "Cocoa" then
						label:SetVisible(true)
						--local sellValue = SellValues:FindFirstChild(sellableCategory):FindFirstChild(sellable).Value
						local sellValue = misc.GetSellValue(sellable, sellableCategory)
						local baseSellValue = constants.SELL_VALUES[sellableCategory][sellable]
						
						local baseProfit = math.floor(sellables[sellable]*sellValue)
						local totalProfit = baseProfit
						
						local bonus = 0
						if plr:GetAttribute("GroupStatus") == 1 then
							bonus = math.floor(baseProfit * constants.GROUP_BONUS)
						end
						
						if game.ReplicatedStorage:WaitForChild("Bindables"):WaitForChild("HasPremium"):Invoke() then
							bonus += math.floor(baseProfit * constants.CLUB_BONUS)
						end
						totalProfit += bonus
						
						local itemId = -1000
						for id, item in pairs(itemModule.getItems()) do
							if tostring(item[2]) == sellable then
								itemId = id
								break
							end
						end
						
						local netProfit = totalProfit
						if itemId >= 0 then
							if sellableCategory == "Crop" then
								netProfit -= itemModule.getPrice(itemId) * math.floor(sellables[sellable]/50)
							else
								netProfit -= itemModule.getPrice(itemId) * math.floor(sellables[sellable]/50)
							end
						end
						
						local minSell, maxSell = constants.GetSellValueLimits(sellable, sellableCategory)
						local efficiency = (sellValue - minSell) / (maxSell - minSell)
						
						label:SetText(
							string.format(
								--"%s\t%s (%s)\n%s/%s (%.1f%%)",
								"%s\t%s\t%s (%.1f%%)",
								sellable,
								
								--misc.AddCommasToNumber(math.floor(totalProfit)),
								--math.ceil((totalProfit / baseProfit) * 100),
								
								misc.AddCommasToNumber(math.floor(netProfit)),
								
								misc.AddCommasToNumber(math.floor(sellValue)),
								--misc.AddCommasToNumber(math.floor(maxSell)),
								efficiency * 100
							)
						)
						if efficiency >= 0.9 then
							label._GuiObject.TextColor3 = Color3.new(1, 0, 1)
						else
							label._GuiObject.TextColor3 = lowEffCol:Lerp(highEffCol, efficiency)
						end
					else
						label:SetText("NaN")
						label:SetVisible(false)
					end
				end
			end
			
		end
		UpdateStatistics()
	end
	
	do -- notifications
		local notifySoundPrices = game.Workspace:FindFirstChild("_SND_NOTIFY_PRICES") or Instance.new("Sound", game.Workspace)
		notifySoundPrices.Name = "_SND_NOTIFY_PRICES"
		notifySoundPrices:Stop()
		notifySoundPrices.SoundId = "rbxassetid://2588575611"
		notifySoundPrices.Volume = 0.5
		notifySoundPrices.PlayOnRemove = false
		
		--local notifyNewPricesOnlyCropsGrown
		local notifyOnNewPrices = category:AddCheckbox("Notify on new sell prices", function(state)
			--notifyNewPricesOnlyCropsGrown:SetVisible(state)
		end)
		--[[notifyNewPricesOnlyCropsGrown = category:AddCheckbox("\t... only if all crops are grown")
		notifyNewPricesOnlyCropsGrown:SetChecked(true)]]
		notifyOnNewPrices:SetChecked(true)
		
		local function onUpdateSellPrices()
			if notifyOnNewPrices.Checked then
				--[[if notifyNewPricesOnlyCropsGrown.Checked then
					local grown = 0
					local validFields = 0
					for _, field in pairs(GetFields()) do
						local config = field:FindFirstChild("Configurations")
						if config and config:FindFirstChild("CropCounter") and config:FindFirstChild("HarvestableCounter") then
							if config.CropCounter.Value > 0 then
								validFields += 1
								if config.HarvestableCounter.Value >= config.CropCounter.Value then
									grown += 1
								end
							end
						end
					end
					if validFields == 0 or grown >= validFields then
						notifySoundPrices:Play()
					end
				else]]
					notifySoundPrices:Play()
				--end
			end
			UpdateStatistics()
		end
		onUpdateSellPrices()
		table.insert(connections, game.ReplicatedStorage:WaitForChild("Remote"):WaitForChild("UpdateSellValues").OnClientEvent:Connect(onUpdateSellPrices))
		
		if iswindowactive and false then
			local notifyWhenCropsGrownWindowActive
			local notifyWhenCropsGrown = category:AddCheckbox("Notify when crops are fully grown", function(state)
				notifyWhenCropsGrownWindowActive:SetVisible(state)
			end)
			notifyWhenCropsGrownWindowActive = category:AddCheckbox("\t... even when window active")
			notifyWhenCropsGrown:SetChecked(true)
			
			local notifySoundCrops = game.Workspace:FindFirstChild("_SND_NOTIFY_CROPS") or Instance.new("Sound", game.Workspace)
			notifySoundCrops.Name = "_SND_NOTIFY_CROPS"
			notifySoundCrops:Stop()
			notifySoundCrops.SoundId = "rbxassetid://1388573684"
			notifySoundCrops.Volume = 0.35
			notifySoundCrops.PlayOnRemove = false
		end
			
		task.spawn(function()
			while task.wait(5) and module.On do
				UpdateStatistics()
				--[[if notifyWhenCropsGrown.Checked and (notifyWhenCropsGrownWindowActive.Checked or not iswindowactive()) then
					local grown = 0
					local validFields = 0
					for _, field in pairs(GetFields()) do
						local config = field:FindFirstChild("Configurations")
						if config and config:FindFirstChild("CropCounter") and config:FindFirstChild("HarvestableCounter") then
							if config.CropCounter.Value > 0 then
								validFields += 1
								if config.HarvestableCounter.Value >= config.CropCounter.Value then
									grown += 1
								end
							end
						end
					end
					if grown > 0 and grown >= validFields then
						notifySoundCrops:Play()
					end
				end]]
			end
		end)
	end
	
	do -- field info extension
		local function patchFPGs()
			task.wait()
			for k,v in pairs(fieldProgressGuis:GetChildren()) do
				v.Size = UDim2.fromOffset(200, 180)
				v.AlwaysOnTop = true
				if v:FindFirstChild("Progress") then
					if v.Progress:FindFirstChild("RainButton") then
						v.Progress.RainButton.Visible = false
					end
					if v.Progress:FindFirstChild("DusterButton") then
						v.Progress.DusterButton.Visible = false
					end
					if v.Progress:FindFirstChild("ProgressBar") then
						v.Progress.ProgressBar.ClipsDescendants = false
						local progressLabel = v.Progress.ProgressBar:FindFirstChild("ProgressLabel") or Instance.new("TextLabel", v.Progress.ProgressBar)
						progressLabel.Name = "ProgressLabel"
						progressLabel.BackgroundTransparency = 1
						progressLabel.Font = "Roboto"
						progressLabel.TextScaled = true
						progressLabel.TextColor3 = Color3.new(1, 1, 1)
						progressLabel.TextStrokeTransparency = 0
						progressLabel.Size = UDim2.new(1, -10, 1, -10)
						progressLabel.Position = UDim2.fromOffset(5, 5)
						
						local endtimeLabel = v.Progress.ProgressBar:FindFirstChild("EndtimeLabel") or progressLabel:Clone()
						endtimeLabel.Name = "EndtimeLabel"
						endtimeLabel.Position = UDim2.new(0, 5, 1, 5)
						endtimeLabel.Parent = v.Progress.ProgressBar
						endtimeLabel.TextXAlignment = Enum.TextXAlignment.Center
					end
				end
			end
		end
		patchFPGs()
		table.insert(connections, fieldProgressGuis.ChildAdded:Connect(patchFPGs))
		
		task.spawn(function()
			while task.wait(1) and module.On do
				for _,field in pairs(GetFields()) do
					local fpg = field:FindFirstChild("FieldProgressGui")
					if fpg and fpg.Value and fpg.Value:FindFirstChild("Progress") and fpg.Value.Progress:FindFirstChild("ProgressBar") and fpg.Value.Progress.ProgressBar:FindFirstChild("ProgressLabel") and
					fpg.Value.Progress.ProgressBar:FindFirstChild("EndtimeLabel") then
						local progressLabel = fpg.Value.Progress.ProgressBar.ProgressLabel
						local endtimeLabel = fpg.Value.Progress.ProgressBar.EndtimeLabel
						local seedType, lowestGrowth, growthMult = nil, 0, 0
						for _,fieldCell in pairs(field:GetChildren()) do
							local cellConfig = fieldCell:FindFirstChild("Configurations")
							if cellConfig and cellConfig:FindFirstChild("Stage") and cellConfig.Stage.Value == "Seeded" and cellConfig:FindFirstChild("SeedType") and cellConfig.SeedType.Value ~= "" and cellConfig:FindFirstChild("PlantGrowth") and cellConfig:FindFirstChild("GrowthMultiplier") then
								if not seedType or cellConfig.PlantGrowth.Value < lowestGrowth then
									seedType = cellConfig.SeedType.Value
									lowestGrowth = cellConfig.PlantGrowth.Value
									growthMult = cellConfig.GrowthMultiplier.Value
								end
							end
						end
						if seedType then
							progressLabel.Visible = true
							endtimeLabel.Visible = true
							fpg.Value.Enabled = true
							
							local growthPercentage = lowestGrowth / (constants.GROWTH_TIMES[seedType]*2)
							if not field:GetAttribute("GrowthPercentage") then
								field:SetAttribute("GrowthPercentage", growthPercentage)
								field:SetAttribute("LastGrowthTime", nil)
							elseif growthPercentage ~= field:GetAttribute("GrowthPercentage") then
								field:SetAttribute("GrowthPercentage", growthPercentage)
								field:SetAttribute("LastGrowthTime", tick())
							end
							
							if field:GetAttribute("LastGrowthTime") then
								local secondsTotal = constants.GROWTH_TIMES[seedType]*60
								local timeEnd = field:GetAttribute("LastGrowthTime") + (secondsTotal * (1-field:GetAttribute("GrowthPercentage")))
								local secondsLeft = timeEnd - tick()
								local minutesLeft = math.floor(secondsLeft/60)
								secondsLeft -= minutesLeft*60
								if tick() < timeEnd then
									progressLabel.Text = string.format(" -%02d:%02d %.2f%% ", minutesLeft, secondsLeft,(1-((timeEnd - tick())/secondsTotal))*100)
								else
									progressLabel.Text = string.format(" +%02d:%02d %.2f%% ", minutesLeft, secondsLeft,(1-((timeEnd - tick())/secondsTotal))*100)
								end
								
								local realSeconds = (timeEnd+3600)%86400
								local realHours = math.floor(realSeconds/3600)
								realSeconds -= realHours*3600
								local realMinutes = math.floor(realSeconds/60)
								realSeconds -= realMinutes*60
								
								endtimeLabel.Text = string.format("%02d:%02d:%02d", realHours, realMinutes, realSeconds)
							else
								progressLabel.Text = "Wait..."
								endtimeLabel.Text = "Wait..."
							end
						else
							progressLabel.Visible = false
							endtimeLabel.Visible = false
						end
					end
				end
			end
		end)
	end
	
	do -- autofarm
		local category = _G.SenHub:AddCategory("Farming")
		
		local autoFarmEnabled = false
		local autoFarmToggle = category:AddCheckbox("Autofarm")
		autoFarmToggle:SetChecked(true)
		
		local function getNextFieldCells(eqType, raycastPart)
			local sorted = {}
			for _,field in pairs(GetFields()) do
				for _,fieldCell in pairs(field:GetChildren()) do
					local cellConfig = fieldCell:FindFirstChild("Configurations")
					if cellConfig and cellConfig:FindFirstChild("Stage") then
						if  (eqType == "Plowing" and cellConfig.Stage.Value == "Empty") or
							(eqType == "Cultivating" and cellConfig.Stage.Value == "Plowed") or
							(eqType == "Seeding" and cellConfig.Stage.Value == "Cultivated") then
							if (fieldCell.Position - raycastPart.Position).Magnitude < 60 then
								table.insert(sorted, fieldCell)
							end
						end
					end
				end
			end
			table.sort(sorted, function(a,b)
				return (a.Position - raycastPart.Position).Magnitude < (b.Position - raycastPart.Position).Magnitude
			end)
			return sorted
		end
		task.spawn(function()
			local equipment, vehicle, eqType, raycastPart, fieldCell, chassis
			while module.On and task.wait(.05) do
				if autoFarmToggle.Checked then
					equipment, vehicle, eqType = GetCurrentEquipment()
					if equipment then
						raycastPart = equipment:FindFirstChild("RaycastPart", true)
						if not raycastPart and equipment:FindFirstChild("RaycastParts") then
							raycastPart = equipment.RaycastParts:GetChildren()[1]
						end
					elseif vehicle and eqType == "Harvester" then
						chassis = vehicle:FindFirstChild("Chassis")
						if chassis then
							autoFarmToggle:SetText("Job: Harvesting")
							
							_G.IndexEmulator:SetKeyValue(
								chassis,
								"Velocity",
								chassis.CFrame.LookVector * 2)
							
							task.wait()
							
							_G.IndexEmulator:DeleteKey(chassis, "Velocity")
						end
						continue
						--raycastPart = vehicle.Body.Blades:FindFirstChild("Axle")
					else
						autoFarmToggle:SetText("Sit in tractor...")
						task.wait(2)
						continue
					end
					if raycastPart and (eqType == "Plowing" or eqType == "Cultivating" or eqType == "Seeding") then
						fieldCells = getNextFieldCells(eqType, raycastPart)
						if #fieldCells <= 0 then
							autoFarmToggle:SetText("No fields for job: " .. eqType .. "!")
							task.wait(1)
							continue
						end
						for i = 1, 10 do
							fieldCell = fieldCells[i]
							if fieldCell then
								chassis = vehicle:FindFirstChild("Chassis")
								if not chassis then
									autoFarmToggle:SetText("Wrong vehicle type!")
									continue
								end
								autoFarmToggle:SetText("Job: " .. eqType)
								_G.IndexEmulator:SetKeyValue(
									chassis,
									"Velocity",
									chassis.CFrame.LookVector * 2)
								_G.IndexEmulator:SetKeyValue(
									raycastPart,
									"Position",
									fieldCell.Position)
								
								task.wait()
								
								_G.IndexEmulator:DeleteKey(chassis, "Velocity")
								_G.IndexEmulator:DeleteKey(raycastPart, "Position")
							else
								break
							end
						end
					else
						autoFarmToggle:SetText("Wrong equipment type!")
					end
				else
					autoFarmToggle:SetText("Autofarm")
				end
			end
		end)
	end
end

function module.Shutdown()
end

return module