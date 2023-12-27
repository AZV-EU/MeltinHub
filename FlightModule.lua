local UserInputService = _G.SafeGetService("UserInputService")
local ContextActionService = _G.SafeGetService("ContextActionService")
local RunService = _G.SafeGetService("RunService")
local plr = game.Players.LocalPlayer
local cam = game.Workspace.CurrentCamera

local normalSpeed = 60
local slowSpeed = 20

local module = {
	Enabled = false,
	Fling = false,
	BoostSpeed = 120
}

local speed, moveShift = normalSpeed, Vector3.new()
local flying, multiplier = false, 1

local targetPos

local function GetTotalMass()
	local mass = 0
	for k,v in pairs(plr.Character:GetDescendants()) do
		if v:IsA("BasePart") then
			mass += v:GetMass()
		end
	end
	return mass
end

local respawnConn = nil, nil

local function resetFlight()
	if not plr.Character or not plr.Character.Parent then return end
	local myChar = plr.Character
	local myHuman = myChar:FindFirstChildWhichIsA("Humanoid")
	if not myHuman then return end
	
	RunService:UnbindFromRenderStep("flight")
	flying = false
	if myHuman and myHuman.RootPart ~= nil and myHuman.RootPart.Parent ~= nil then
		myHuman.PlatformStand = false
		local root = myHuman.RootPart
		root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
		myHuman:ChangeState(Enum.HumanoidStateType.GettingUp)
	end
end

local bAngVel

local customPhysicalPropsDb = {}
local resetConn

function module.SetFling(state)
	if state and not module.Fling then
		module.Fling = true
		if plr and plr.Character then
			local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
			if human and human.RootPart and human.RootPart.Parent then
				for k,v in pairs(plr.Character:GetDescendants()) do
					if v:IsA("BasePart") then
						customPhysicalPropsDb[v] = v.CustomPhysicalProperties
						v.CustomPhysicalProperties = PhysicalProperties.new(math.huge, 0.3, 0.5)
					end
				end
				task.wait(0.15) -- let server register new physical properties
				
				bAngVel = Instance.new("BodyAngularVelocity")
				bAngVel.Name = "1e02#lkre03EPAS"
				bAngVel.Parent = human.RootPart
				bAngVel.AngularVelocity = Vector3.new(0, 99999, 0)
				bAngVel.MaxTorque = Vector3.new(0, math.huge, 0)
				bAngVel.P = math.huge
				
				spawn(function()
					while module.Fling do
						bAngVel.AngularVelocity = Vector3.new(0,99999,0)
						task.wait(.2)
						bAngVel.AngularVelocity = Vector3.new(0,0,0)
						task.wait(.1)
					end
				end)
				
				resetConn = human.Died:Connect(function()
					module.SetEnabled(false)
				end)
				
				module.Fling = true
			end
		end
	elseif not state and module.Fling then
		module.Fling = false
		if bAngVel then
			bAngVel:Destroy()
		end
		if resetConn then
			resetConn:Disconnect()
		end
		if plr and plr.Character then
			local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
			if human and human.RootPart and human.RootPart.Parent then
				
				for k,v in pairs(plr.Character:GetDescendants()) do
					if v:IsA("BasePart") then
						v.Massless = false
						v.AssemblyLinearVelocity  = Vector3.new(0, 0, 0)
						v.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
					end
				end
				
				for k,v in pairs(plr.Character:GetDescendants()) do
					if v:IsA("BasePart") then
						if customPhysicalPropsDb[v] then
							v.CustomPhysicalProperties = customPhysicalPropsDb[v]
						else
							v.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
						end
					end
				end
				
			end
		end
		customPhysicalPropsDb = {}
	end
end

function module.SetEnabled(state)
	if state and not module.Enabled then
		module.Enabled = true
		ContextActionService:BindAction("FlightToggle", function(_, inputState)
			if not plr.Character or not plr.Character.Parent then return end
			local myChar = plr.Character
			local myHuman = myChar:FindFirstChildWhichIsA("Humanoid")
			if not myHuman then return end
			if myHuman.Health == 0 then return end
			if inputState ~= Enum.UserInputState.Begin then return end
			
			flying = not flying
			
			if flying and myHuman ~= nil and myHuman.RootPart ~= nil and myHuman.RootPart.Parent ~= nil then
				local root = myHuman.RootPart
				targetPos = root.Position
				RunService:BindToRenderStep("flight", Enum.RenderPriority.Camera.Value - 1, function(deltaTime)
					cam = game.Workspace.CurrentCamera
					root = myHuman.RootPart
					if root ~= nil then
						root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
						root.AssemblyAngularVelocity= Vector3.new(0, 0, 0)
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
						--[[
						if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
							moveShift = moveShift + Vector3.new(0, -1, 0)
						end
						]]
						
						targetPos = (CFrame.new(targetPos, targetPos + (cam.Focus.Position - cam.CFrame.Position).Unit) * CFrame.new(moveShift * (speed * deltaTime))).Position
						
						if module.Fling then
							for k,v in pairs(plr.Character:GetChildren()) do
								if v:IsA("BasePart") then
									v.CanCollide = false
									v.AssemblyLinearVelocity  = Vector3.new(0, 0, 0)
									v.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
								end
							end
						else
							for k,v in pairs(plr.Character:GetChildren()) do
								if v:IsA("BasePart") then
									v.AssemblyLinearVelocity  = Vector3.new(0, 0, 0)
									v.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
								end
							end
						end
						root.CFrame = CFrame.new(targetPos, targetPos + (cam.Focus.Position - cam.CFrame.Position).Unit)
					end
				end)
			else
				resetFlight()
			end
		end, false, Enum.KeyCode.LeftControl)
		
		respawnConn = plr.CharacterAdded:Connect(function()
			spawn(function()
				repeat plr.Character.ChildAdded:Wait() until plr.Character:FindFirstChildWhichIsA("Humanoid")
				local wasEnabled = module.Enabled
				module.SetEnabled(false)
				if wasEnabled then
					module.SetEnabled(wasEnabled)
				end
			end)
		end)
	elseif not state and module.Enabled then
		module.Enabled = false
		module.Fling = false
		resetFlight()
		ContextActionService:UnbindAction("FlightToggle")
		if respawnConn ~= nil then respawnConn:Disconnect() end
	end
end


return module