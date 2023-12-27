local module = {}

local IsFlinging = false

local plr = game.Players.LocalPlayer
local bAngVel

local customPhysicalPropsDb = {}
local resetConn

function module.SetEnabled(state)
	if state and not IsFlinging then
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
					while IsFlinging do
						bAngVel.AngularVelocity = Vector3.new(0,99999,0)
						task.wait(.2)
						bAngVel.AngularVelocity = Vector3.new(0,0,0)
						task.wait(.1)
					end
				end)
				
				resetConn = human.Died:Connect(function()
					module.SetEnabled(false)
				end)
				
				IsFlinging = true
			end
		end
	elseif not state and IsFlinging then
		IsFlinging = false
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

return module