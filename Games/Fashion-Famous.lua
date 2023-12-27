local module = {
	GameName = "Fashion Famous",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer
if not plr then return end
local mouse = plr:GetMouse()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local connections = {}
local rainbow = false

function module.Init(category)
	category:AddButton("Wear all hats", function()
		for k,v in pairs(game.Workspace:GetDescendants()) do
			if v:IsA("BasePart") and v.Name == "Hat" then
				game.ReplicatedStorage.RemoteEvent:FireServer("Hat", v)
			end
		end
	end)
	local rainbowBtn
	rainbowBtn = category:AddButton("Accessory Rainbow", function()
		if rainbow then
			rainbow = false
			rainbowBtn.Text = "Accessory Rainbow"
		else
			rainbow = true
			rainbowBtn.Text = "Stop Rainbow"
			_G.SenHub:Update()
			while rainbow and task.wait(.25) do
				for k,v in pairs(plr.Character:GetChildren()) do
					if v:IsA("Accessory") then
						game.ReplicatedStorage.RemoteEvent:FireServer(
							"ClothingColor",
							Color3.new(math.random(), math.random(), math.random()),
							v
						)
					end
				end
			end
		end
	end)
end

function module.Shutdown()
	for k,v in pairs(connections) do
		if v then
			v:Disconnect()
		end
	end
	rainbow = false
end

return module