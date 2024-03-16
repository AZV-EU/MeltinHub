local module = {
	On = false
}

function module.Init(category, connections)
	local plr = game.Players.LocalPlayer
	
	
	
	do
		local handler, tool
		_G.ToolKillHandle = function(chr)
			handler = chr:FindFirstChild("MeleeWeaponHandler")
			if handler and handler:FindFirstChild("ToolName") then
				tool = chr:FindFirstChild(handler.ToolName.Value)
				if tool then
					return tool:FindFirstChild("MeleeHitBox")
				end
			end
		end
	end
	
	--[[
	local args = {
		[1] = game:GetService("Players").LocalPlayer.Character.Musket,
		[2] = game:GetService("Players").LocalPlayer.Character.FirearmHandler,
		[3] = workspace:WaitForChild("Map"):WaitForChild("Terrain"):WaitForChild("TerrainGroup"):WaitForChild("Triangles"):WaitForChild("Wedge"),
		[4] = Vector3.new(271.0729675292969, -0.49665045738220215, 0.7527389526367188),
		[5] = Vector3.new(-0.9977379441261292, -0.05475493147969246, -0.03899964690208435)
	}

	game:GetService("ReplicatedStorage"):WaitForChild("SelectiveReplication"):WaitForChild("InstanciateBulletImpact"):FireServer(unpack(args))

	]]
	
	local getFirearm
	do
		local handler
		getFirearm = function()
			if plr.Character then
				local handler = plr.Character:FindFirstChild("FirearmHandler")
				if handler and handler:FindFirstChild("ToolName") and plr.Character:FindFirstChild(handler.ToolName.Value) then
					return handler, plr.Character:FindFirstChild(handler.ToolName.Value)
				end
			end
		end
	end
	
	do
		_G.AIMBOT_CanUse = function()
			return getFirearm() ~= nil
		end
		
		_G.AIMBOT_AimFunc = nil
	end
end

function module.Shutdown()
	
end

return module