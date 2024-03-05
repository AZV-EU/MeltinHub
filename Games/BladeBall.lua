local module = {
	On = false
}

function module.PreInit()
	if not _G.SecurityBypass then
		--[[
		_G.SecurityBypass = nil
		_G.SecurityBypass = hookmetamethod(game, "__namecall", function(self, ...)
			if not checkcaller() and self then
				if (self.Name == "" or self.Name == "RemoteEvent") and self.ClassName == "RemoteEvent" and self.Parent.Name == "Security" then
					warn("intercepted security call")
					return wait(9e9)
				end
			end
			return _G.SecurityBypass(self, ...)
		end)
		]]
		local sec = ReplicatedStorage:FindFirstChild("Security")
		if sec then
			sec.RemoteEvent:Destroy()
			sec[""]:Destroy()
			sec:Destroy()
		end
		print("Security bypass successful")
	end
end

local indicator
function module.Init(category, connections)
	local plr = game.Players.LocalPlayer
	
	do
		local client = plr:WaitForChild("PlayerScripts"):WaitForChild("Client")
		if client:FindFirstChild("DeviceChecker") then
			client.DeviceChecker:Destroy()
		end
	end
	
	local balls = game.Workspace:WaitForChild("Balls")
	local aliveFolder = game.Workspace:WaitForChild("Alive")
	
	local Controllers = ReplicatedStorage:WaitForChild("Controllers")
	local Remotes = ReplicatedStorage:WaitForChild("Remotes")
	
	local swordsController = require(Controllers:WaitForChild("SwordsController"))
	
	do
		local GAC = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("GameAnalyticsSDK"):WaitForChild("GameAnalyticsClient")
		for k,v in pairs(getgc()) do
			if type(v) == "function" then
				local sc = getfenv(v).script
				if sc == GAC then
					for idx,constant in pairs(debug.getconstants(v)) do
						if constant == "GameAnalyticsError" then
							debug.setconstant(v,idx,"")
							print("GameAnalyticsError override at idx", idx)
							break
						end
					end
					break
				end
			end
		end
	end
	
	local function GetBalls()
		local real, visual
		for k,v in pairs(balls:GetChildren()) do
			if v:GetAttribute("realBall") then
				real = v
			else
				visual = v
			end
		end
		return real, visual
	end
	
	indicator = Instance.new("Part")
	indicator.Name = "indic"
	indicator.Transparency = 0.8
	indicator.Size = Vector3.new(5, 5, 5)
	indicator.Anchored = true
	indicator.CanCollide = false
	
	do
		local dataPing = game.Stats.Network.ServerStatsItem["Data Ping"]
		local deflectConn
		--local autoDeflectLabel = category:AddLabel("")
		local autoDeflect = category:AddCheckbox("Auto-deflect", function(state)
			if state then
				local ball, root, rootVel, ballVel, rootPos, ballPos, dist, predict
				deflectConn = RunService.Stepped:Connect(function(_, dt)
					if not swordsController._isParrying and not swordsController._parryCooldown then
						for _,ball in pairs(balls:GetChildren()) do
							if ball:GetAttribute("realBall") and not ball.Anchored and ball:GetAttribute("target") == plr.Name then
								ping = dataPing:GetValue() * 0.001
								
								root = plr.Character.HumanoidRootPart
								
								rootVel = root.AssemblyLinearVelocity * ping
								ballVel = ball.AssemblyLinearVelocity * ping
								
								rootPos = root.Position + rootVel
								ballPos = ball.Position + ballVel
								
								dist = (ballPos - rootPos).Magnitude
								
								predict = (ball.AssemblyLinearVelocity * .5):Dot((rootPos - ballPos).Unit)
								--autoDeflectLabel:SetText(string.format("%.1f", predict))
								if dist <= 15 or predict >= dist then
									swordsController:Parry()
								end
								break
							end
						end
					end
				end)
				table.insert(connections, deflectConn)
			elseif deflectConn then
				deflectConn:Disconnect()
				deflectConn = nil
			end
		end)
		autoDeflect:SetChecked(true)
	end
end

function module.Shutdown()
	if indicator then
		indicator:Destroy()
	end
end

return module