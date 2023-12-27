local module = {
	GameName = "Speed Runner!",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer
local moduleOn = true

function module.PreInit()
	
end

function module.Init(category, connections)
	local collectRing = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Gameplay"):WaitForChild("CollectRing")
	
	task.spawn(function()
		while moduleOn and task.wait(1) do
			for k,v in pairs(game.Workspace:WaitForChild("ActiveStages"):GetChildren()) do
				if v:IsA("Model") and v:FindFirstChild("Rings") then
					for _, ring in pairs(v.Rings:GetChildren()) do
						if ring:IsA("Model") and ring:FindFirstChild("Ring") and ring.Ring.Transparency ~= 1 then
							collectRing:InvokeServer(ring)
							ring:Destroy()
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