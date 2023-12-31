if _G.RBX_UNIVERSAL ~= nil then
	local f, err = pcall(_G.RBX_UNIVERSAL.Shutdown)
	if not f then
		warn(err)
	end
end

print("Starting RBX_UNIVERSAL 1.5.2")
_G.RBX_UNIVERSAL = {}

repeat task.wait() until game.Players.LocalPlayer ~= nil
local plr = game.Players.LocalPlayer

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")

function _G.RBX_UNIVERSAL:GetMyHumanoid()
	if plr and plr.Character then
		return plr.Character:FindFirstChildWhichIsA("Humanoid")
	end
end

do -- Flight
	_G.RBX_UNIVERSAL.Flying = false
	_G.RBX_UNIVERSAL.FlySpeed = 20
	function _G.RBX_UNIVERSAL:StartFlight()
		if _G.RBX_UNIVERSAL.Flying then return end
		
		local human = _G.RBX_UNIVERSAL:GetMyHumanoid()
		if not human then return end
		local root = human.RootPart
		if not root then return end
		
		--human.PlatformStand = true
		
		_G.RBX_UNIVERSAL.Flying = true
		
		local FlyPos = root.CFrame.Position
		local FlyShift = Vector3.zero
		
		local ControlModule
		if plr:FindFirstChild("PlayerScripts") and plr.PlayerScripts:FindFirstChild("PlayerModule") and plr.PlayerScripts.PlayerModule:FindFirstChild("ControlModule") then
			ControlModule = require(plr.PlayerScripts.PlayerModule.ControlModule)
		end
		
		local speed = _G.RBX_UNIVERSAL.FlySpeed
		RunService:BindToRenderStep("unifly", Enum.RenderPriority.Camera.Value - 1, function(dt)
			if not human or not human.Parent or human.Health <= 0 or not game.Workspace.CurrentCamera then
				_G.RBX_UNIVERSAL:StopFlight()
				return
			end
			
			root.AssemblyLinearVelocity = Vector3.zero
			root.AssemblyAngularVelocity = Vector3.zero
			
			speed = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and 100 or _G.RBX_UNIVERSAL.FlySpeed
			FlyShift = Vector3.zero
			
			if ControlModule then
				FlyShift = ControlModule:GetMoveVector() * speed
			else
				FlyShift = human.MoveDirection
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
				FlyShift += Vector3.new(0, speed, 0)
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.C) then
				FlyShift += Vector3.new(0, -speed, 0)
			end
			
			FlyPos = (CFrame.new(FlyPos, FlyPos + game.Workspace.CurrentCamera.CFrame.LookVector) * CFrame.new(FlyShift * dt)).Position
			root.CFrame = CFrame.new(FlyPos, FlyPos + game.Workspace.CurrentCamera.CFrame.LookVector)
		end)
	end
	
	function _G.RBX_UNIVERSAL:StopFlight()
		if _G.RBX_UNIVERSAL.Flying then
			RunService:UnbindFromRenderStep("unifly")
			local human = _G.RBX_UNIVERSAL:GetMyHumanoid()
			--human.PlatformStand = false
			--human:ChangeState(
			_G.RBX_UNIVERSAL.Flying = false
		end
	end
	
	function _G.RBX_UNIVERSAL.ToggleFlight(_, inputState)
		if inputState == Enum.UserInputState.Begin then
			if _G.RBX_UNIVERSAL.Flying then
				_G.RBX_UNIVERSAL:StopFlight()
			else
				_G.RBX_UNIVERSAL:StartFlight()
			end
		end
	end
	
	ContextActionService:BindAction("unifly_bind", _G.RBX_UNIVERSAL.ToggleFlight, true, Enum.KeyCode.LeftControl)
end

local espEnabled = true
do -- simple ESP
	function _G.RBX_UNIVERSAL:GetTeam(target)
		if target:IsA("Player") then
			return target.Team == plr.Team and 1 or -1
		else
			return 0
		end
	end
	
	local teams = game.Workspace:FindFirstChild("ESP_MODEL") or Instance.new("Model", game.Workspace)
	teams.Name = "ESP_MODEL"
	
	local enemies = teams:FindFirstChild("Enemies") or Instance.new("Model", teams)
	enemies.Name = "Enemies"
	local enemiesHighlight = enemies:FindFirstChild("Highlight") or Instance.new("Highlight", enemies)
	enemiesHighlight.FillColor = Color3.new(1, 0, 0)
	
	local friends = teams:FindFirstChild("Friends") or Instance.new("Model", teams)
	friends.Name = "Friends"
	local friendsHighlight = friends:FindFirstChild("Highlight") or Instance.new("Highlight", friends)
	friendsHighlight.FillColor = Color3.new(0, 1, 0)
	
	local neutral = teams:FindFirstChild("Enemies") or Instance.new("Model", teams)
	neutral.Name = "Enemies"
	local neutralHighlight = neutral:FindFirstChild("Highlight") or Instance.new("Highlight", neutral)
	neutralHighlight.FillColor = Color3.new(1, 1, 1)
	
	task.spawn(function()
		local target, teamid
		while task.wait(5) and espEnabled do
			for _,player in pairs(game.Players:GetPlayers()) do
				target = player.Character
				if target ~= plr then
					teamid = _G.RBX_UNIVERSAL:GetTeam(player)
					if teamid == 1 then
						target.Parent = friends
					elseif teamid == -1 then
						target.Parent = enemies
					else
						target.Parent = neutral
					end
				end
			end
		end
	end)
end

local antiAfkFunc
do -- anti afk
	local VU = game:GetService("VirtualUser")
	
	antiAfkFunc = plr.Idled:Connect(function()
		VU:CaptureController()
		VU:ClickButton2(Vector2.zero)
	end)
end

function _G.RBX_UNIVERSAL.Shutdown()
	print("RBX_UNIVERSAL Shutting down")
	
	_G.RBX_UNIVERSAL:StopFlight()
	ContextActionService:UnbindAction("unifly_bind")
	
	if antiAfkFunc then
		antiAfkFunc:Disconnect()
	end
	
	_G.RBX_UNIVERSAL = nil
	espEnabled = false
end