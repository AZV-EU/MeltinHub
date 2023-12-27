local module = {
	GameName = "Yeet A Friend",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer

function module.PreInit()

end

local RunService = game:GetService("RunService")

local moduleOn = true
function module.Init(category, connections)
	local pData = game.Workspace:WaitForChild("PlayerData"):FindFirstChild(plr.UserId)
	local autoCollect = category:AddCheckbox("Auto-collect")
	autoCollect:SetChecked(true)
	local collectRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Star"):WaitForChild("Server"):WaitForChild("Collect")
	
	local superForce = category:AddCheckbox("Superpower")
	superForce:SetChecked(true)
	
	local stopBtn = category:AddButton("Stop throw", function()
		local dummy = pData:FindFirstChild("Dummy")
		if dummy then
			local root = dummy:FindFirstChild("HumanoidRootPart")
			if root then
				local vecForce = root:FindFirstChild("VectorForce")
				if vecForce then
					root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
					vecForce.Enabled = true
					vecForce.Force = Vector3.new(0, -99999999, 0)
				end
			end
		end
	end)
	
	do
		local dummy, root, vecForce, myForce, downForce
		table.insert(connections, RunService.RenderStepped:Connect(function()
			dummy = pData:FindFirstChild("Dummy")
			if dummy then
				root = dummy:FindFirstChild("HumanoidRootPart")
				if root then
					vecForce = root:FindFirstChild("VectorForce")
					downForce = root:FindFirstChild("DownwardForce")
					myForce = root:FindFirstChild("SuperForce")
					if not myForce then
						myForce = Instance.new("VectorForce", root)
						myForce.Name = "SuperForce"
						myForce.ApplyAtCenterOfMass = true
						myForce.Attachment0 = root:FindFirstChild("VectorAttachment")
						myForce.Visible = false
						myForce.RelativeTo = Enum.ActuatorRelativeTo.World
					end
					
					--root.CFrame = CFrame.new(root.Position.X, 1000, 0)
					myForce.Force = Vector3.new((100000 - root.Velocity.X)*2, 1000, 0)
					myForce.Enabled = superForce.Checked
					vecForce.Enabled = not myForce.Enabled
					downForce.Enabled = not myForce.Enabled
					
					if vecForce then
						vecForce.Enabled = not superForce.Checked
					end
				end
			end
		end))
	end
	
	task.spawn(function()
		while moduleOn and task.wait(1) do
			if autoCollect.Checked then
				for k, v in pairs(game.Workspace:WaitForChild("Stars"):GetChildren()) do
					if v:IsA("Model") and v.PrimaryPart then
						collectRemote:FireServer(v.Name)
						v:Destroy()
					end
				end
			end
		end
	end)
end

function module.Shutdown()
	moduleOn = false
end

return module