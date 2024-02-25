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