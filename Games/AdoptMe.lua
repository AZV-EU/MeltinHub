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

	local function SetLocation(locationName, targetModelName, metadata)
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
	
	local function TeleportHome()
		if not IsAtPlace(plr.Name) then
			while not IsAtPlace(plr.Name) and task.wait(1) and module.On do
				_G.SetCharAnchored(true)
				SetLocation("housing", "MainDoor", {
					["house_owner"] = plr
				})
				_G.SetCharAnchored(false)
				if IsAtPlace(plr.Name) then
					local mainDoor = GetInteriorBlueprint():FindFirstChild("MainDoor", true)
					if mainDoor then
						local touchToEnter = mainDoor:FindFirstChild("TouchToEnter", true)
						if touchToEnter then
							_G.TeleportPlayerTo(touchToEnter.CFrame * CFrame.new(0, 0, -5))
						end
					end
				end
			end
			task.wait(3)
		end
	end
	
	local function TeleportToStore(shopName)
		if not IsAtPlace(shopName) then
			while not IsAtPlace(shopName) and task.wait(1) and module.On do
				_G.SetCharAnchored(true)
				SetLocation(shopName, "MainDoor")
				_G.SetCharAnchored(false)
			end
			task.wait(3)
		end
	end
	
	local function TeleportToMainMap()
		if not IsAtPlace("MainMap", true) then
			while not IsAtPlace("MainMap", true) and task.wait(1) and module.On do
				_G.SetCharAnchored(true)
				_G.TeleportPlayerTo(game.Workspace.StaticMap.TeleportLocations.Town.Position)
				SetLocation("MainMap", "Neighborhood/MainDoor")
				_G.SetCharAnchored(false)
			end
			task.wait(3)
		end
	end
	
	local function GetPets()
		local pets = GetClientData().inventory.pets or {}
		local myPets = {}
		for _,pet in pairs(pets) do
			if pet.id ~= "practice_dog" and pet.Name:sub(-4) ~= "_egg" then
				myPets[pet.unique] = pet
			end
		end
		return myPets
	end
	
	local function GetEggs()
		local pets = GetClientData().inventory.pets or {}
		local myEggs = {}
		for _,pet in pairs(pets) do
			if pet.Name:sub(-4) == "_egg" then
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
	
	local function GetFood(isDrink)
		if isDrink and not GetLowestUsesFood("tea") then
			ShopAPI.BuyItem:InvokeServer("food", "tea", {})
		elseif not isDrink and not GetLowestUsesFood("pizza") then
			ShopAPI.BuyItem:InvokeServer("food", "pizza", {})
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
	
	local autoEvents
	local AilmentFuncTable = {
		["sleepy"] = function(ailment_unique, isPlayer)
			if not autoEvents.Checked then TeleportHome() end
			local beds = GetFurnitureByUseId("generic_crib")
			if #beds > 0 then
				task.spawn(function()
					HousingAPI.ActivateFurniture:InvokeServer(
						plr,
						beds[1],
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
			if not autoEvents.Checked then TeleportHome() end
			local showers = GetFurnitureByUseId("generic_shower")
			if #showers > 0 then
				task.spawn(function()
					HousingAPI.ActivateFurniture:InvokeServer(
						plr,
						showers[1],
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
			local food_unique = GetFood(false)
			if not food_unique then
				return
			end
			if isPlayer then
				repeat
					food_unique = GetFood(false)
					if not food_unique then
						return
					end
					ToolAPI.Equip:InvokeServer(food_unique, {["use_sound_delay"] = true})
					ToolAPI.ServerUseTool:FireServer(food_unique, "START")
					ToolAPI.ServerUseTool:FireServer(food_unique, "END")
					task.wait(.33)
				until IsAilmentDone(ailment_unique, isPlayer)
			else
				ToolAPI.Equip:InvokeServer(food_unique, {["use_sound_delay"] = true})
				PetObjectAPI.CreatePetObject:InvokeServer("__Enum_PetObjectCreatorType_2", {["unique_id"] = food_unique})
				PetAPI.ConsumeFoodItem:FireServer(food_unique)
				task.wait(2)
				WaitUntilAilmentDone(ailment_unique, isPlayer)
			end
		end,
		["thirsty"] = function(ailment_unique, isPlayer)
			local drink_unique = GetFood(true)
			if not drink_unique then
				return
			end
			if isPlayer then
				repeat
					drink_unique = GetFood(true)
					if not drink_unique then
						return
					end
					ToolAPI.Equip:InvokeServer(drink_unique, {["use_sound_delay"] = true})
					ToolAPI.ServerUseTool:FireServer(drink_unique, "START")
					ToolAPI.ServerUseTool:FireServer(drink_unique, "END")
					task.wait(.33)
				until IsAilmentDone(ailment_unique, isPlayer) or not autoFarm.Checked or not module.On
			else
				ToolAPI.Equip:InvokeServer(drink_unique, {["use_sound_delay"] = true})
				PetObjectAPI.CreatePetObject:InvokeServer("__Enum_PetObjectCreatorType_2", {["unique_id"] = drink_unique})
				PetAPI.ConsumeFoodItem:FireServer(drink_unique)
				task.wait(2)
				WaitUntilAilmentDone(ailment_unique, isPlayer)
			end
		end,
		["sick"] = function(ailment_unique, isPlayer)
			MonitorAPI.HealWithDoctor:FireServer()
		end,
		["adoption_party"] = function(ailment_unique, isPlayer)
			if autoEvents.Checked then return end
			TeleportToStore("Nursery")
			_G.SetCharAnchored(true)
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			_G.SetCharAnchored(false)
		end,
		["school"] = function(ailment_unique, isPlayer)
			if autoEvents.Checked then return end
			TeleportToStore("School")
			_G.SetCharAnchored(true)
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			_G.SetCharAnchored(false)
		end,
		["pizza_party"] = function(ailment_unique, isPlayer)
			if autoEvents.Checked then return end
			TeleportToStore("PizzaShop")
			_G.SetCharAnchored(true)
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			_G.SetCharAnchored(false)
		end,
		["salon"] = function(ailment_unique, isPlayer)
			if autoEvents.Checked then return end
			TeleportToStore("Salon")
			_G.SetCharAnchored(true)
			WaitUntilAilmentDone(ailment_unique, isPlayer)
			_G.SetCharAnchored(false)
		end,
		["pool_party"] = function(ailment_unique, isPlayer)
			if autoEvents.Checked then return end
			TeleportToMainMap()
			_G.TeleportPlayerTo(game.Workspace.StaticMap.Pool.PoolOrigin.Position + Vector3.new(0, 5, 0))
			WaitUntilAilmentDone(ailment_unique, isPlayer)
		end,
		["camping"] = function(ailment_unique, isPlayer)
			if autoEvents.Checked then return end
			TeleportToMainMap()
			_G.TeleportPlayerTo(Workspace.StaticMap.Campsite.CampsiteOrigin.Position + Vector3.new(0, 5, 0))
			WaitUntilAilmentDone(ailment_unique, isPlayer)
		end,
		["bored"] = function(ailment_unique, isPlayer)
			if autoEvents.Checked then return end
			TeleportToMainMap()
			_G.TeleportPlayerTo(Workspace.StaticMap.Park.AilmentTarget.Position + Vector3.new(0, 5, 0))
			WaitUntilAilmentDone(ailment_unique, isPlayer)
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
	
	category:AddButton("TP Home", TeleportHome).Inline = true
	category:AddButton("TP MainMap", TeleportToMainMap)
	
	local EventItems = {
		["fire_dimension_2024_burnt_bites_bait"] = true
	}
	do -- events
		local category = _G.SenHub:AddCategory("Events")
		
		local StaticMap = game.Workspace:WaitForChild("StaticMap")
		local EventHandlers = {}
		
		local eventLabel = category:AddLabel("Idle")
		do
			EventHandlers["Lunar2024Shop"] = function(map)
				local state = StaticMap:FindFirstChild("red_light_green_light_minigame_state")
				if state and state:FindFirstChild("is_game_active") and state.is_game_active.Value == true and state:FindFirstChild("players_loading") and state.players_loading.Value == false then
					local arena = map:FindFirstChild("Arena")
					if arena then
						local throwables = arena:FindFirstChild("Throwables")
						if throwables then
							local targets = {}
							for _, throwable in pairs(throwables:GetChildren()) do
								if throwable:IsA("Model") and throwable:GetAttribute("UserId") == plr.UserId and throwable.Name == "ThrowableGold" then
									table.insert(targets, throwable)
								end
							end
							for _, throwable in pairs(throwables:GetChildren()) do
								if throwable:IsA("Model") and throwable:GetAttribute("UserId") == plr.UserId and throwable.Name == "ThrowableNormal" then
									table.insert(targets, throwable)
								end
							end
							if #targets > 0 then
								local count = 0
								for _, target in pairs(targets) do
									MinigameAPI.MessageServer:FireServer("red_light_green_light", "attempt_pick_up", target:GetAttribute("Id"))
									task.wait(.5)
									count += 1
									if count == 3 then
										MinigameAPI.MessageServer:FireServer("red_light_green_light", "attempt_drop_off", 1)
										task.wait(.5)
										count = 0
									end
								end
								MinigameAPI.MessageServer:FireServer("red_light_green_light", "attempt_drop_off", 1)
							end
						end
					end
				elseif string.find(map.Name, "MainMap") then
					for _, furniture_unique in pairs(GetFurnitureByName("LNY2024KiteBox")) do
						HousingAPI.ActivateInteriorFurniture:InvokeServer(furniture_unique, "UseBlock", nil, plr.Character)
					end
				end
			end
		end
		
		do
			EventHandlers["FireDimension"] = function(map)
				local cooking = map:FindFirstChild("Cooking")
				if cooking then
					local locations = cooking:FindFirstChild("IngredientLocations")
					local pots = cooking:FindFirstChild("Pots")
					if locations and pots then
						for _,fruitDir in pairs(locations:GetChildren()) do
							for _,fruitModel in pairs(fruitDir:GetChildren()) do
								if fruitModel:FindFirstChild("Fruit") then
									FireDimensionAPI.PickFruit:InvokeServer(fruitDir.Name:lower(), tonumber(fruitModel.Name))
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
		
		autoEvents = category:AddCheckbox("Auto-events")
		--autoEvents:SetChecked(true)
		
		task.spawn(function()
			local map, eventHandler
			while task.wait(2) and module.On do
				map = GetInteriorBlueprint()
				if autoEvents.Checked and map and EventHandlers[map.Name] then
					eventLabel:SetText("Event: " .. map.Name)
					local f, err = pcall(EventHandlers[map.Name], map)
					if not f then
						eventLabel:SetText("HANDLER ERROR!")
						warn(err)
						task.wait(5)
					end
				else
					eventLabel:SetText("Idle")
					task.wait(2)
				end
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
				while autoAccept.Checked and module.On and task.wait(2) do
					for k,v in pairs(game.Players:GetPlayers()) do
						if v ~= plr then
							TradeAPI.AcceptOrDeclineTradeRequest:InvokeServer(v,true)
						end
					end
					
					repeat
						task.wait(1)
						TradeAPI.AcceptNegotiation:FireServer()
						TradeAPI.ConfirmTrade:FireServer()
					until not PlayerGui.TradeApp.Frame.Visible or not masterPlayer or not transfering or not module.On
					
					if PlayerGui.DialogApp.Dialog.NormalDialog.Buttons:FindFirstChild("ButtonTemplate") then
						for _,v in pairs(getconnections(PlayerGui.DialogApp.Dialog.NormalDialog.Buttons.ButtonTemplate.MouseButton1Click)) do
							--v.Function()
							v:Fire()
						end
					end
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
		category:AddButton("Copy client data", function()
			setclipboard(_G.Discover(GetClientData(), 6))
		end)
		category:AddButton("Copy API", function()
			setclipboard(_G.Discover(debugApiTable))
		end)
	end
end

function module.Shutdown()
	
end

return module