local module = {
	GameName = "Arsenal",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer

function module.PreInit()
	
end

function module.Init(category, connections)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.IgnoreWater = true
	_G.AIMBOT_Raycast = function(from, to)
		raycastParams.FilterDescendantsInstances = {
			game.Workspace.CurrentCamera,
			game.Workspace.Ray_Ignore,
			game.Workspace.Map.Ignore,
			game.Workspace.Map.Clips,
			plr.Character
		}
		return game.Workspace:Raycast(from, to, raycastParams)
	end
	
	_G.AIMBOT_CanUse = function()
		return plr.Character
	end
	
	do
		local result
		_G.ESPModule_IsTargetObscured = function(target)
			raycastParams.FilterDescendantsInstances = {
				game.Workspace.CurrentCamera,
				game.Workspace.Ray_Ignore,
				game.Workspace.Map.Ignore,
				game.Workspace.Map.Clips,
				plr.Character
			}
			local result = game.Workspace:Raycast(game.Workspace.CurrentCamera.CFrame, target.Position, raycastParams)
			return result and result.Instance and not result.Instance:IsDescendantOf(target)
		end
	end
	_G.MeltinHub_ValidAllyCheck = function(target)
		if target:IsA("Player") then
			return
				(plr:WaitForChild("Status"):WaitForChild("Team").Value ~= "" and
				target:WaitForChild("Status"):WaitForChild("Team").Value == plr.Status.Team.Value) or
				plr:IsFriendsWith(target.UserId)
		end
		return false
	end
	_G.ESPModule_TargetTeamChangedSignal = function(target)
		if target and target:IsA("Player") then
			return target:WaitForChild("Status"):WaitForChild("Team"):GetPropertyChangedSignal("Value")
		end
	end
	if not _G.PeskyHighlightFix then
		local storage = game.Workspace:FindFirstChild("_MH_ESPS")
		if not storage then warn("Couldn't apply Highlight fix: no storage") return end
		
		wait(5)
		local hls = {}
		for k,v in pairs(plr:WaitForChild("PlayerGui"):GetChildren()) do
			if v:IsA("Highlight") then
				v.Archivable = true
				v.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				v.Enabled = true
				v.FillTransparency = 0.5
				v.Name = "Highlight"
				v.OutlineTransparency = 0
				v.Adornee = nil
				table.insert(hls, v)
			end
		end
		
		local alliesStorage = storage:WaitForChild("Allies")
		alliesStorage:WaitForChild("Highlight"):Destroy()
		local allyHL = hls[3]
		allyHL.FillColor = Color3.new(0, 1, 0)
		allyHL.OutlineColor = Color3.new(0, 1, 0)
		allyHL.Adornee = alliesStorage
		allyHL.Parent = alliesStorage
		
		local enemiesStorage = storage:WaitForChild("Allies")
		enemiesStorage:WaitForChild("Highlight"):Destroy()
		local enemyHL = hls[2]
		enemyHL.FillColor = Color3.new(0, 1, 0)
		enemyHL.OutlineColor = Color3.new(0, 1, 0)
		enemyHL.Adornee = enemiesStorage
		enemyHL.Parent = enemiesStorage
		
		_G.PeskyHighlightFix = true
	end
end

function module.Shutdown()
	
end

return module