local module = {
	GameName = "generic roleplay gaem.",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local stats = plr:WaitForChild("stats")

local tools = {}
local connections

local function findNearestToMousePoint()
	local closest, closestDistance = nil, 0
	local mousePos = Vector2.new(mouse.X, mouse.Y)
	for k,v in pairs(game.Players:GetPlayers()) do
		if v ~= plr and v.Team ~= plr.Team and v.Character then
			local head = v.Character:FindFirstChild("Head")
			local humanoid = v.Character:FindFirstChild("Humanoid")
			if head and humanoid and humanoid.Health > 0 then
				local pos = game.Workspace.CurrentCamera:WorldToScreenPoint(head.Position)
				if pos.Z > 0 then
					local targetPos = Vector2.new(pos.X, pos.Y)
					local distance = (targetPos - mousePos).Magnitude
					if not closest or distance < closestDistance then
						closest = humanoid
						closestDistance = distance
					end
				end
			end
		end
	end
	return closest
end

local function HijackTool(tool, connections)
	if tool:IsA("Tool") and not tools[tool] then
		if tool.Name == "Bow" then
			tool:WaitForChild("ClientHandler").Disabled = true
			local remote = tool:WaitForChild("RemoteEvent")
			local handle = tool:WaitForChild("Handle")
			local fireSound = handle:FindFirstChild("FireSound")
			local fireCon
			table.insert(connections, tool.Equipped:Connect(function(ms)
				if fireCon then
					fireCon:Disconnect()
				end
				local reloading = false
				local targetHuman
				fireCon = RunService.RenderStepped:Connect(function()
					if not reloading and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
						targetHuman = findNearestToMousePoint()
						if targetHuman then
							reloading = true
							
							fireSound.Pitch = 0.8 + math.random() * 0.4;
							fireSound:Play();
							handle.Flash.Enabled = true;
							tool.Flare.MuzzleFlash.Enabled = true;
							if u11 then
								if 0 < u10 then
									u11:Play();
								end;
							end;
							handle.Smoke.Enabled = true;
							
							remote:FireServer("fire", (targetHuman.RootPart.Position - handle.Position).Unit, handle.Position);
							
							wait()
							tool.Flare.MuzzleFlash.Enabled = false;
							handle.Flash.Enabled = false;
							handle.Smoke.Enabled = false;
							
							remote:FireServer("reload")
							wait(1)
							reloading = false
						end
					end
				end)
				table.insert(connections, fireCon)
			end))
			table.insert(connections, tool.Unequipped:Connect(function()
				if fireCon then
					fireCon:Disconnect()
				end
			end))
		end
		_G.Notify("Overriden " .. tostring(tool.Name), "Hijacking")
		tools[tool] = true
	end
end

local autoSteal = false
local stealing = false
local stolenFood = 0

local supplies = game.Workspace:WaitForChild("FoodSupplies")
local barbSilo = supplies:WaitForChild("BarbSupply"):WaitForChild("Sign")
local townSilo = supplies:WaitForChild("TownSupply"):WaitForChild("Silo")

function module.Init(category, connections)
	table.insert(connections, RunService.RenderStepped:Connect(function()
		if plr and plr.Character then
			local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
			if human then
				human.WalkSpeed = 30
				local root = human.RootPart
				if root then
					if autoSteal then
						local tool = plr.Backpack:FindFirstChild("steal food")
						if tool then
							human:EquipTool(tool)
						else
							tool = plr.Character:FindFirstChild("steal food")
						end
						if stolenFood < 10 then
							root.CFrame = townSilo.CFrame
						else
							root.CFrame = barbSilo.CFrame
						end
						if not stealing then
							stealing = true
							if stolenFood == 0 or stolenFood >= 10 then
								wait(3)
							end
							if tool then
								tool:Activate()
								wait(2)
							end
							if stolenFood < 10 then
								stolenFood += 1
							else
								stolenFood = 0
							end
							stealing = false
						end
					else
						stealing = false
						stolenFood = 0
					end
				end
			end
		end
	end))
	for k,v in pairs(plr.Backpack:GetChildren()) do
		HijackTool(v, connections)
	end
	for k,v in pairs(plr.Character:GetChildren()) do
		HijackTool(v, connections)
	end
	table.insert(connections, plr.Backpack.ChildAdded:Connect(function(t)
		HijackTool(t, connections)
	end))
	for k,v in pairs(plr.PlayerScripts:GetChildren()) do
		if v:IsA("LocalScript") and v.Name == "" then
			v.Disabled = true
		end
	end
	
	local autoStealBtn
	autoStealBtn = category:AddCheckbox("Auto-steal", function(state)
		autoSteal = state
	end)
end

function module.Shutdown()
	
end

return module