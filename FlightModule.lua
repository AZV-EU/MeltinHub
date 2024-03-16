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

local respawnConn = nil
local function resetFlight()
	pcall(function() RunService:UnbindFromRenderStep("flight") end)
	flying = false
	
	if not plr.Character or not plr.Character.Parent then return end
	local myChar = plr.Character
	local myHuman = myChar:FindFirstChildWhichIsA("Humanoid")
	if not myHuman then return end
	
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
				bAngVel.AngularVelocity = Vector3.new(0, 99999, 0)
				bAngVel.MaxTorque = Vector3.new(0, math.huge, 0)
				bAngVel.P = math.huge
				bAngVel.Parent = human.RootPart
				
				spawn(function()
					while module.Fling do
						bAngVel.AngularVelocity = Vector3.new(0,99999,0)
						task.wait(.2)
						bAngVel.AngularVelocity = Vector3.new(0,0,0)
						task.wait(.1)
					end
				end)
				
				resetConn = human.Died:Once(function()
					module.SetFling(false)
					resetConn = nil
				end)
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
	if state and not module.Enabled and plr.Character then
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
				
				local ControlModule
				if plr:FindFirstChild("PlayerScripts") and plr.PlayerScripts:FindFirstChild("PlayerModule") and plr.PlayerScripts.PlayerModule:FindFirstChild("ControlModule") then
					ControlModule = require(plr.PlayerScripts.PlayerModule.ControlModule)
				end
				
				RunService:BindToRenderStep("flight", Enum.RenderPriority.Camera.Value - 1, function(dt)
					cam = game.Workspace.CurrentCamera
					root = myHuman.RootPart
					if root ~= nil then
						root.AssemblyLinearVelocity  = Vector3.zero
						root.AssemblyAngularVelocity = Vector3.zero
						moveShift = Vector3.zero
						
						speed = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and module.BoostSpeed or normalSpeed
						
						if ControlModule then
							moveShift = ControlModule:GetMoveVector() * speed
						else
							moveShift = human.MoveDirection * speed
						end
						if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
							moveShift += Vector3.new(0, speed, 0)
						end
						
						targetPos = (CFrame.new(targetPos, targetPos + cam.CFrame.LookVector) * CFrame.new(moveShift * dt)).Position
						
						root.CFrame = CFrame.new(targetPos, targetPos + cam.CFrame.LookVector)
						
						if module.Fling then
							for k,v in pairs(plr.Character:GetChildren()) do
								if v:IsA("BasePart") then
									v.CanCollide = false
									v.AssemblyLinearVelocity  = Vector3.zero
									v.AssemblyAngularVelocity = Vector3.zero
								end
							end
							root.CFrame = CFrame.new(targetPos, targetPos + cam.CFrame.LookVector)
						end
					end
				end)
			else
				resetFlight()
			end
		end, UserInputService.TouchEnabled, Enum.KeyCode.LeftControl, Enum.KeyCode.ButtonR2)
		if UserInputService.TouchEnabled then
			ContextActionService:SetTitle("FlightToggle", "Fly")
			ContextActionService:SetPosition("FlightToggle", UDim2.new(1, -150, 1, -100))
		end
		
		local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
		if human then
			respawnConn = human.Died:Once(function()
				resetFlight()
				respawnConn = nil
			end)
		end
	elseif not state and module.Enabled then
		module.Enabled = false
		module.SetFling(false)
		resetFlight()
		ContextActionService:UnbindAction("FlightToggle")
		if respawnConn then
			respawnConn:Disconnect()
			respawnConn = nil
		end
	end
end

return module