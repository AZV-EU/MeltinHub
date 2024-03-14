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
end

function module.Shutdown()
	
end

return module