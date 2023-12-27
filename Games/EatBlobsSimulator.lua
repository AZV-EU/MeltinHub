local module = {
	GameName = "Eat Blobs Simulator",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer
if not plr then return module end

local moduleOn = true

local Orbs = game.Workspace:WaitForChild("Orbs")

function module.PreInit()
	
end

function module.Init(category, connections)
	local autoEat = category:AddCheckbox("Auto-eat mini orbs")
	spawn(function()
		local children
		while moduleOn and task.wait() do
			if autoEat.Checked then
				children = Orbs:GetChildren()
				if #children > 0 then
					_G.TouchObject(children[math.random(1, #children)])
				end
			end
		end
	end)
end

function module.Shutdown()
	moduleOn = false
end

return module