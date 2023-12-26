if _G.RBX_UNIVERSAL ~= nil then
	local f, err = pcall(_G.RBX_UNIVERSAL.Shutdown)
	if not f then
		warn(err)
	end
end

print("Starting RBX_UNIVERSAL")
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
		
		local FlyPos = game.Workspace.CurrentCamera.CFrame
		local FlyShift = Vector3.zero
		
		local speed = _G.RBX_UNIVERSAL.FlySpeed
		RunService:BindToRenderStep("unifly", Enum.RenderPriority.Camera.Value - 1, function(dt)
			if not human or not human.Parent or human.Health <= 0 or not game.Workspace.CurrentCamera then
				_G.RBX_UNIVERSAL:StopFlight()
				return
			end
			
			root.AssemblyLinearVelocity = Vector3.zero
			root.AssemblyAngularVelocity = Vector3.zero
			
			speed = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and _G.RBX_UNIVERSAL.FlySpeed * 100 or _G.RBX_UNIVERSAL.FlySpeed
			FlyShift = Vector3.zero
			
			if UserInputService:IsKeyDown(Enum.KeyCode.W) then
				FlyShift += Vector3.new(0, 0, speed * dt)
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then
				FlyShift += Vector3.new(0, 0, -speed * dt)
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then
				FlyShift += Vector3.new(-speed * dt, 0, 0)
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then
				FlyShift += Vector3.new(speed * dt, 0, 0)
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
				FlyShift += Vector3.new(0, speed * dt, 0)
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.C) then
				FlyShift += Vector3.new(0, -speed * dt, 0)
			end
			
			FlyPos = FlyPos + (game.Workspace.CurrentCamera.CFrame.LookVector * FlyShift)
			root.CFrame = CFrame.new(FlyPos, game.Workspace.CurrentCamera.CFrame.LookVector)
		end)
	end
	
	function _G.RBX_UNIVERSAL:StopFlight()
		if _G.RBX_UNIVERSAL.Flying then
			RunService:UnbindFromRenderStep("unifly")
			local human = _G.RBX_UNIVERSAL:GetMyHumanoid()
			--human.PlatformStand = false
			--human:ChangeState(
		end
	end
	
	ContextActionService:BindAction("unifly_bind", function() if _G.RBX_UNIVERSAL.Flying then _G.RBX_UNIVERSAL:StopFlight() else _G.RBX_UNIVERSAL:StartFlight() end end, true, Enum.KeyCode.LeftControl)
end

function _G.RBX_UNIVERSAL.Shutdown()
	print("RBX_UNIVERSAL Shutting down")
	
	_G.RBX_UNIVERSAL:StopFlight()
	ContextActionService:UnbindAction("unifly_bind")
end