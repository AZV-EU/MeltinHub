local module = {
	GameName = "Worm 2048",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer

local moduleOn = true

function module.PreInit()

end

function module.Init(category, connections)
	local autoCollect = category:AddCheckbox("Auto-Cubes")
	autoCollect.Inline = true
	local autoProps = category:AddCheckbox("Auto-Props")
	autoProps:SetChecked(true)
	local autoEat = category:AddCheckbox("Auto-Eat Players (!DANGER!)")
	
	spawn(function()
		while moduleOn and task.wait(.15) do
			if plr.Character then
				local human = plr.Character:FindFirstChildWhichIsA("Humanoid")
				if human and human.RootPart then
					local mySize = human.RootPart.Size.Magnitude
					if autoCollect.Checked then
						
						local biggest, biggestSize
						for k,v in pairs(game.Workspace.CubeFolder:GetDescendants()) do
							if v:IsA("BasePart") then
								cubeSize = v.Size.Magnitude
								if cubeSize <= mySize and (not biggest or cubeSize > biggestSize) then
									biggest = v
									biggestSize = cubeSize
								end
							end
						end
						if biggest then
							_G.TouchObject(biggest)
						end
					end
					if autoProps.Checked then
						for k,v in pairs(game.Workspace.PropsFolder.LUCK_BLOCK:GetChildren()) do
							if v:IsA("Model") and v.PrimaryPart then
								_G.TouchObject(v.PrimaryPart)
							end
						end
						--[[
						for k,v in pairs(game.Workspace.PropsFolder.SPEED_UP:GetChildren()) do
							if v:IsA("BasePart") then
								_G.TouchObject(v)
							end
						end
						]]
					end
					if autoEat.Checked then
						for k,v in pairs(game.Players:GetPlayers()) do
							if v.Character and v.Character:FindFirstChild("PlayerCubes") then
								local pHuman = v.Character:FindFirstChildWhichIsA("Humanoid")
								if pHuman and pHuman.RootPart then
									local eaten = false
									for k,v in pairs(v.Character.PlayerCubes:GetDescendants()) do
										if v:IsA("BasePart") and v.Size.Magnitude <= mySize then
											eaten = true
											_G.TouchObject(v)
											break
										end
									end
									if not eaten and pHuman.RootPart.Size.Magnitude <= mySize then
										_G.TouchObject(pHuman.RootPart)
									end
								end
							end
						end
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