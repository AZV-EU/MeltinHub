local module = {
	On = false
}

local plr = game.Players.LocalPlayer
local MAX_WAIT = 60

function module.PreInit()
	
end

function module.Init(category, connections)
	local ailments = plr.PlayerGui:WaitForChild("AilmentsMonitorApp"):WaitForChild("Ailments")
	local clientModules = _G.SafeGetService("ReplicatedStorage"):WaitForChild("ClientModules")
	
	local clientData = require(clientModules:WaitForChild("Core"):WaitForChild("ClientData"))
	
	local PetsModel = game.Workspace:WaitForChild("Pets")
	local HouseInteriors = game.Workspace:WaitForChild("HouseInteriors")
	local HouseExteriors = game.Workspace:WaitForChild("HouseExteriors")
	
	local Pet = {
		Current = nil,
		Model = nil
	}
	
	-- API deobfuscator
	local API = {}
	for k,v in pairs(getupvalue(require(_G.SafeGetService("ReplicatedStorage").Fsys).load("RouterClient").init, 4)) do
		local cls, fnName = unpack(string.split(k,"/"))
		if not API[cls] then
			API[cls] = {}
		end
		API[cls][fnName] = v
		v.Name = k
	end
	_G.MethodEmulator:SetMethodOverride(API.ErrorReportAPI.SendUniqueError, "FireServer", function() end)
	
	local LocationFunc = nil
	for k, v in pairs(getgc()) do
		if type(v) == "function" then
			if getfenv(v).script == _G.SafeGetService("ReplicatedStorage").ClientModules.Core.InteriorsM.InteriorsM then
				if table.find(getconstants(v), "LocationAPI/SetLocation") then
					LocationFunc = v
					break
				end
			end
		end
	end
	if not LocationFunc then
		warn("Could not find location func")
		return
	end
	
	--[[do
		local test = {}
		for k, v in pairs(getgc()) do
			if type(v) == "function" then
				pcall(function()
					local constants = getconstants(v)
					if table.find(constants, "LocationAPI/SetLocation") then
						
					end
				end)
			end
		end
		setclipboard(_G.Discover(test, 8))
	end]]
	
	local function GetClientData()
		return clientData.get_data()[plr.Name]
	end

	local function SetLocation(locationName, targetModelName, metadata)
		local O = get_thread_identity()
		set_thread_identity(2)
		LocationFunc(locationName, targetModelName, metadata)
		set_thread_identity(O)
	end
	
	local function GetInteriorBlueprint()
		return HouseInteriors.blueprint:FindFirstChildWhichIsA("Model") or game.Workspace.Interiors:FindFirstChildWhichIsA("Model")
	end
	
	local function IsAtHome()
		local bp = GetInteriorBlueprint()
		return bp and bp.Name == plr.Name
	end
	
	local function TeleportHome()
		if not IsAtHome() then
			_G.SetCharAnchored(true)
			SetLocation("housing", "MainDoor", {
				["anchor_char_immediately"] = true,
				["house_owner"] = plr
			})
			_G.SetCharAnchored(false)
			if IsAtHome() then
				local mainDoor = GetInteriorBlueprint():FindFirstChild("MainDoor", true)
				if mainDoor then
					local touchToEnter = mainDoor:FindFirstChild("TouchToEnter", true)
					if touchToEnter then
						_G.TeleportPlayerTo(touchToEnter.CFrame * CFrame.new(0, 0, -5))
					end
				end
			end
		end
	end
	
	local function TeleportToStore(shopName)
		if GetInteriorBlueprint().Name ~= shopName then
			SetLocation(shopName, "MainDoor", {
				["anchor_char_immediately"] = true
			})
		end
	end
	
	local function TeleportToMainMap()
		if GetInteriorBlueprint().Name ~= "MainMap" then
			SetLocation("MainMap", "Neighborhood/MainDoor", {
				["anchor_char_immediately"] = true
			})
		end
	end
	
	local function GetPets()
		local pets = GetClientData().inventory.pets or {}
		local myPets = {}
		for _,pet in pairs(pets) do
			myPets[pet.unique] = pet
		end
		return myPets
	end
	
	local function GetEquippedPet()
		return GetClientData().equip_manager.pets
	end
	
	local function GetFurnitureByUseId(use_id)
		for _,fContainer in pairs(HouseInteriors.furniture:GetChildren()) do
			local fModel = fContainer:FindFirstChildWhichIsA("Model")
			if fModel then
				local useBlocks = fModel:FindFirstChild("UseBlocks")
				if useBlocks then
					for _,useBlock in pairs(useBlocks:GetChildren()) do
						local config = useBlock:FindFirstChild("Configuration")
						if config and config:FindFirstChild("use_id") and config.use_id.Value == use_id then
							return fModel:GetAttribute("furniture_unique")
						end
					end
				end
			end
		end
	end
	
	local function GetPlayerTeam()
		return GetClientData().team
	end
	
	--[[do
		for _,pet in pairs(GetPets()) do
			pet.properties.rideable = true
			pet.properties.flyable = true
		end
	end]]
	
	local function ReequipPet(pet)
		if Pet.Current and Pet.Current.unique == pet.unique then return end
		Pet.Current = pet
		API.ToolAPI.Unequip:InvokeServer(pet.unique)
		_, Pet.Model = API.ToolAPI.Equip:InvokeServer(pet.unique)
	end
	
	local function AutoSelectPet()
		local oldestPet, oldestAge = nil, 0
		for _,pet in pairs(GetPets()) do
			if pet.id ~= "practice_dog" and pet.properties.age < 6 and (not oldestPet or pet.properties.age > oldestAge) then
				oldestPet = pet
				oldestAge = pet.properties.age
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
	
	local function GetFood(isDrink)
		if GetClientData().is_vip then
			if not GetLowestUsesFood(isDrink and "water_vip" or "ham_vip") then
				API.ShopAPI.BuyItem:InvokeServer("food", isDrink and "water_vip" or "ham_vip", {})
			end
			return GetLowestUsesFood(isDrink and "water_vip" or "ham_vip")
		else
			if isDrink and not GetLowestUsesFood("tea") then
				API.ShopAPI.BuyItem:InvokeServer("food", "tea", {})
			elseif not isDrink and not GetLowestUsesFood("pizza") then
				API.ShopAPI.BuyItem:InvokeServer("food", "pizza", {})
				API.ToolAPI.BakeItem:InvokeServer()
				task.wait(3)
			end
			return GetLowestUsesFood(isDrink and "tea" or "pizza")
		end
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
	
	local autoFarm = category:AddCheckbox("Auto-farm")
	
	local function IsAilmentDone(ailment_unique, isPlayer)
		return GetAilmentFromUnique(ailment_unique, isPlayer) == nil
	end
	
	local function WaitUntilAilmentDone(ailment_unique, isPlayer)
		local waitStart = tick()
		repeat
			task.wait(1)
		until IsAilmentDone(ailment_unique, isPlayer) or tick() - waitStart > MAX_WAIT or not autoFarm.Checked or not module.On
	end
	
	local AilmentFuncTable = {
		["sleepy"] = function(ailment_unique, isPlayer)
			TeleportHome()
			local bed = GetFurnitureByUseId("generic_crib")
			if bed then
				task.spawn(function()
					API.HousingAPI.ActivateFurniture:InvokeServer(
						plr,
						bed,
						"UseBlock",
						{
							["cframe"] = plr.Character:GetPivot()
						},
						isPlayer and plr.Character or Pet.Model
					)
				end)
				WaitUntilAilmentDone(ailment_unique, isPlayer)
				if isPlayer and plr and plr.Character and plr.Character:FindFirstChild("Humanoid") then
					plr.Character.Humanoid.Jump = true
				end
			end
		end,
		["dirty"] = function(ailment_unique, isPlayer)
			TeleportHome()
			local shower = GetFurnitureByUseId("generic_shower")
			if shower then
				task.spawn(function()
					API.HousingAPI.ActivateFurniture:InvokeServer(
						plr,
						shower,
						"UseBlock",
						{
							["cframe"] = plr.Character:GetPivot()
						},
						isPlayer and plr.Character or Pet.Model
					)
				end)
				WaitUntilAilmentDone(ailment_unique, isPlayer)
				if isPlayer and plr and plr.Character and plr.Character:FindFirstChild("Humanoid") then
					plr.Character.Humanoid.Jump = true
				end
			end
		end,
		["hungry"] = function(ailment_unique, isPlayer)
			local food_unique
			if isPlayer then
				repeat
					food_unique = GetFood(false)
					if not food_unique then
						warn("Could not get food!")
						return
					end
					API.ToolAPI.Equip:InvokeServer(food_unique, {["use_sound_delay"] = true})
					API.ToolAPI.ServerUseTool:FireServer(food_unique, "START")
					API.ToolAPI.ServerUseTool:FireServer(food_unique, "END")
					task.wait(.33)
				until IsAilmentDone(ailment_unique, isPlayer)
			else
				food_unique = GetFood(false)
				if not food_unique then
					warn("Could not get food!")
					return
				end
				API.ToolAPI.Equip:InvokeServer(food_unique, {["use_sound_delay"] = true})
				API.PetObjectAPI.CreatePetObject:InvokeServer("__Enum_PetObjectCreatorType_2", {["unique_id"] = food_unique})
				API.PetAPI.ConsumeFoodItem:FireServer(food_unique)
				task.wait(2)
				WaitUntilAilmentDone(ailment_unique, isPlayer)
			end
		end,
		["thirsty"] = function(ailment_unique, isPlayer)
			local drink_unique
			if isPlayer then
				repeat
					drink_unique = GetFood(true)
					if not drink_unique then
						warn("Could not get drink!")
						return
					end
					API.ToolAPI.Equip:InvokeServer(drink_unique, {["use_sound_delay"] = true})
					API.ToolAPI.ServerUseTool:FireServer(drink_unique, "START")
					API.ToolAPI.ServerUseTool:FireServer(drink_unique, "END")
					task.wait(.33)
				until IsAilmentDone(ailment_unique, isPlayer) or not autoFarm.Checked or not module.On
			else
				drink_unique = GetFood(true)
				if not drink_unique then
					warn("Could not get drink!")
					return
				end
				API.ToolAPI.Equip:InvokeServer(drink_unique, {["use_sound_delay"] = true})
				API.PetObjectAPI.CreatePetObject:InvokeServer("__Enum_PetObjectCreatorType_2", {["unique_id"] = drink_unique})
				API.PetAPI.ConsumeFoodItem:FireServer(drink_unique)
				task.wait(2)
				WaitUntilAilmentDone(ailment_unique, isPlayer)
			end
		end,
		["sick"] = function(ailment_unique, isPlayer)
			API.MonitorAPI.HealWithDoctor:FireServer()
			if isPlayer then _G.SetCharAnchored(true) end
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			if isPlayer then _G.SetCharAnchored(false) end
		end,
		["adoption_party"] = function(ailment_unique, isPlayer)
			TeleportToStore("Nursery")
			if isPlayer then _G.SetCharAnchored(true) end
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			if isPlayer then _G.SetCharAnchored(false) end
		end,
		["school"] = function(ailment_unique, isPlayer)
			TeleportToStore("School")
			if isPlayer then _G.SetCharAnchored(true) end
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			if isPlayer then _G.SetCharAnchored(false) end
		end,
		["pizza_party"] = function(ailment_unique, isPlayer)
			TeleportToStore("PizzaShop")
			if isPlayer then _G.SetCharAnchored(true) end
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			if isPlayer then _G.SetCharAnchored(false) end
		end,
		["salon"] = function(ailment_unique, isPlayer)
			TeleportToStore("Salon")
			if isPlayer then _G.SetCharAnchored(true) end
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			if isPlayer then _G.SetCharAnchored(false) end
		end,
		["pool_party"] = function(ailment_unique, isPlayer)
			TeleportToMainMap()
			_G.TeleportPlayerTo(game.Workspace.StaticMap.Pool.PoolOrigin.Position + Vector3.new(0, 5, 0))
			if isPlayer then _G.SetCharAnchored(true) end
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			if isPlayer then _G.SetCharAnchored(false) end
		end,
		["camping"] = function(ailment_unique, isPlayer)
			TeleportToMainMap()
			_G.TeleportPlayerTo(Workspace.StaticMap.Campsite.CampsiteOrigin.Position + Vector3.new(0, 5, 0))
			if isPlayer then _G.SetCharAnchored(true) end
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			if isPlayer then _G.SetCharAnchored(false) end
		end,
		["bored"] = function(ailment_unique, isPlayer)
			TeleportToMainMap()
			_G.TeleportPlayerTo(Workspace.StaticMap.Park.AilmentTarget.Position + Vector3.new(0, 5, 0))
			if isPlayer then _G.SetCharAnchored(true) end
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			if isPlayer then _G.SetCharAnchored(false) end
		end
	}
	
	local autoFarmStatus = category:AddLabel("Idle")
	local autoSelectPet = category:AddCheckbox("Auto-select pets")
	autoSelectPet:SetChecked(true)
	
	task.spawn(function()
		local pet, ailments
		while task.wait(1) and module.On do
			if autoFarm.Checked then
				pet = GetEquippedPet()
				if (not pet or pet.properties.age >= 6) and autoSelectPet.Checked then
					pet = AutoSelectPet()
				end
				if pet and pet.properties.age < 6 then
					ReequipPet(pet)
					if Pet.Current and Pet.Model and Pet.Model.Parent == PetsModel then
						for _, ailment in pairs(GetPetAilments()) do
							if not module.On then break end
							if AilmentFuncTable[ailment.id] then
								autoFarmStatus:SetText("Doing pet task '" .. tostring(ailment.id) .. "'...")
								local f, err = pcall(AilmentFuncTable[ailment.id], ailment.unique, false)
								if not f then
									warn(err)
								end
							end
						end
					end
				end
				for _, ailment in pairs(GetPlayerAilments()) do
					if not module.On then break end
					if AilmentFuncTable[ailment.id] then
						autoFarmStatus:SetText("Doing player task '" .. tostring(ailment.id) .. "'...")
						local f, err = pcall(AilmentFuncTable[ailment.id], ailment.unique, true)
						if not f then
							warn(err)
						end
					end
				end
				autoFarmStatus:SetText("Waiting for tasks...")
			else
				autoFarmStatus:SetText("Idle")
			end
		end
	end)
	
	category:AddButton("Teleport Home", TeleportHome)
end

function module.Shutdown()
	
end

return module