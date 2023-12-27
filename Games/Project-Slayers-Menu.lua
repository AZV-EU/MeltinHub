local module = {
	GameName = "Project Slayers - Menu",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local playerScripts = plr:WaitForChild("PlayerScripts")
local smallScripts = playerScripts:WaitForChild("Small_Scripts")

local function DestroyConnections(target)
	if not target then return end
	for k,v in pairs(getconnections(target.Changed)) do
		v:Disable()
	end
	for k,v in pairs(getconnections(target:GetPropertyChangedSignal("Parent"))) do
		v:Disable()
	end
	for k,v in pairs(getconnections(target:GetPropertyChangedSignal("Name"))) do
		v:Disable()
	end
	if target:IsA("LocalScript") then
		for k,v in pairs(getconnections(target:GetPropertyChangedSignal("Disabled"))) do
			v:Disable()
		end
	end
	return target
end

function module.Init(category, connections)
	do
		DestroyConnections(smallScripts:WaitForChild("Client_Global_utility")).Disabled = true
		
		for k,v in pairs(game.ReplicatedStorage:GetDescendants()) do
			DestroyConnections(v)
		end
		
		for k,v in pairs(getconnections(game.ReplicatedStorage:WaitForChild("PlayerValues"):WaitForChild(plr.Name).ChildRemoved)) do
			v:Disable()
		end
		
		local targets = {
			game.ReplicatedStorage:WaitForChild("fullnametangasddeletethisifuwanthackerlol"),
			game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("blockasodjasdn123"),
			game.ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("hackgamesystemasd123123"),
			game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("client_quest_add_check")
		}
		for k, t in pairs(targets) do
			if t then
				for k, v in pairs(getconnections(t.OnClientEvent)) do
					v:Disable()
				end
			end
		end
		
		--[[
		local pv = game.ReplicatedStorage.PlayerValues:WaitForChild(game.Players.LocalPlayer.Name);
		pv.ChildRemoved:Connect(function(p)
			if p.Name == "Blocking" then
				game.ReplicatedStorage.Remotes.To_Server.Handle_Initiate_S_:InvokeServer("remove_blocking", pv)
			end
		end)
		]]
		
		for k,v in pairs(plr.PlayerGui:GetDescendants()) do
			if v:IsA("LocalScript") and not v.Disabled then
				for x, c in pairs(getconnections(v.Changed)) do
					c:Disable()
				end
				v.Disabled = true
				v.Disabled = false
			end
		end
		
		local hg = game.ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("hackgamesystemasd123123")
		if hg then
			hg:Destroy()
		end
		
		_G.Notify("Anti-Cheats have been hijacked.", "Anti-Cheat Hijack")
	end
end

function module.Shutdown()
	
end

return module