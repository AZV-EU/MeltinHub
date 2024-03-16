local module = {
	On = false
}

function module.Init(category, connections)
	local plr = game.Players.LocalPlayer
	local RE = ReplicatedStorage:WaitForChild("Event")
	
	local Setting = game.Workspace:WaitForChild("Setting")
	for _,v in pairs(Setting:WaitForChild("VisualScene"):GetChildren()) do
		if v.Name ~= "Water" then
			v:Destroy()
		end
	end
	
	for _,v in pairs(Setting:WaitForChild("SeaFloor"):GetChildren()) do
		v.CanTouch = false
	end
	
	_G.AIMBOT_AimFunc = nil
	_G.AIMBOT_CheckLoS = function(target)
		if target and target:FindFirstChild("Head") and plr:DistanceFromCharacter(target.Head.Position) <= 400 then
			return true, nil, target.Head
		end
	end
	
	do
		local targets
		_G.AIMBOT_GetTargets = function()
			targets = {}
			for _,v in pairs(game.Players:GetPlayers()) do
				if v ~= plr and v.Character and v.Character.Parent and not plr:IsFriendsWith(v.UserId) and
					_G.ESPModule_Database.Storages["Enemies"].Rule(v) then
					table.insert(targets, v.Character)
				end
			end
			return targets
		end
	end
	
	table.insert(connections, RunService.Stepped:Connect(function()
		if _G.AIMBOT_CurrentTarget then
			_G.MouseEmulator:TargetPart(_G.AIMBOT_CurrentTarget)
			_G.MouseEmulator:TakeMouseControl()
		else
			_G.MouseEmulator:FreeMouseControl()
		end
	end))
	
	category:AddButton("Teleport to Harbour", function()
		RE:FireServer("Teleport", {"Harbour", ""})
	end)
	
	do
		local tool, shooting = false
		table.insert(connections, UserInputService.InputBegan:Connect(function(input, gp)
			tool = plr.Character:FindFirstChildWhichIsA("Tool")
			if tool and not gp and input.UserInputType == Enum.UserInputType.MouseButton1 then
				shooting = true
				while task.wait(.1) and tool and shooting and module.On do
					tool:Activate()
				end
				shooting = false
			end
		end))
		table.insert(connections, UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				shooting = false
			end
		end))
	end
	
	local hijackedTools = {}
	local function setupWeapon(tool)
		if tool:IsA("Tool") and not hijackedTools[tools] then
			hijackedTools[tool] = true
			
			if tool.Name == "M1 Garand" then
				local ts = tool:FindFirstChild("TriggerScript")
				if ts then
					local funcs = getfunctions(ts)
					if #funcs == 0 then -- script not running, equip tool to force
						if plr.Character then
							local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
							if human then
								human:EquipTool(tool)
								task.wait(.5)
								funcs = getfunctions(ts)
							end
						end
					end
					for _,func in pairs(funcs) do
						for idx,upval in pairs(debug.getupvalues(func)) do
							if type(upval) == "function" and debug.getinfo(upval).name == "reload" then
								debug.setupvalue(func, idx, function() end)
							end
						end
						local constants = debug.getconstants(func)
						if #constants >= 44 and constants[15] == "shootRifle" then
							local override = {}
							function override:FireServer(...)
								local action = ...
								if _G.AIMBOT_CurrentTarget and action and action == "shootRifle" then
									RE:FireServer("shootRifle", "", {_G.AIMBOT_CurrentTarget})
									local human = _G.AIMBOT_CurrentTarget.Parent:FindFirstChild("Humanoid")
									if human then
										RE:FireServer("shootRifle", "hit", { human })
									end
									return
								end
								RE:FireServer(...)
							end
							local f, err = pcall(function()
								debug.setconstant(func, 44, 0)
								debug.setupvalue(func, 9, override)
							end)
							if not f then warn(err) end
						end
					end
				end
			end
		end
	end
	local function onRespawn(chr)
		hijackedTools = {}
		repeat task.wait() until chr.PrimaryPart
		task.wait(1)
		for _,v in pairs(plr.Backpack:GetChildren()) do
			setupWeapon(v)
		end
		for _,v in pairs(plr.Character:GetChildren()) do
			setupWeapon(v)
		end
	end
	onRespawn(plr.Character)
	table.insert(connections, plr.CharacterAdded:Connect(onRespawn))
end

function module.Shutdown()
end

return module