local UserInputService = game:GetService("UserInputService")
local plr = game.Players.LocalPlayer
local cam = game.Workspace.CurrentCamera

local normalSpeed = 60
local slowSpeed = 20

local module = {
	Enabled = false,
	Fling = false,
	BoostSpeed = 120
}

local alignPosition = Instance.new("AlignPosition")
alignPosition.Enabled = false
alignPosition.ApplyAtCenterOfMass = true
alignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
alignPosition.RigidityEnabled = true

local alignOrientation = Instance.new("AlignOrientation")
alignOrientation.Enabled = false
alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
alignOrientation.RigidityEnabled = true

local angVel = Instance.new("AngularVelocity")
angVel.Enabled = false
angVel.MaxTorque = 9e9

local multiplier, speed, moveShift = 1, normalSpeed, Vector3.new()
local targetPos = Vector3.new()

local inputConn, resetConn = nil, nil
local function ResetFlight()
	flying = false
	alignPosition.Enabled = false
	alignOrientation.Enabled = false
	angVel.Enabled = false
	
	alignPosition.Parent = nil
	alignOrientation.Parent = nil
	angVel.Parent = nil
	
	game:GetService("RunService"):UnbindFromRenderStep("flight")
	if plr and plr.Character then
		local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
		if human then
			human:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	end
	module.Fling = false
	print("Stopped flight")
end

function module.SetFling(state)
	if state and not module.Fling then
		if plr and plr.Character then
			local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
			if human and human.RootPart then
				alignOrientation.Enabled = false
				angVel.Enabled = true
				module.Fling = true
			end
		end
	elseif not state and module.Fling then
		if plr and plr.Character then
			local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
			if human and human.RootPart then
				angVel.Enabled = false
				alignOrientation.Enabled = true
				module.Fling = false
			end
		end
	end
end

function module.SetEnabled(state)
	if state and not module.Enabled then
		module.Enabled = true
		inputConn = UserInputService.InputBegan:Connect(function(input)
			if not plr.Character or not plr.Character.Parent then return end
			local myChar = plr.Character
			local myHuman = myChar:FindFirstChildWhichIsA("Humanoid")
			if not myHuman then return end
			if myHuman.Health == 0 then return end
			
			if input.UserInputType == Enum.UserInputType.Keyboard then
				if input.KeyCode == Enum.KeyCode.LeftControl then
					flying = not flying
					
					if flying and myHuman ~= nil and myHuman.RootPart ~= nil and myHuman.RootPart.Parent ~= nil then
						local root = myHuman.RootPart
						local rootAttachment = root:FindFirstChild("RootAttachment") or Instance.new("Attachment", root)
						rootAttachment.Name = "RootAttachment"
						targetPos = root.Position
						
						alignPosition.Enabled = false
						alignOrientation.Enabled = false
						angVel.Enabled = false
						
						alignPosition.Parent = root
						alignOrientation.Parent = root
						angVel.Parent = root
						
						alignPosition.Attachment0 = rootAttachment
						alignOrientation.Attachment0 = rootAttachment
						angVel.Attachment0 = rootAttachment
						alignPosition.Enabled = true
						if not module.Fling then
							alignOrientation.Enabled = true
							angVel.Enabled = false
						else
							alignOrientation.Enabled = false
							angVel.Enabled = true
						end
						
						game:GetService("RunService"):BindToRenderStep("flight", Enum.RenderPriority.Camera.Value - 1, function(deltaTime)
							cam = game.Workspace.CurrentCamera
							root = myHuman.RootPart
							if root ~= nil and root.Parent ~= nil then
								--root.AssemblyLinearVelocity  = Vector3.new(0, 0, 0)
								--root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
								moveShift = Vector3.new()
								speed = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and module.BoostSpeed or normalSpeed --[[(
									UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and slowSpeed or normalSpeed
								)]]
								if UserInputService:IsKeyDown(Enum.KeyCode.W) then
									moveShift = moveShift + Vector3.new(0, 0, -1)
								end
								if UserInputService:IsKeyDown(Enum.KeyCode.S) then
									moveShift = moveShift + Vector3.new(0, 0, 1)
								end
								if UserInputService:IsKeyDown(Enum.KeyCode.A) then
									moveShift = moveShift + Vector3.new(-1, 0, 0)
								end
								if UserInputService:IsKeyDown(Enum.KeyCode.D) then
									moveShift = moveShift + Vector3.new(1, 0, 0)
								end
								if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
									moveShift = moveShift + Vector3.new(0, 1, 0)
								end
								
								targetPos = (CFrame.new(targetPos, targetPos + (cam.Focus.Position - cam.CFrame.Position).Unit) *
									CFrame.new(moveShift * (speed * deltaTime))).Position
								
								alignPosition.Position = targetPos
								alignOrientation.CFrame = CFrame.new(targetPos, targetPos + (cam.Focus.Position - cam.CFrame.Position).Unit)
							else
								ResetFlight()
							end
						end)
					else
						ResetFlight()
					end
				end
			end
		end)
		
		respawnConn = plr.CharacterAdded:Connect(function()
			ResetFlight()
		end)
	elseif not state and module.Enabled then
		ResetFlight()
		module.Enabled = false
		if inputConn then inputConn:Disconnect() end
		if respawnConn then respawnConn:Disconnect() end
	end
end

return module