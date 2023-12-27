local module = {
	GameName = "Pizza Place",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer

function module.PreInit()

end

function module.Init(category, connections)
	local networkLib = require(game.ReplicatedStorage:WaitForChild("LibraryFolder"):WaitForChild("Network"))
	local gameService = game.Workspace:WaitForChild("GameService")
	local draggingStarted = gameService:WaitForChild("DraggingStarted")
	
	category:AddButton("Bring nearest supply boxes", function()
		for k,v in pairs(game.Workspace:WaitForChild("AllSupplyBoxes"):GetChildren()) do
			if v:IsA("BasePart") and v.Name == "SupplyBox" and v.CurrentDragger.Value == nil then
				draggingStarted:FireServer(v)
				task.wait(0.1)
				networkLib:FireServer("UpdateProperty", v, "Anchored", true)
				networkLib:FireServer("UpdateProperty", v, "CFrame", plr.Character:GetPivot() + Vector3.new(0, 5, 0))
				networkLib:FireServer("UpdateProperty", v, "Anchored", false)
			end
		end
	end)
end

function module.Shutdown()
	
end

return module