local module = {
	GameName = "Armored Patrol",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer
local cam = game.Workspace.CurrentCamera
local mouse = plr:GetMouse()

local CONFIG_AIMBOT_RADIUS = 150

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local moduleOn = true

function module.PreInit()

end

local function getTarget()
	local closest, closestDist
	local sPos, dist
	local msPos = UserInputService:GetMouseLocation()
	for k,v in pairs(game.Players:GetPlayers()) do
		if v.Team ~= plr.Team and v.Character then
			sPos = cam:WorldToScreenPoint(v.Character:GetPivot().Position)
			dist = (Vector2.new(sPos.X, sPos.Y) - msPos).Magnitude
			if dist < CONFIG_AIMBOT_RADIUS then
				if not closest or dist < closestDist then
					closest = v.Character
					closestDist = dist
				end
			end
		end
	end
	return closest
end

function module.Init(category, connections)
	local currentBolt = plr:WaitForChild("CurrentBolt")

	local autoAim = category:AddCheckbox("Auto-aim freely")
	autoAim:SetChecked(true)
	
	--[[
	local args = {
		[1] = "b-down",
		[2] = Vector3.new(470.45318603515625, 100.0000228881836, 234.46066284179688),
		[3] = "50Cal"
	}

	game:GetService("Players").LocalPlayer.Character:FindFirstChild("Leopard1A3-v3.1").RigSvcsRE:FireServer(unpack(args))

	]]
	
	local weaponConn
	local function hijackTool(tool)
		if tool:IsA("Tool") then
			if tool.Name == "Control" then
				
				if weaponConn then
					weaponConn:Disconnect()
					weaponConn = nil
				end
				
				local los, part
				local target
				weaponConn = RunService.Stepped:Connect(function()
					if tool == nil or tool.Parent ~= plr.Character then
						weaponConn:Disconnect()
						return
					end
					
					
				end)
				table.insert(connections, weaponConn)
			end
		end
	end
	
	local function hijackTools(chr)
		table.insert(connections, chr.ChildAdded:Connect(hijackTool))
	end
	if plr.Character then
		hijackTools(plr.Character)
	end
	table.insert(connections, plr.CharacterAdded:Connect(hijackTools))
end

function module.Shutdown()
	moduleOn = false
end

return module