local module = {
	GameName = "Brookhaven",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer
local moduleOn = true

function module.PreInit()
	
end

function module.Init(category, connections)
	local lots = game.Workspace:WaitForChild("001_Lots")
	
	spawn(function()
		while moduleOn do
			for k,v in pairs(lots:GetChildren()) do
				local house = v:FindFirstChild("HousePickedByPlayer")
				if house then
					local model = house:FindFirstChild("HouseModel")
					if model then
						for k,v in pairs(model:GetChildren()) do
							if v:IsA("BasePart") and v.Name:find("BannedBlock") then
								v:Destroy()
							end
						end
					end
				end
			end
			task.wait(3)
		end
	end)
end

function module.Shutdown()
	moduleOn = false
end

return module