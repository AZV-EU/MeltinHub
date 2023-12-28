local module = {
	GameName = "Banana Eats",
	ModuleVersion = "1.0"
}

function module.PreInit()
	
end

function module.Init(category, connections)
	local plr = game.Players.LocalPlayer
	
	local moduleOn = true

	local gameKeeper = game.Workspace:WaitForChild("GameKeeper")
	local map = gameKeeper:WaitForChild("Map")
	local puzzles = gameKeeper:WaitForChild("Puzzles")
	local items = map:FindFirstChild("Items")

	_G.MeltinHub_ValidAllyCheck = function(target)
		if target:IsA("Player") then
			return target.Team == plr.Team
		end
		return false
	end
	
	local autoCollectPumpkins = category:AddCheckbox("Auto-Collect Pumpkins")
	autoCollectPumpkins:SetChecked(true)
	local autoCollectCoins = category:AddCheckbox("Auto-Collect Coins")
	autoCollectCoins:SetChecked(true)
	local autoCollectPowerUps = category:AddCheckbox("Auto-Collect Power Ups")
	autoCollectPowerUps:SetChecked(true)
	
	--[[
	local puzzles = gameKeeper:FindFirstChild("_Puzzles") or Instance.new("Model", gameKeeper)
	puzzles.Name = "_Puzzles"
	
	local cakeParts = gameKeeper:FindFirstChild("_CakeParts") or Instance.new("Model", gameKeeper)
	cakeParts.Name = "_CakeParts"
	
	table.insert(connections, gameKeeper.ChildAdded:Connect(function(child)
		if child.Name == "MapName" then
			task.wait(6)
			for k,v in pairs(puzzlesOrigin:GetChildren()) do
				v.Parent = nil
				task.wait(0.1)
				v.Parent = puzzles
			end
			
			local items = map:FindFirstChild("Items")
			if items then
				for k,v in pairs(items:GetChildren()) do
					if v.Name == "CakePlate" then
						v.Parent = nil
						task.wait(0.1)
						v.Parent = cakeParts
					end
				end
				table.insert(connections, items.ChildAdded:Connect(function(cake)
					if cake.Name == "CakePlate" then
						task.wait(1)
						cake.Parent = nil
						task.wait(0.1)
						cake.Parent = cakeParts
					end
				end))
			end
		end
	end))
	
	table.insert(connections, gameKeeper.ChildRemoved:Connect(function(child)
		if child.Name == "MapName" then
			puzzles:ClearAllChildren()
			cakeParts:ClearAllChildren()
		end
	end))
	
	do
		for k,v in pairs(puzzlesOrigin:GetChildren()) do
			v.Parent = puzzles
		end
		
		local items = map:FindFirstChild("Items")
		if items then
			for k,v in pairs(items:GetChildren()) do
				if v.Name == "CakePlate" then
					v.Parent = cakeParts
				end
			end
			table.insert(connections, items.ChildAdded:Connect(function(cake)
				if cake.Name == "CakePlate" then
					task.wait(1)
					cake.Parent = nil
					task.wait(0.1)
					cake.Parent = cakeParts
				end
			end))
		end
	end
	
	local puzzlesESP = gameKeeper:FindFirstChild("PuzzlesESP") or Instance.new("Highlight", gameKeeper)
	puzzlesESP.Name = "PuzzlesESP"
	puzzlesESP.FillColor = Color3.new(1, 1, 0)
	puzzlesESP.OutlineColor = Color3.new(1, 1, 0)
	puzzlesESP.Adornee = puzzles
	puzzlesESP.FillTransparency = 0.7
	
	local cakesESP = gameKeeper:FindFirstChild("CakesESP") or Instance.new("Highlight", gameKeeper)
	cakesESP.Name = "CakesESP"
	cakesESP.FillColor = Color3.new(1, 0, 1)
	cakesESP.OutlineColor = Color3.new(1, 0, 1)
	cakesESP.Adornee = cakeParts
	cakesESP.FillTransparency = 0.7
	]]
	
	local autoPuzzles = category:AddCheckbox("Auto-Solve Puzzles")
	local autoCake = category:AddCheckbox("Auto-Cake")
	
	local powerUps = {
		["PowerUpFF"] = true,
		["PowerUpEye"] = false
	}
	
	spawn(function()
		local tokens, pumpkins, cake, items, root
		local combinationPuzzleKey
		local completed, button, button_val, buttons, keybutton, keybutton_val, keybuttons
		
		local color_camo = Color3.fromRGB(56, 144, 11)
		
		while moduleOn and task.wait(.5) do
			tokens = map:FindFirstChild("Tokens")
			if tokens then
				for k,v in pairs(tokens:GetChildren()) do
					if (v.Name == "Token" and autoCollectCoins.Checked) or
						(powerUps[v.Name] and autoCollectPowerUps.Checked) then
						_G.TouchObject(v)
					end
				end
			end
			pumpkins = map:FindFirstChild("PumpkinSpawns")
			if pumpkins and autoCollectPumpkins.Checked then
				for k,v in pairs(pumpkins:GetChildren()) do
					if v:FindFirstChild("HumanoidRootPart") then
						_G.TouchObject(v.HumanoidRootPart)
					end
				end
			end
			if autoPuzzles.Checked then
				for k,v in pairs(puzzles:GetChildren()) do
					if v.Name == "ValvePuzzle" then
						completed = v:FindFirstChild("Completed")
						if completed and not completed.Value then
							if v:FindFirstChild("Buttons") and v.Buttons:FindFirstChild("ValveButton") and v.Buttons.ValveButton:FindFirstChild("ClickDetector") then
								for i = 1, 10 do
									pcall(function()
										fireclickdetector(v.Buttons.ValveButton.ClickDetector)
										task.wait(.05)
									end)
								end
							end
						end
					elseif v.Name == "PicturePuzzle" then
						buttons = v:FindFirstChild("Buttons")
						if buttons then
							for x, button in pairs(buttons:GetChildren()) do
								if button.Color ~= color_camo then
									if button:FindFirstChild("ClickDetector") then
										pcall(function()
											fireclickdetector(button.ClickDetector)
											task.wait(.05)
										end)
									end
								end
							end
						end
					elseif v.Name == "CombinationPuzzle" then
						combinationPuzzleKey = v:FindFirstChild("CombinationKey")
						if combinationPuzzleKey then
							buttons = v:FindFirstChild("Buttons")
							keybuttons = combinationPuzzleKey:FindFirstChild("Buttons")
							if buttons and keybuttons then
								for i = 1, 3 do
									if not moduleOn then break end
									button = buttons:FindFirstChild("Button"..tostring(i))
									keybutton = keybuttons:FindFirstChild("Button"..tostring(i))
									if button and keybutton then
										
										if button:FindFirstChild("ButtonLabel") and button.ButtonLabel:FindFirstChild("Label") and
											keybutton:FindFirstChild("ButtonLabel") and keybutton.ButtonLabel:FindFirstChild("Label") then
											button_val = tonumber(button.ButtonLabel.Label.Text)
											keybutton_val = tonumber(keybutton.ButtonLabel.Label.Text)
											if button_val ~= keybutton_val then
												if button_val > keybutton_val then
													button_val = button_val-6
												end
												if button:FindFirstChild("ClickDetector") then
													for x = button_val+1, keybutton_val do
														pcall(function()
															fireclickdetector(button.ClickDetector)
															task.wait(.05)
														end)
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
			if autoCake.Checked then
				cake = puzzles:FindFirstChild("CakePuzzle")
				if cake then
					for k,v in pairs(items:GetChildren()) do
						if v.Name == "CakePlate" and v:FindFirstChild("Model") and v.Model:FindFirstChild("CakePlate") and
							v.Model.CakePlate:FindFirstChild("Root") and v.Model.CakePlate.Root:FindFirstChild("ClickDetector") then
							local f, err = pcall(function()
								fireclickdetector(v.Model.CakePlate.Root.ClickDetector)
							end)
							if not f then
								warn(err)
							end
							task.wait(0.2)
							if plr.Character:FindFirstChild("Item") and cake:FindFirstChild("Root") then
								_G.TouchObject(cake.Root)
							end
						end
					end
				end
			end
		end
	end)
end

function module.Shutdown()
	moduleOn = false
end

return module