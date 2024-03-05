local module = {
	On = false
}

function module.PreInit()
	if not _G.SecurityBypass then
		_G.SecurityBypass = nil
		_G.SecurityBypass = hookmetamethod(game, "__namecall", function(self, ...)
			if not checkcaller() and self then
				if (self.Name == "" or self.Name == "RemoteEvent") and self.Parent.Name == "Security" and self.ClassName == "RemoteEvent" then
					return wait(9e9)
				end
			end
			return _G.SecurityBypass(self, ...)
		end)
	end
	print("Security bypass successful")
end

local indicator
function module.Init(category, connections)
	local plr = game.Players.LocalPlayer
	local RunService = _G.SafeGetService("RunService")
	local ReplicatedStorage = _G.SafeGetService("ReplicatedStorage")
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
	
	indicator = Drawing.new("Line")
	indicator.Transparency = 1
	indicator.Color = _G.COLOR3DEF.RED
	indicator.Visible = false
	
	
	local function Parry(ball)
		local old = _G.TeleportPlayerTo(ball.Position + Vector3.new(10, 0, 10))
		swordsController:Parry()
		task.wait()
		_G.TeleportPlayerTo(old)
	end
	
	do
		local dataPing = game.Stats.Network.ServerStatsItem["Data Ping"]
		local autoDeflect = category:AddCheckbox("Auto-deflect", function(state)
			if state then
				local ball, visual, dist, target, predict
				local icol = 0
				local posFrom, posTo, inBoundsFrom, inBoundsTo
				game:GetService("RunService"):BindToRenderStep("autodeflect",
					Enum.RenderPriority.Camera.Value - 5, function(dt)
					ball, visual = GetBalls()
					if ball and visual then
						target = game.Players:FindFirstChild(ball:GetAttribute("target"))
						if target and target.Character then
							posFrom, inBoundsFrom = game.Workspace.CurrentCamera:WorldToScreenPoint(visual.Position)
							posTo, inBoundsTo = game.Workspace.CurrentCamera:WorldToScreenPoint(target.Character:GetPivot().Position)
							
							indicator.From = Vector2.new(posFrom.X, posFrom.Y + 36)
							indicator.To = Vector2.new(posTo.X, posTo.Y + 36)
							indicator.Visible = inBoundsFrom and inBoundsTo
							
							dist = target:DistanceFromCharacter(ball.Position)
							
							icol = math.min(1, math.max(0, (dist-20)/100))
							
							indicator.Color = Color3.new(1-icol, icol, 0)
							
							predict = ball.AssemblyLinearVelocity.Magnitude
							predict = dist / (predict - predict * (dataPing:GetValue() * 0.001))
							if target == plr then
								if predict < .5 or predict > 9e9 and dist < 10 then
									--_G.TeleportPlayerTo(ball.CFrame.Position + Vector3.new(math.random(2,5),0,math.random(2,5)))
									swordsController:Parry()
								end
							end
						else
							indicator.Visible = false
						end
					else
						indicator.Visible = false
					end
				end)
			else
				pcall(function() game:GetService("RunService"):UnbindFromRenderStep("autodeflect") end)
				indicator.Visible = false
			end
		end)
		autoDeflect:SetChecked(true)
	end
end

function module.Shutdown()
	if indicator then
		indicator.Visible = false
		indicator:Remove()
	end
	pcall(function() game:GetService("RunService"):UnbindFromRenderStep("autodeflect") end)
end

return module