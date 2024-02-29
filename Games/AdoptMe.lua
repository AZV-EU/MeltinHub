local module = {
	On = false
}

local plr = game.Players.LocalPlayer
local MAX_WAIT = 60

function module.PreInit()
	
end

function module.Init(category, connections)
	local ReplicatedStorage = _G.SafeGetService("ReplicatedStorage")
	local PlayerGui = plr:WaitForChild("PlayerGui")
	
	local ailments = plr.PlayerGui:WaitForChild("AilmentsMonitorApp"):WaitForChild("Ailments")
	local clientModules = ReplicatedStorage:WaitForChild("ClientModules")
	
	local clientData = require(clientModules:WaitForChild("Core"):WaitForChild("ClientData"))
	
	local PetsModel = game.Workspace:WaitForChild("Pets")
	local HouseInteriors = game.Workspace:WaitForChild("HouseInteriors")
	local HouseExteriors = game.Workspace:WaitForChild("HouseExteriors")
	
	--plr:WaitForChild("PlayerScripts"):WaitForChild("BootstrapClient").Disabled = true
	
	local Pet = {
		Current = nil,
		Model = nil
	}
	
	-- API deobfuscator
	local debugApiTable = {}
	do
		local env = getfenv(module.Init)
		for k,v in pairs(getupvalue(require(ReplicatedStorage.Fsys).load("RouterClient").init, 4)) do
			local cls, fnName = unpack(string.split(k,"/"))
			if not env[cls] then
				env[cls] = {}
			end
			env[cls][fnName] = v
			if _G.MeltinENV == 1 then
				if not debugApiTable[cls] then
					debugApiTable[cls] = {}
				end
				table.insert(debugApiTable[cls], fnName)
			end
			v.Name = k
		end
	end
	
	-- daily autoaccept
	DailyLoginAPI.ClaimDailyReward:InvokeServer()
	
	local getconstants = getconstants or debug.getconstants
	local setconstant = setconstant or debug.setconstant
	
	local LocationFunc
	do
		local sc
		for k,v in pairs(getgc()) do
			if type(v) == "function" then
				sc = getfenv(v).script
				if not LocationFunc and sc.Name == "InteriorsM" and
					table.find(getconstants(v), "LocationAPI/SetLocation") then
					LocationFunc = v
				elseif sc.Name == "SendClientErrorReportsToServer" then
					for idx,constant in pairs(getconstants(v)) do
						if constant == "ErrorReportAPI/SendUniqueError" then
							setconstant(v,idx,"")
						end
					end
				end
			end
		end
	end
	
	if not LocationFunc then
		warn("Could not find location func")
		return
	end
	
	local function GetClientData()
		return clientData.get_data()[plr.Name]
	end

	getgenv().SetLocation = function(locationName, targetModelName, metadata)
		local ti = get_thread_identity()
		set_thread_identity(2)
		LocationFunc(locationName, targetModelName, metadata or {})
		set_thread_identity(ti)
	end
	
	local function GetInteriorBlueprint()
		return HouseInteriors.blueprint:FindFirstChildWhichIsA("Model") or game.Workspace.Interiors:FindFirstChildWhichIsA("Model")
	end
	
	local function IsAtPlace(placeName, use_find)
		local bp = GetInteriorBlueprint()
		return bp and (use_find and bp.Name:find(placeName) or bp.Name == placeName)
	end
	
	local function TeleportToMainDoor()
		local bp = GetInteriorBlueprint()
		if bp then
			local mainDoor = bp:FindFirstChild("MainDoor", true)
			if mainDoor then
				local touchToEnter = mainDoor:FindFirstChild("TouchToEnter", true)
				if touchToEnter then
					_G.TeleportPlayerTo(touchToEnter.CFrame * CFrame.new(0, 0, -5))
				end
			end
		end
	end
	
	local isTeleporting = false
	local function TeleportHome()
		if isTeleporting then
			return IsAtPlace(plr.Name)
		end
		isTeleporting = true
		if not IsAtPlace(plr.Name) then
			_G.SetCharAnchored(true)
			while task.wait(1) and not IsAtPlace(plr.Name) and module.On do
				SetLocation("housing", "MainDoor", {
					["house_owner"] = plr
				})
			end
			_G.SetCharAnchored(false)
			if IsAtPlace(plr.Name) then
				TeleportToMainDoor()
			end
			task.wait(3)
		end
		isTeleporting = false
		return IsAtPlace(plr.Name)
	end
	
	local function TeleportToPlace(placeName, randomOffset)
		if isTeleporting then
			return IsAtPlace(placeName)
		end
		isTeleporting = true
		if not IsAtPlace(placeName) then
			_G.SetCharAnchored(true)
			while task.wait(1) and not IsAtPlace(placeName) and module.On do
				SetLocation(placeName, "MainDoor")
			end
			_G.SetCharAnchored(false)
			if IsAtPlace(placeName) then
				local tpStatic = game.Workspace.StaticMap.TeleportLocations:FindFirstChild(placeName)
				if tpStatic then
					local offsetX, offsetZ = math.random(-10,10), math.random(-10,10)
					_G.TeleportPlayerTo(tpStatic.Position + Vector3.new(randomOffset and offsetX or 0, 3, randomOffset and offsetZ or 0))
				else
					local mainDoor = GetInteriorBlueprint():FindFirstChild("MainDoor", true)
					if mainDoor then
						local touchToEnter = mainDoor:FindFirstChild("TouchToEnter", true)
						if touchToEnter then
							local offsetX = math.random(-5,5)
							_G.TeleportPlayerTo(touchToEnter.CFrame * CFrame.new(randomOffset and offsetX or 0, 0, -5))
						end
					end
				end
			end
			task.wait(1)
		end
		isTeleporting = false
		return IsAtPlace(placeName)
	end
	
	local function TeleportToMainMap()
		if isTeleporting then
			return IsAtPlace("MainMap", true)
		end
		isTeleporting = true
		if not IsAtPlace("MainMap", true) then
			_G.SetCharAnchored(true)
			while task.wait(1) and not IsAtPlace("MainMap", true) and module.On do
				SetLocation("MainMap", "Neighborhood/MainDoor")
			end
			_G.SetCharAnchored(false)
			if IsAtPlace("MainMap", true) then
				_G.TeleportPlayerTo(game.Workspace.StaticMap.TeleportLocations.Town.Position)
			end
			task.wait(1)
		end
		isTeleporting = false
		return IsAtPlace("MainMap", true)
	end
	
	local function GetPets()
		local pets = GetClientData().inventory.pets or {}
		local myPets = {}
		for _,pet in pairs(pets) do
			if pet.id ~= "practice_dog" and pet.id:sub(-4) ~= "_egg" then
				myPets[pet.unique] = pet
			end
		end
		return myPets
	end
	
	local function GetEggs()
		local pets = GetClientData().inventory.pets or {}
		local myEggs = {}
		for _,pet in pairs(pets) do
			if pet.id:sub(-4) == "_egg" then
				myEggs[pet.unique] = pet
			end
		end
		return myEggs
	end
	
	local function GetEquippedPet()
		return GetClientData().equip_manager.pets
	end
	
	local function GetFurnitureByName(name)
		local furniture = {}
		for _,fContainer in pairs(HouseInteriors.furniture:GetChildren()) do
			local fModel = fContainer:FindFirstChildWhichIsA("Model")
			if fModel and fModel.Name == name then
				table.insert(furniture, fModel:GetAttribute("furniture_unique"))
			end
		end
		return furniture
	end
	
	local function GetFurnitureByUseId(use_id)
		local furniture = {}
		for _,fContainer in pairs(HouseInteriors.furniture:GetChildren()) do
			local fModel = fContainer:FindFirstChildWhichIsA("Model")
			if fModel then
				local useBlocks = fModel:FindFirstChild("UseBlocks")
				if useBlocks then
					for _,useBlock in pairs(useBlocks:GetChildren()) do
						local config = useBlock:FindFirstChild("Configuration")
						if config and config:FindFirstChild("use_id") and config.use_id.Value == use_id then
							table.insert(furniture, fModel:GetAttribute("furniture_unique"))
						end
					end
				end
			end
		end
		return furniture
	end
	
	local function GetPlayerTeam()
		return GetClientData().team
	end
	
	local function UseBait(bait_unique)
		local houseInterior = clientData.get("house_interior")
		if houseInterior and houseInterior.furniture then
			for furniture_unique,furniture in pairs(houseInterior.furniture) do
				if furniture.id == "lures_2023_normal_lure" then
					if furniture.lure then
						if furniture.lure.finished then
							HousingAPI.ActivateFurniture:InvokeServer(plr, furniture_unique, "UseBlock", false, plr.Character)
							task.wait(1)
							HousingAPI.ActivateFurniture:InvokeServer(plr, furniture_unique, "UseBlock", {bait_unique = bait_unique}, plr.Character)
							return tick()
						else
							return furniture.lure.lure_start_timestamp
						end
					elseif not furniture.lure then
						HousingAPI.ActivateFurniture:InvokeServer(plr, furniture_unique, "UseBlock", {bait_unique = bait_unique}, plr.Character)
						return tick()
					end
					return
				end
			end
		end
	end
	
	local function ReequipPet(pet)
		local eqPet = GetEquippedPet()
		if eqPet then
			if eqPet.unique == pet.unique and Pet.Model and Pet.Model.Parent then
				return
			end
			ToolAPI.Unequip:InvokeServer(eqPet.unique)
		end
		_, Pet.Model = ToolAPI.Equip:InvokeServer(pet.unique)
		Pet.Current = pet
	end
	
	local function AutoSelectPet()
		local oldestPet, oldestAge = nil, 0
		for _,pet in pairs(GetPets()) do
			if pet.properties.age < 6 then
				if not oldestPet or pet.properties.age > oldestAge then
					oldestPet = pet
					oldestAge = pet.properties.age
				end
			end
		end
		return oldestPet
	end
	
	local function GetPetAilments()
		local ailments = {}
		if GetClientData().pet_char_wrapper ~= nil then
			local monitor = GetClientData().pet_char_wrapper.ailments_monitor
			if monitor then
				for categoryName, data in pairs(monitor) do
					if categoryName == "ailments" then
						for _,ailment in pairs(data) do
							table.insert(ailments, ailment)
						end
					elseif type(data) == "table" then
						if GetPlayerTeam() == "Babies" then
							for _,ailment in pairs(data.babies or {}) do
								table.insert(ailments, ailment)
							end
						else
							for _,ailment in pairs(data.parents or {}) do
								table.insert(ailments, ailment)
							end
						end
					end
				end
			end
		end
		return ailments
	end
	
	local function GetPlayerAilments()
		local ailments = {}
		if GetClientData().char_wrapper ~= nil then
			local monitor = GetClientData().char_wrapper.ailments_monitor
			if monitor then
				for categoryName, data in pairs(monitor) do
					if categoryName == "ailments" then
						for _,ailment in pairs(data) do
							table.insert(ailments, ailment)
						end
					elseif type(data) == "table" then
						if GetPlayerTeam() == "Babies" then
							for _,ailment in pairs(data.babies or {}) do
								table.insert(ailments, ailment)
							end
						else
							for _,ailment in pairs(data.parents or {}) do
								table.insert(ailments, ailment)
							end
						end
					end
				end
			end
		end
		
		return ailments
	end
	
	local function GetLowestUsesFood(foodId)
		local lowestFood, lowestUses = nil, 0
		for _,food in pairs(GetClientData().inventory.food) do
			if food.id == foodId then
				local uses_left = food.properties.uses_left or 10
				if not lowestFood or uses_left < lowestUses then
					lowestFood = food.unique
					lowestUses = uses_left
				end
			end
		end
		return lowestFood
	end
	
	local function GetFood(foodId)
		local foods = {}
		for _,food in pairs(GetClientData().inventory.food) do
			if food.id == foodId then
				table.insert(foods, food.unique)
			end
		end
		return foods
	end
	
	local function GetFoodCount(foodId)
		local count = 0
		for _,food in pairs(GetClientData().inventory.food) do
			if food.id == foodId then
				count += 1
			end
		end
		return count
	end
	
	local buyCooldown = 10 * 60
	if not _G.buyLimitReached then _G.buyLimitReached = 0 end
	local function PrepareFood(isDrink)
		if isDrink and not GetLowestUsesFood("tea") then
			if not ShopAPI.BuyItem:InvokeServer("food", "tea", {}) then
				_G.buyLimitReached = tick()
				return
			end
			task.wait(1)
		elseif not isDrink and not GetLowestUsesFood("pizza") then
			if not ShopAPI.BuyItem:InvokeServer("food", "pizza", {}) then
				_G.buyLimitReached = tick()
				return
			end
			task.wait(1)
			ToolAPI.BakeItem:InvokeServer()
			task.wait(3)
		end
		return GetLowestUsesFood(isDrink and "tea" or "pizza")
	end
	
	local function GetAilmentFromUnique(ailment_unique, isPlayer)
		if isPlayer then
			for _,ailment in pairs(GetPlayerAilments()) do
				if ailment.unique == ailment_unique then
					return ailment
				end
			end
		else
			for _,ailment in pairs(GetPetAilments()) do
				if ailment.unique == ailment_unique then
					return ailment
				end
			end
		end
	end
	
	local autoFarm
	
	local function IsAilmentDone(ailment_unique, isPlayer)
		return GetAilmentFromUnique(ailment_unique, isPlayer) == nil
	end
	
	local eventLock
	local function WaitUntilAilmentDone(ailment_unique, isPlayer)
		local waitStart = tick()
		repeat
			task.wait(1)
		until IsAilmentDone(ailment_unique, isPlayer) or eventLock() or tick() - waitStart > MAX_WAIT or not autoFarm.Checked or not module.On
	end
	
	local AilmentFuncTable = {
		["sleepy"] = {RequiresTeleport = false, Function = function(ailment_unique, isPlayer)
			if not eventLock() then
				if not TeleportHome() then return end
			end
			local beds = GetFurnitureByUseId("generic_crib")
			if #beds > 0 then
				task.spawn(function()
					HousingAPI.ActivateFurniture:InvokeServer(
						plr,
						beds[1],
						"UseBlock",
						{cframe = plr.Character:GetPivot()},
						isPlayer and plr.Character or Pet.Model
					)
				end)
				task.wait(1)
				WaitUntilAilmentDone(ailment_unique, isPlayer)
				if isPlayer and plr and plr.Character and plr.Character:FindFirstChild("Humanoid") then
					plr.Character.Humanoid.Jump = true
				end
			end
		end},
		["dirty"] = {RequiresTeleport = false, Function = function(ailment_unique, isPlayer)
			if not eventLock() then
				if not TeleportHome() then return end
			end
			local showers = GetFurnitureByUseId("generic_shower")
			if #showers > 0 then
				task.spawn(function()
					HousingAPI.ActivateFurniture:InvokeServer(
						plr,
						showers[1],
						"UseBlock",
						{cframe = plr.Character:GetPivot()},
						isPlayer and plr.Character or Pet.Model
					)
				end)
				task.wait(1)
				WaitUntilAilmentDone(ailment_unique, isPlayer)
				if isPlayer and plr and plr.Character and plr.Character:FindFirstChild("Humanoid") then
					plr.Character.Humanoid.Jump = true
				end
			end
		end},
		["hungry"] = {RequiresTeleport = false, Function = function(ailment_unique, isPlayer)
			if tick() - _G.buyLimitReached < buyCooldown then return end
			local food_unique = PrepareFood(false)
			if not food_unique then return end
			if isPlayer then
				repeat
					food_unique = PrepareFood(false)
					if not food_unique then
						return
					end
					ToolAPI.Equip:InvokeServer(food_unique)
					ToolAPI.ServerUseTool:FireServer(food_unique, "START")
					ToolAPI.ServerUseTool:FireServer(food_unique, "END")
					task.wait(1)
				until IsAilmentDone(ailment_unique, isPlayer)
				if food_unique then
					ToolAPI.Unequip:InvokeServer(food_unique)
				end
			else
				ToolAPI.Equip:InvokeServer(food_unique)
				task.wait(.33)
				PetObjectAPI.CreatePetObject:InvokeServer("__Enum_PetObjectCreatorType_2", {unique_id = food_unique})
				task.wait(.33)
				PetAPI.ConsumeFoodItem:FireServer(food_unique)
				task.wait(8)
				WaitUntilAilmentDone(ailment_unique, isPlayer)
			end
		end},
		["thirsty"] = {RequiresTeleport = false, Function = function(ailment_unique, isPlayer)
			if tick() - _G.buyLimitReached < buyCooldown then return end
			local drink_unique = PrepareFood(true)
			if not drink_unique then
				return
			end
			if isPlayer then
				repeat
					drink_unique = PrepareFood(true)
					if not drink_unique then
						return
					end
					ToolAPI.Equip:InvokeServer(drink_unique, {})
					ToolAPI.ServerUseTool:FireServer(drink_unique, "START")
					ToolAPI.ServerUseTool:FireServer(drink_unique, "END")
					task.wait(1)
				until IsAilmentDone(ailment_unique, isPlayer) or not autoFarm.Checked or not module.On
			else
				ToolAPI.Equip:InvokeServer(drink_unique, {})
				task.wait(.33)
				PetObjectAPI.CreatePetObject:InvokeServer("__Enum_PetObjectCreatorType_2", {unique_id = drink_unique})
				task.wait(.33)
				PetAPI.ConsumeFoodItem:FireServer(drink_unique)
				task.wait(8)
				WaitUntilAilmentDone(ailment_unique, isPlayer)
			end
		end},
		["sick"] = {RequiresTeleport = false, Function = function(ailment_unique, isPlayer)
			MonitorAPI.HealWithDoctor:FireServer()
			WaitUntilAilmentDone(ailment_unique, isPlayer)
		end},
		["adoption_party"] = {RequiresTeleport = true, Function = function(ailment_unique, isPlayer)
			if not TeleportToPlace("Nursery") then return end
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			if not eventLock() then TeleportHome() end
		end},
		["school"] = {RequiresTeleport = true, Function = function(ailment_unique, isPlayer)
			if not TeleportToPlace("School") then return end
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			if not eventLock() then TeleportHome() end
		end},
		["pizza_party"] = {RequiresTeleport = true, Function = function(ailment_unique, isPlayer)
			if not TeleportToPlace("PizzaShop") then return end
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			if not eventLock() then TeleportHome() end
		end},
		["salon"] = {RequiresTeleport = true, Function = function(ailment_unique, isPlayer)
			if not TeleportToPlace("Salon") then return end
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			if not eventLock() then TeleportHome() end
		end},
		["pool_party"] = {RequiresTeleport = true, Function = function(ailment_unique, isPlayer)
			if not TeleportToMainMap() then return end
			_G.TeleportPlayerTo(game.Workspace.StaticMap.Pool.PoolOrigin.Position + Vector3.new(0, 5, 0))
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			if not eventLock() then TeleportHome() end
		end},
		["camping"] = {RequiresTeleport = true, Function = function(ailment_unique, isPlayer)
			if not TeleportToMainMap() then return end
			_G.TeleportPlayerTo(Workspace.StaticMap.Campsite.CampsiteOrigin.Position + Vector3.new(0, 5, 0))
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			if not eventLock() then TeleportHome() end
		end},
		["bored"] = {RequiresTeleport = true, Function = function(ailment_unique, isPlayer)
			if not TeleportToMainMap() then return end
			_G.TeleportPlayerTo(Workspace.StaticMap.Park.AilmentTarget.Position + Vector3.new(0, 5, 0))
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			if not eventLock() then TeleportHome() end
		end}
	}
	
	local autoFarmStatus = category:AddLabel("Idle")
	local autoSelectPet
	
	autoFarm = category:AddCheckbox("Auto-farm", function(state)
		if state then
			task.spawn(function()
				local pet, ailments
				while task.wait(2) and autoFarm.Checked and module.On do
					pet = GetEquippedPet()
					if autoSelectPet.Checked and (not pet or pet.properties.age >= 6) then
						pet = AutoSelectPet()
					end
					if pet then
						ReequipPet(pet)
						if Pet.Current and Pet.Model and Pet.Model.Parent == PetsModel then
							for _, ailment in pairs(GetPetAilments()) do
								if not autoFarm.Checked or not module.On then break end
								if AilmentFuncTable[ailment.id] and (not AilmentFuncTable[ailment.id].RequiresTeleport or not eventLock()) then
									autoFarmStatus:SetText("Doing pet task '" .. tostring(ailment.id) .. "'...")
									local f, err = pcall(AilmentFuncTable[ailment.id].Function, ailment.unique, false)
									if not f then
										warn(err)
									else
										task.wait(1)
									end
								end
							end
						end
					end
					for _, ailment in pairs(GetPlayerAilments()) do
						if not autoFarm.Checked or not module.On then break end
						if AilmentFuncTable[ailment.id] and (not AilmentFuncTable[ailment.id].RequiresTeleport or not eventLock()) then
							autoFarmStatus:SetText("Doing player task '" .. tostring(ailment.id) .. "'...")
							local f, err = pcall(AilmentFuncTable[ailment.id].Function, ailment.unique, true)
							if not f then
								warn(err)
							end
						end
					end
					autoFarmStatus:SetText("Waiting for tasks...")
				end
				autoFarmStatus:SetText("Idle")
			end)
		else
			autoFarmStatus:SetText("Idle")
		end
	end)
	
	autoSelectPet = category:AddCheckbox("Auto-select pets")
	autoSelectPet:SetChecked(true)
	
	category:AddButton("Teleport Home", TeleportHome).Inline = true
	category:AddButton("Teleport Town", TeleportToMainMap)
	
	local EventItems = {
		["fire_dimension_2024_burnt_bites_bait"] = true
	}
	do -- events
		local category = _G.SenHub:AddCategory("Events")
		
		local StaticMap = game.Workspace:WaitForChild("StaticMap")
		local EventHandlers = {}
		
		local eventLabel = category:AddLabel("Idle")
		local eventMapName = "FireDimension"
		
		local cookingDuration, lureDuration = 600, 600
		
		if not _G.nextCookTimestamp then _G.nextCookTimestamp = 0 end
		if not _G.lureTimer then _G.lureTimer = 0 end
		
		local hasBaits = true
		local function shouldCollectIngredients()
			local recipeData = clientData.get("fire_dimension_2024_daily_recipe")
			if autoEvents.Checked and recipeData and recipeData.recipe then
				for ingredient,amount in pairs(recipeData.recipe) do
					if GetFoodCount(ingredient) < amount then
						return true
					end
				end
			end
			return false
		end
		
		local function canCook()
			local recipeData = clientData.get("fire_dimension_2024_daily_recipe")
			if recipeData then
				local state = clientData.get("fire_dimension_2024_cooking_state")
				if state then
					return recipeData.cycle ~= state.most_recently_completed_cycle
				end
			end
		end
		
		local handlerLock = false
		eventLock = function()
			return autoEvents.Checked and not handlerLock
		end
		
		local function eventHandler()
			local recipeData = clientData.get("fire_dimension_2024_daily_recipe")
			if recipeData then
				_G.nextCookTimestamp = recipeData.next_cycle_timestamp - 18000
			end
			if lureDuration - (tick() - _G.lureTimer) > 1000 then _G.lureTimer = 0 end
			
			if canCook() then
				handlerLock = true
				if TeleportToPlace(eventMapName, true) then
					local map = GetInteriorBlueprint()
					if map then
						local cooking = map:FindFirstChild("Cooking")
						if cooking then
							local locations = cooking:FindFirstChild("IngredientLocations")
							local pots = cooking:FindFirstChild("Pots")
							if locations and pots then
								if shouldCollectIngredients() then
									for _,fruitDir in pairs(locations:GetChildren()) do
										for _,fruitModel in pairs(fruitDir:GetChildren()) do
											if fruitModel:FindFirstChild("Fruit") then
												FireDimensionAPI.PickFruit:InvokeServer(fruitDir.Name:lower(), tonumber(fruitModel.Name))
											end
										end
									end
								end
								local recipe = pots:FindFirstChildWhichIsA("Folder")
								if recipe then
									local potModel = recipe:FindFirstChildWhichIsA("Model")
									if potModel and potModel:FindFirstChild("GlowCircle") then
										FireDimensionAPI.CookRecipe:InvokeServer(recipe.Name)
									end
								end
							end
						end
					end
				end
			end
			local bait_unique = GetLowestUsesFood("fire_dimension_2024_burnt_bites_bait")
			if autoEvents.Checked and hasBaits and bait_unique and tick() - _G.lureTimer > lureDuration then
				handlerLock = true
				if TeleportHome() then
					_G.lureTimer = UseBait(bait_unique)
					if _G.lureTimer ~= nil then
						hasBaits = true
					else
						_G.lureTimer = 0
						hasBaits = false
					end
				end
			end
			local cookSeconds, cookMinutes = _G.TimeComponents(_G.nextCookTimestamp - tick())
			if _G.lureTimer > 0 then
				local lureSeconds, lureMinutes = _G.TimeComponents(_G.lureTimer + lureDuration - tick())
				eventLabel:SetText(
					string.format("COOK: [%02d:%02d] LURE: [%02d:%02d]",
					cookMinutes, cookSeconds,
					lureMinutes, lureSeconds
				))
			else
				eventLabel:SetText(
					string.format("COOK: [%02d:%02d] !NO LURE!",
					cookMinutes, cookSeconds
				))
			end
			handlerLock = false
		end
		
		autoEvents = category:AddCheckbox("Auto-event", function(state)
			hasBaits = true
			if state then
				task.spawn(function()
					while task.wait(1) and autoEvents.Checked and module.On do
						eventLabel:SetText("Doing event: " .. tostring(eventMapName))
						local f, err = pcall(eventHandler)
						if not f then
							warn("eventhandler error:", err)
							eventLabel:SetText("HANDLER ERROR!")
							task.wait(5)
						end
					end
					eventLabel:SetText("Idle")
				end)
			end
		end)
	end
	
	do -- trading
		local category = _G.SenHub:AddCategory("Trading")
		
		local playerSelectionPopup, selectPlayerBtn
		local masterPlayer = nil
		local function UpdatePlayersList()
			if playerSelectionPopup then
				local list = {}
				for k,v in pairs(game.Players:GetPlayers()) do
					if v ~= plr then
						local espData = _G.ESPModule_GetESPData(v)
						table.insert(list, {
							Value = v,
							Text = v.DisplayName .. "\n(@" .. v.Name .. ")",
							Image = function()
								return game.Players:GetUserThumbnailAsync(v.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size180x180)
							end,
							Color = espData and espData.Color or v.TeamColor.Color
						})
					end
				end
				table.sort(list, function(a,b)
					return a.Text < b.Text
				end)
				playerSelectionPopup.UpdateList(list)
			end
			masterPlayer = (masterPlayer and masterPlayer.Parent) and masterPlayer or nil
			selectPlayerBtn:SetText(masterPlayer and masterPlayer.DisplayName or "Select Trade Target")
		end
		
		selectPlayerBtn	= category:AddButton("Select Trade Target", function()
			selectPlayerBtn:SetEnabled(false)
			playerSelectionPopup = _G.SenHub:CreatePopup("GridList", {
				Title = "Player Selection",
				List = nil,
				UserChoice = function(result)
					masterPlayer = result
					local espData = masterPlayer and _G.ESPModule_GetESPData(masterPlayer) or nil
					selectPlayerBtn:SetText(masterPlayer and masterPlayer.DisplayName or "Select Trade Target")
					selectPlayerBtn._GuiObject.TextColor3 = espData and espData.Color or (masterPlayer and masterPlayer.TeamColor.Color or Color3.new(1, 1, 1))
					selectPlayerBtn:SetEnabled(true)
					playerSelectionPopup = nil
				end
			})
			UpdatePlayersList()
		end)
		
		table.insert(connections, game.Players.PlayerAdded:Connect(function()
			UpdatePlayersList()
		end))
		table.insert(connections, game.Players.PlayerRemoving:Connect(function()
			UpdatePlayersList()
		end))
		
		local transferCategory = category:AddDropdown("Transfer Category", {"Everything", "Pets", "Adult Pets", "Eggs", "Gifts", "Event Items"}, 6)
		
		do
			local transferAll
			local transfering = false
			transferAll = category:AddButton("Transfer To Player", function()
				if masterPlayer then
					if not transfering then
						transfering = true
						if not PlayerGui.TradeApp.Frame.Visible then
							transferAll:SetText("Requesting trade...")
							repeat
								TradeAPI.SendTradeRequest:FireServer(masterPlayer)
								task.wait(1)
							until PlayerGui.TradeApp.Frame.Visible or not masterPlayer or not transfering or not module.On
						end
						if transfering and PlayerGui.TradeApp.Frame.Visible then
							transferAll:SetText("Transfering...")
							
							local all = transferCategory.SelectedOption == 1
							
							if all or transferCategory.SelectedOption == "Pets" then
								for pet_unique,_ in pairs(GetPets()) do
									TradeAPI.AddItemToOffer:FireServer(pet_unique)
								end
							end
							
							if transferCategory.SelectedOption == "Adult Pets" then
								for pet_unique,petData in pairs(GetPets()) do
									if petData.properties.age == 6 then
										TradeAPI.AddItemToOffer:FireServer(pet_unique)
									end
								end
							end
							
							if transferCategory.SelectedOption == "Eggs" then
								for egg_unique,_ in pairs(GetEggs()) do
									TradeAPI.AddItemToOffer:FireServer(egg_unique)
								end
							end
							
							if all or transferCategory.SelectedOption == "Gifts" then
								for k,v in pairs(GetClientData().inventory.gifts) do
									TradeAPI.AddItemToOffer:FireServer(v.unique)
								end
							end
							
							if all or transferCategory.SelectedOption == "Event Items" then
								for _,category in pairs(GetClientData().inventory) do
									if type(category) == "table" then
										for _,obj in pairs(category) do
											if obj.id and obj.unique and EventItems[obj.id] then
												TradeAPI.AddItemToOffer:FireServer(obj.unique)
											end
										end
									end
								end
							end
							
							transferAll:SetText("Waiting for accept...")
							
							repeat
								task.wait(1)
								TradeAPI.AcceptNegotiation:FireServer()
								TradeAPI.ConfirmTrade:FireServer()
							until not PlayerGui.TradeApp.Frame.Visible or not masterPlayer or not transfering or not module.On
							
							task.wait(1)
							
							if PlayerGui.DialogApp.Dialog.NormalDialog.Buttons:FindFirstChild("ButtonTemplate") then
								for _,v in pairs(getconnections(PlayerGui.DialogApp.Dialog.NormalDialog.Buttons.ButtonTemplate.MouseButton1Click)) do
									--v.Function()
									v:Fire()
								end
							end
						end
					else
						transfering = false
					end
				end
				transferAll:SetText("Transfer To Player")
			end)
		end
		
		local autoAccept
		autoAccept = category:AddCheckbox("Auto-accept trades", function(state)
			if state then
				while autoAccept.Checked and module.On do
					for k,v in pairs(game.Players:GetPlayers()) do
						if v ~= plr then
							TradeAPI.AcceptOrDeclineTradeRequest:InvokeServer(v,true)
						end
					end
					
					if PlayerGui.TradeApp.Frame.Visible then
						repeat
							task.wait(.5)
							TradeAPI.AcceptNegotiation:FireServer()
							TradeAPI.ConfirmTrade:FireServer()
						until not PlayerGui.TradeApp.Frame.Visible or not masterPlayer or not transfering or not module.On
					else
						task.wait(1)
					end
					
					if PlayerGui.DialogApp.Dialog.NormalDialog.Buttons:FindFirstChild("ButtonTemplate") then
						for _,v in pairs(getconnections(PlayerGui.DialogApp.Dialog.NormalDialog.Buttons.ButtonTemplate.MouseButton1Click)) do
							v.Function()
							v:Fire()
						end
					end
					task.wait(1)
				end
			end
		end)
		
		category:AddLabel("Bot-preps")
		
		category:AddButton("Get Trading License", function()
			TradeAPI.BeginQuiz:FireServer()
			for i,v in pairs(getgc(true)) do
				if type(v) == "table" and rawget(v,"question_index") then
					for i,v in pairs(v.quiz) do
						TradeAPI.AnswerQuizQuestion:FireServer(v.answer)
					end 
				end 
			end 
		end)
	end
	
	if _G.MeltinENV == 1 then
		local category = _G.SenHub:AddCategory("DEV")
		category:AddButton("Copy full data", function()
			setclipboard(_G.Discover(clientData.get_data(), 3))
		end)
		category:AddButton("Copy player data", function()
			setclipboard(_G.Discover(GetClientData(), 6))
		end)
		category:AddButton("Copy player inventory", function()
			setclipboard(_G.Discover(GetClientData().inventory, 4))
		end)
		category:AddButton("Copy API", function()
			setclipboard(_G.Discover(debugApiTable))
		end)
	end
end

function module.Shutdown()
	
end

return module