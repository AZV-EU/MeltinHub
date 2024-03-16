local module = {
	On = false
}

function module.Init(category, connections)
	local plr = game.Players.LocalPlayer
	local RE = ReplicatedStorage:WaitForChild("Event")
	
	_G.AIMBOT_LoSMaxDistance = 400
	
	_G.AIMBOT_AimFunc = nil
	
	_G.MethodEmulator:SetMethodOverride(RE, "FireServer", function(self, orig, ...)
		local msgType, isHit, whatHit = ...
		if _G.AIMBOT_CurrentTarget and msgType and msgType == "shootRifle" then
			return orig(self, "shootRifle", "hit", {_G.AIMBOT_CurrentTarget})
		end
		return orig(self, ...)
	end)
	
	category:AddButton("Teleport to Harbour", function()
		RE:FireServer("Teleport", {"Harbour", ""})
	end)
	
	do
		local tool, shooting = false
		table.insert(connections, UserInputService.InputBegan:Connect(function(input, gp)
			tool = plr.Character:FindFirstChildWhichIsA("Tool")
			if tool and not gp and input.UserInputType == Enum.UserInputType.MouseButton1 then
				shooting = true
				while task.wait(.2) and tool and shooting and module.On do
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
							debug.setconstant(shootFunc, 44, 0)
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