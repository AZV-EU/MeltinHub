local module = {
	GameName = "Naval Warfare",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer
if not plr then return module end
local mouse = plr:GetMouse()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local connections = {}
local tools = {}

local remote = game.ReplicatedStorage:WaitForChild("Event")

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

local function hijackTool(tool)
	if tool.Name == "M1 Garand" and not tools[tool] then
		warn("Hijacking M1 Garand")
		tool:WaitForChild("TriggerScript").Disabled = true
		local handle = tool:WaitForChild("Handle")
		local fireSound = handle:WaitForChild("FireSound")
		local muzzleFlash = tool:WaitForChild("Flare"):WaitForChild("MuzzleFlash")
		local equipped = false
		table.insert(connections, tool.Equipped:Connect(function()
			warn("Garand Equip")
			equipped = true
			UserInputService.InputBegan:Connect(function(input, gameProcessed)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					while wait(.1) and equipped and tools[tool] and
						UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
						
						fireSound:Play()
						muzzleFlash.Enabled = true
						local nearestHumanoid = findNearestToMousePoint()
						if nearestHumanoid then
							remote:FireServer("shootRifle", "", {nearestHumanoid.Parent:FindFirstChild("Head")})
						else
							remote:FireServer("shootRifle", "", {})
						end
						if nearestHumanoid then
							remote:FireServer("shootRifle", "hit", { nearestHumanoid })
						end
						muzzleFlash.Enabled = false
						
					end
				end
			end)
		end))
		table.insert(connections, tool.Unequipped:Connect(function()
			warn("Garand Unequip")
			equipped = false
		end))
		tools[tool] = true
	end
end

function module.Init(category)
	tools = {}
	table.insert(connections, plr.CharacterAdded:Connect(function()
		tools = {}
		for k,v in pairs(plr.Backpack:GetChildren()) do
			if v:IsA("Tool") then
				hijackTool(v)
			end
		end
	end))
	table.insert(connections, plr.Backpack.ChildAdded:Connect(function(tool)
		if tool:IsA("Tool") then
			hijackTool(tool)
		end
	end))
	for k,v in pairs(plr.Backpack:GetChildren()) do
		if v:IsA("Tool") then
			hijackTool(v)
		end
	end
end

function module.Shutdown()
	for k,v in pairs(connections) do
		if v then
			v:Disconnect()
		end
	end
	tools = {}
	RunService:UnbindFromRenderStep("autoaim")
end

return module