local module = {
	On = false
}

function module.PreInit()
end

local indicator
function module.Init(category, connections)
	local plr = game.Players.LocalPlayer
	
	do
		local sec = ReplicatedStorage:FindFirstChild("Security")
		if sec then
			sec.RemoteEvent:Destroy()
			sec[""]:Destroy()
			sec:Destroy()
		end
		
		local client = plr.PlayerScripts.Client
		if client:FindFirstChild("DeviceChecker") then
			client.DeviceChecker:Destroy()
		end
	end
	
	local isShiftlock = plr:WaitForChild("isShiftlock")
	table.insert(connections, isShiftlock:GetPropertyChangedSignal("Value"):Connect(function()
		isShiftlock.Value = false
	end))
	isShiftlock.Value = false
	
	local balls = game.Workspace:WaitForChild("Balls")
	local aliveFolder = game.Workspace:WaitForChild("Alive")
	
	local Controllers = ReplicatedStorage:WaitForChild("Controllers")
	local Remotes = ReplicatedStorage:WaitForChild("Remotes")
	
	local Remote = {
		RemoteEvent = ReplicatedStorage:WaitForChild("Remote"):WaitForChild("RemoteEvent"),
		RemoteFunction = ReplicatedStorage.Remote:WaitForChild("RemoteFunction")
	}
	
	local swordsController = require(Controllers:WaitForChild("SwordsController"))
	local analyticsController = require(Controllers:WaitForChild("AnalyticsController"))
	
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
	
	do --faster openings
		local openCrate = Remotes:WaitForChild("OpenCrate")
		local spinFinished = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.1.0"):WaitForChild("net"):WaitForChild("RE/SpinFinished")

		_G.DisableConnections(openCrate.OnClientEvent)
		table.insert(connections, openCrate.OnClientEvent:Connect(function(chestType, reward, skip)
			Remote.RemoteEvent:FireServer("OpeningCase", true)
			spinFinished:FireServer()
			Remote.RemoteEvent:FireServer("OpeningCase", false)
			_G.Notify(string.format("You received '%s'!", reward), string.format("Opening %s Crate", chestType))
		end))
	end
	
	do -- auto parry
		local dataPing = game.Stats.Network.ServerStatsItem["Data Ping"]
		--local autoDeflectLabel = category:AddLabel("")
		local parryResetConn
		local autoDeflect
		autoDeflect = category:AddCheckbox("Auto-parry", function(state)
			if state then
				local ball, root, rootVel, ballVel, rootPos, ballPos, dist, predict, velToPlayer
				local lastParried = 0
				parryResetConn = Remotes:WaitForChild("ParrySuccess").OnClientEvent:Connect(function()
					lastParried = tick() - .3
				end)
				table.insert(connections, parryResetConn)
				while autoDeflect.Checked and module.On and task.wait() do
					for _,ball in pairs(balls:GetChildren()) do
						if ball:GetAttribute("realBall") and not ball.Anchored and ball:GetAttribute("target") == plr.Name then
							ping = dataPing:GetValue() * 0.001
							
							root = plr.Character.HumanoidRootPart
							
							rootVel = root.AssemblyLinearVelocity * ping
							ballVel = ball.AssemblyLinearVelocity * ping
							
							rootPos = root.Position + rootVel
							ballPos = ball.Position + ballVel
							
							dist = (ballPos - rootPos).Magnitude
							
							predict = (ball.AssemblyLinearVelocity * .25).Magnitude
							velToPlayer = ball.AssemblyLinearVelocity:Dot(rootPos - ballPos)
							--autoDeflectLabel:SetText(string.format("%.1f", predict))
							tick() - lastParried >= .5
							if velToPlayer > 0 and (predict >= (dist - 10) or dist <= 15) then
								swordsController:Parry()
								--lastParried = tick()
								--task.wait()
							end
							break
						end
					end
				end
			elseif parryResetConn then
				parryResetConn:Disconnect()
				parryResetConn = nil
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