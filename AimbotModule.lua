local plr = game.Players.LocalPlayer

local module = {
	Enabled = false,
	Autofire = false,
	Mode = 2, -- [1: Unlimited] [2: FOV-Limited]
	FOV = 100 -- in pixels around cursor
}

local Mouse = plr:GetMouse()

function module.SetMode(mode)
	module.Mode = mode
end

_G.AIMBOT_FireFunc = nil -- should accept: from (vector3), to (vector3)
local defaultRaycastParams = RaycastParams.new()
defaultRaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
defaultRaycastParams.IgnoreWater = true
_G.AIMBOT_Raycast_GetFilterDescendantsInstances = function()
	return {game.Workspace.CurrentCamera, plr.Character}
end
_G.AIMBOT_Raycast = function(from, to)
	defaultRaycastParams.FilterDescendantsInstances = _G.AIMBOT_Raycast_GetFilterDescendantsInstances()
	return game.Workspace:Raycast(from, to, defaultRaycastParams)
end
_G.AIMBOT_CanUse = function()
	return plr.Character and plr.Character:FindFirstChildWhichIsA("Tool")
end

do
	--[[
	local targets
	_G.AIMBOT_GetTargets = function()
		targets = {}
		for _,v in pairs(game.Players:GetPlayers()) do
			if v ~= plr and v.Character and v.Character.Parent and not plr:IsFriendsWith(v.UserId) and
				_G.ESPModule_Database.Storages["Enemies"].Rule(v) then
				table.insert(targets, v.Character)
			end
		end
		return targets
	end
	]]
	_G.AIMBOT_GetTargets = nil
end

local function GetValidTargets()
	local valid = {}
	local human, head, castPoints, pos, inBounds, dist
	local mousePos = Vector2.new(Mouse.X, Mouse.Y)
	if _G.AIMBOT_GetTargets then
		for _,v in pairs(_G.AIMBOT_GetTargets()) do
			if not v:FindFirstChildWhichIsA("ForceField") then
				human = v:FindFirstChildWhichIsA("Humanoid")
				if human and human.Health > 0 and human.RootPart then
					pos, inBounds = game.Workspace.CurrentCamera:WorldToScreenPoint(human.RootPart.Position)
					dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
					if inBounds and (module.Mode == 1 or (module.Mode == 2 and dist < module.FOV)) then
						table.insert(valid, {v, human.RootPart.Position, dist, pos})
					end
				end
			end
		end
	else
		for _,v in pairs(game.Players:GetPlayers()) do
			if v ~= plr and v.Character and v.Character.Parent and not v.Character:FindFirstChildWhichIsA("ForceField") and not plr:IsFriendsWith(v.UserId) and
				_G.ESPModule_Database.Storages["Enemies"].Rule(v) then
				human = v.Character:FindFirstChildWhichIsA("Humanoid")
				if human and human.Health > 0 and human.RootPart then
					pos, inBounds = game.Workspace.CurrentCamera:WorldToScreenPoint(human.RootPart.Position)
					dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
					if inBounds and (module.Mode == 1 or (module.Mode == 2 and dist < module.FOV)) then
						table.insert(valid, {v, human.RootPart.Position, dist, pos})
					end
				end
			end
		end
	end
	table.sort(valid, function(a,b)
		return a[3] < b[3]
	end)
	return valid
end

_G.AIMBOT_GetCastParts = function(target)
	local human = target:FindFirstChildWhichIsA("Humanoid")
	if human then
		return {target:FindFirstChild("Head"), human.RootPart}
	end
	return {}
end

_G.AIMBOT_FireSource = function()
	if plr and plr.Character and plr.Character.PrimaryPart then
		return plr.Character.PrimaryPart.Position
	end
end

do
	local result, losDir, source
	_G.AIMBOT_CheckLoS = function(target)
		if not plr or not plr.Character then return end
		source = _G.AIMBOT_FireSource()
		if not source then return end
		for k,v in ipairs(_G.AIMBOT_GetCastParts(target)) do
			losDir = (v.Position - source)
			if losDir.Magnitude <= 1000 then
				result = _G.AIMBOT_Raycast(
					source,
					losDir.Unit * (losDir.Magnitude * 2))
				if not result or result.Instance == nil or result.Instance:IsDescendantOf(target) then
					return true, result, v
				end
			end
		end
	end
end

_G.AIMBOT_AimMethod = 1 -- 1: aim only while holding right-click, 2: always aim as long as there's a valid target
_G.AIMBOT_AimFunc = function()
	if _G.AIMBOT_CurrentTarget then
		game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, _G.AIMBOT_CurrentTarget.Position)
	end
end

_G.AIMBOT_CurrentTarget = nil
local fovCirc, fovLine
function module.SetEnabled(state)
	if state and not module.Enabled then
		fovCirc = Drawing.new("Circle")
		fovCirc.Transparency = 0.7
		fovCirc.Color = _G.COLOR3DEF.WHITE
		fovCirc.Visible = false
		
		fovLine = Drawing.new("Line")
		fovLine.Transparency = 0.5
		fovLine.Color = _G.COLOR3DEF.GREEN
		fovLine.Visible = false
		
		local cam, los, fovPos, pos, aimPos
		RunService:BindToRenderStep("_mh_ab",
		Enum.RenderPriority.Camera.Value - 10, function()
			cam = game.Workspace.CurrentCamera
			if _G.AIMBOT_CanUse() and cam and cam.CameraSubject then
				fovCirc.Radius = module.FOV
				fovPos = Vector2.new(Mouse.X, Mouse.Y + 36)
				fovCirc.Position = fovPos
				fovLine.From = fovPos
				fovCirc.Visible = module.Mode == 2
				for k,v in pairs(GetValidTargets()) do
					los, _, _G.AIMBOT_CurrentTarget = _G.AIMBOT_CheckLoS(v[1])
					if los then
						aimPos = cam:WorldToScreenPoint(_G.AIMBOT_CurrentTarget.Position)
						fovLine.To = Vector2.new(aimPos.X, aimPos.Y + 36)
						fovCirc.Color = _G.COLOR3DEF.GREEN
						fovLine.Visible = true
						if _G.AIMBOT_AimFunc and ((_G.AIMBOT_AimMethod == 1 and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)) or _G.AIMBOT_AimMethod == 2) then
							_G.AIMBOT_AimFunc()
						end
						if module.Autofire and _G.AIMBOT_FireFunc then
							_G.AIMBOT_FireFunc()
						end
						return
					end
				end
			else
				fovCirc.Visible = false
			end
			fovLine.Visible = false
			fovCirc.Color = _G.COLOR3DEF.WHITE
			_G.AIMBOT_CurrentTarget = nil
		end)
	elseif not state and module.Enabled then
		fovCirc.Visible = false
		fovLine.Visible = false
		fovCirc:Remove()
		fovLine:Remove()
		_G.AIMBOT_CurrentTarget = nil
		RunService:UnbindFromRenderStep("_mh_ab")
	end
	module.Enabled = state
end

function module.SetMode(mode)
	module.Mode = mode
end

function module.SetFOV(fov)
	module.FOV = fov
end

return module