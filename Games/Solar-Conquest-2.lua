local module = {
	GameName = "Solar Conquest II",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local stats = game.Workspace:WaitForChild("PlayerStats")
local automine = false

function module.Init(category, connections)
	local myStats = stats:WaitForChild(plr.Name)
	local RUs = myStats:WaitForChild("RUs")
	local MaxRUs = myStats:WaitForChild("MaxRUs")
	
	do -- Resources
		local function GetBestResource()
			local best, highestValue = nil, 0
			for k,v in pairs(game.Workspace.Resources:GetChildren()) do
				if v:IsA("Model") then
					local resValue = v:FindFirstChild("ResourceValue")
					local resHealth = v:FindFirstChild("ResourceHealth")
					if resValue and resHealth and resHealth.Value > 0 then
						if not best or highestValue < resValue.Value then
							best = v:FindFirstChildWhichIsA("BasePart")
							highestValue = resValue.Value
						end
					end
				end
			end
			return best
		end
		
		local category = _G.SenHub:AddCategory("Resources")
		local automineCheck = category:AddCheckbox("Auto-mine: Standby")
		do
			local status, pick, handle, best
			table.insert(connections, RunService.Stepped:Connect(function()
				if automineCheck.Checked and RUs.Value < MaxRUs.Value then
					local pick = plr.Character:FindFirstChild("Pickaxe")
					if pick then
						local handle = pick:FindFirstChild("Handle")
						local best = GetBestResource()
						if handle and best then
							status = "Auto-mine: " .. tostring(best.Parent.Name) .. " (" .. tostring(best.Parent.ResourceHealth.Value) .. ")"
							plr.Character.HumanoidRootPart.CFrame = best.CFrame * CFrame.new(-1, 0, 1.5)
							pick:Activate()
						else
							status = "Auto-mine: No handle/best resource!"
						end
					else
						status = "Auto-mine: Select pickaxe"
					end
				else
					status = "Auto-mine: Standby"
				end
				automineCheck._GuiObject.Label.Text = status
			end))
		end
	end
end

function module.Shutdown()
	
end

return module