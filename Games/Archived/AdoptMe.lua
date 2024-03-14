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

do -- fire dimension event
	local EventItems = {
		["fire_dimension_2024_burnt_bites_bait"] = true
	}
	
		local StaticMap = game.Workspace:WaitForChild("StaticMap")
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
			return autoEvents.Checked and handlerLock
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
		
		--> ADD TO BEGINNING OF LOOP: hasBaits = true
end