local module = {
	GameName = "Tower of Hell",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer

function module.Init(category)
	if plr.PlayerScripts:FindFirstChild("LocalScript") then
		for k,v in pairs(getconnections(plr.PlayerScripts.LocalScript.Changed)) do
			v:Disable()
		end
		for k,v in pairs(getconnections(plr.PlayerScripts.LocalScript2.Changed)) do
			v:Disable()
		end
		plr.PlayerScripts.LocalScript:Destroy()
		plr.PlayerScripts.LocalScript2:Destroy()
		category:AddLabel("Anti-hack bypassed!")
	else
		category:AddLabel("Anti-hack already bypassed")
	end
end

function module.Shutdown()
	
end

return module