local module = {
	GameName = "Murder Mystery 2",
	ModuleVersion = "1.0"
}

-- fart id: 7914322871

local plr = game.Players.LocalPlayer
local moduleOn = true

function module.PreInit()
	
end

function module.Init(category, connections)
	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local Remotes = game.ReplicatedStorage:WaitForChild("Remotes")
	local GetDataRemote = Remotes:WaitForChild("Extras"):WaitForChild("GetData")
	local PlaySongRemote = Remotes:WaitForChild("Inventory"):WaitForChild("PlaySong")

	category:AddButton("Take Gun", function()
		local gunDrop = game.Workspace:FindFirstChild("GunDrop", true)
		if gunDrop then
			_G.TeleportPlayerTo(gunDrop.Position)
		end
	end).Inline = true
	
	category:AddButton("Transparent Map", function()
		local map
		for k,v in pairs(game.Workspace:GetChildren()) do
			if v:IsA("Model") and v:FindFirstChild("Map") and v:FindFirstChild("Spawns") and v.Name ~= "Lobby" then
				map = v:FindFirstChild("Map")
				break
			end
		end
		if map then
			for k,v in pairs(map:GetDescendants()) do
				if v:IsA("BasePart") then
					if v.Transparency == 0 then
						v.Transparency = 0.75
					elseif v.Transparency == 0.75 then
						v.Transparency = 0
					end
				end
			end
		end
	end)
	
	local autoAim = category:AddCheckbox("Sheriff auto-aim")
	autoAim:SetChecked(true)
	local autoKillAll = category:AddCheckbox("Murderer auto-kill")
	--local autoCollectCoins = category:AddCheckbox("Auto-collect coins")
	--autoCollectCoins:SetChecked(true)
	
	_G.ESPModule_Database.Storages["Enemies"].Rule = function(target)
		if target:IsA("Player") then
			if target:FindFirstChild("Backpack") and target.Backpack:FindFirstChild("Knife") then
				return true
			elseif target.Character and target.Character:FindFirstChild("Knife") then
				return true
			end
		end
		return false
	end

	_G.ESPModule_Create("Sheriff", Color3.new(0, 0, 1), function(target)
		if target:IsA("Player") then
			if target:FindFirstChild("Backpack") and target.Backpack:FindFirstChild("Gun") then
				return true
			elseif target.Character and target.Character:FindFirstChild("Gun") then
				return true
			end
		end
		return false
	end, 3)
	
	_G.ESPModule_GetValidTargets = function()
		local targets = game.Players:GetPlayers()
		local gunDrop = game.Workspace:FindFirstChild("GunDrop", true)
		if gunDrop then
			table.insert(targets, gunDrop)
		end
		return targets
	end

	_G.ESPModule_SetupConnections_Optional = function(target)
		if target:IsA("Player") then
			local backpack = target:WaitForChild("Backpack")
			table.insert(connections, backpack.ChildAdded:Connect(function()
				task.wait(.33)
				_G.ESPModule_Update()
			end))
			table.insert(connections, backpack.ChildRemoved:Connect(function()
				task.wait(.33)
				_G.ESPModule_Update()
			end))
		end
	end
	
	table.insert(connections, UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or inputData.UserInputType == Enum.UserInputType.Touch then
			if autoAim.Checked then
				local murderer = nil
				for k,v in pairs(game.Players:GetPlayers()) do
					if v.Character and (v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife")) then
						murderer = v.Character
					end
				end
				if murderer then
					local los, raycast, part = _G.AIMBOT_CheckLoS(murderer)
					local remote = plr.Character:FindFirstChild("ShootGun", true)
					if los and remote then
						remote:InvokeServer(1, part.Position, "AH")
					end
				end
			else
				local remote = plr.Character:FindFirstChild("ShootGun", true)
				if remote then
					remote:InvokeServer(1, plr:GetMouse().Hit.Position, "AH")
				end
			end
		end
	end))
	
	for k,v in pairs(game.Workspace:GetChildren()) do
		if v:IsA("Model") and v:FindFirstChild("GlitchProof") then
			v.GlitchProof:Destroy()
		end
	end
	
	table.insert(connections, game:GetService("ReplicatedStorage").Remotes.Gameplay.RoundStart.OnClientEvent:Connect(function(...)
		task.wait(1)
		_G.ESPModule_Update()
		task.wait(1)
		_G.ESPModule_Update()
		task.wait(1)
		_G.ESPModule_Update()
	end))
	
	table.insert(connections, game:GetService("ReplicatedStorage").Remotes.Gameplay.RoleSelect.OnClientEvent:Connect(function(...)
		task.wait(2)
		for k,v in pairs(game.Workspace:GetChildren()) do
			if v:IsA("Model") and v:FindFirstChild("GlitchProof") then
				v.GlitchProof:Destroy()
			end
		end
	end))
	
	table.insert(connections, game:GetService("ReplicatedStorage").Remotes.Gameplay.RoundStart.OnClientEvent:Connect(function(...)
		task.wait(2)
		_G.ESPModule_Update()
	end))
	
	table.insert(connections, game.Workspace.ChildAdded:Connect(function(child)
		if child.Name == "GunDrop" then
			task.wait(0.33)
			_G.ESPModule_Update()
		end
	end))
	table.insert(connections, game.Workspace.ChildRemoved:Connect(function(child)
		if child.Name == "GunDrop" then
			task.wait(0.33)
			_G.ESPModule_Update()
		end
	end))
	
	_G.ESPModule_Create("GunDrop", Color3.new(0, 0, 1), function(target)
		return target:IsA("BasePart") and target.Name == "GunDrop"
	end, 4)
	
	if UserInputService.TouchEnabled then
		print("applying mobile fix")
		table.insert(connections, UserInputService.InputBegan:Connect(function(inputData)
			if inputData.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
				if plr and plr.Character then
					local knife = plr.Character:FindFirstChild("Knife")
					if knife and knife:FindFirstChild("Stab") then
						knife.Stab:FireServer(false)
					end
				end
			end
		end))
	end
	
	task.spawn(function()
		while task.wait(1) and moduleOn do
			if autoKillAll.Checked then
				
				if plr and plr.Character then
					local knife = plr.Character:FindFirstChild("Knife")
					if knife then
						local handle = knife:FindFirstChild("Handle")
						if handle then
							for k,v in pairs(game.Players:GetPlayers()) do
								if v ~= plr and v.Character and not plr:IsFriendsWith(v.UserId) then
									local humanoid = v.Character:FindFirstChildWhichIsA("Humanoid")
									if humanoid and humanoid.RootPart and humanoid.Health > 0 then
										humanoid.RootPart.Anchored = true
										humanoid.RootPart.CFrame = CFrame.new(handle.Position)
									end
								end
							end
							task.wait(.33)
							for k,v in pairs(game.Players:GetPlayers()) do
								if v ~= plr and v.Character and not plr:IsFriendsWith(v.UserId) then
									local humanoid = v.Character:FindFirstChildWhichIsA("Humanoid")
									if humanoid and humanoid.RootPart and humanoid.Health > 0 then
										humanoid.RootPart.Anchored = false
									end
								end
							end
						end
					end
				end
				
			end
		end
	end)
	
	local songNames = {}

	local songs = GetDataRemote:InvokeServer("RadioSongs")
	for _,songData in pairs(songs) do
		songData.CustomDropdownDisplayName = songData.Name
	end
	
	local songSelector = category:AddDropdown("Selected Song", songs, 1)
	
	local playSongBtn = category:AddButton("Play Song", function()
		PlaySongRemote:FireServer(songSelector.SelectedOption.ID)
	end)
end

function module.Shutdown()
	moduleOn = false
end

return module