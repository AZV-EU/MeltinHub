local module = {
	GameName = "Evade",
	ModuleVersion = "1.0"
}


local plr = game.Players.LocalPlayer
--if not plr then return end

local espGui = Instance.new("BillboardGui")
espGui.Name = "esp_billboard"
espGui.AlwaysOnTop = true
espGui.Size = UDim2.new(0, 100, 0, 15)
espGui.ResetOnSpawn = false
espGui.LightInfluence = 0
espGui.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
do
	local tl = Instance.new("TextLabel", espGui)
	tl.BackgroundTransparency = 1
	tl.Size = UDim2.new(1, 0, 1, 0)
	tl.Font = Enum.Font.Roboto
	tl.TextScaled = true
	tl.TextColor3 = Color3.new(1, 1, 0)
	tl.TextStrokeTransparency = 0
end

local skullGui = espGui:Clone()
skullGui.Name = "skull_esp_billboard"
skullGui.Size = UDim2.fromOffset(60, 60)
skullGui.StudsOffsetWorldSpace = Vector3.new(0, 0, 0)
do
	skullGui.TextLabel:Destroy()
	local il = Instance.new("ImageLabel", skullGui)
	il.BackgroundTransparency = 1
	il.Size = UDim2.new(1, 0, 1, 0)
	il.ImageColor3 = Color3.new(1, 150/255, 150/255)
	il.Image = "rbxassetid://36697080"
end

local playersDir
function module.PreInit()
	_G.ESPModule_TargetAliveChangedSignal = function(target)
		if target then
			if target:IsA("Player") then
				repeat task.wait() until target.Character
				return target.Character:GetAttributeChangedSignal("Downed")
			else
				return target:GetAttributeChangedSignal("Downed")
			end
		end
	end
end

local instances = {}
local moduleOn = true
function module.Init(category, connections)
	local gameDir = game.Workspace:WaitForChild("Game")
	local boostCheckbox = category:AddCheckbox("Cola Boost!")
	boostCheckbox:SetChecked(true)
	
	local downedCheckbox = category:AddCheckbox("Anti-downed")
	downedCheckbox:SetChecked(true)
	
	local reviveTarget, reviveTime = nil, 0
	task.spawn(function()
		while moduleOn and task.wait(1) do
			
			for k,v in pairs(game.Players:GetPlayers()) do
				if v.Character then
					if v.Character:GetAttribute("Downed") and not v.Character:FindFirstChild("skull_esp_billboard") then
						local sg = skullGui:Clone()
						sg.Parent = v.Character
						sg.Adornee = v.Character
					elseif (not v.Character:GetAttribute("Downed") or v.Character:GetAttribute("FullyDowned")) and v.Character:FindFirstChild("skull_esp_billboard") then
						v.Character.skull_esp_billboard:Destroy()
					end
				end
			end
			
			if plr.Character then
				local stats = plr.Character:FindFirstChild("StatChanges")
				if stats then
					local speed = stats:FindFirstChild("Speed")
					if speed then
						if boostCheckbox.Checked then
							local boost = speed:FindFirstChild("ColaBoost") or Instance.new("NumberValue", speed)
							boost.Name = "ColaBoost"
							boost.Value = 1.8
						elseif downedCheckbox.Checked then
							local downed = speed:FindFirstChild("Downed")
							if downed then
								downed:Destroy()
							end
						end
					end
				end
			end
			
			local mapDir = gameDir:WaitForChild("Map")
			local partsDir = mapDir:WaitForChild("Parts")
			local objectivesDir = partsDir:FindFirstChild("Objectives")
			if objectivesDir then
				for k, objective in pairs(objectivesDir:GetChildren()) do
					if objective:IsA("Model") and objective.PrimaryPart and not objective:FindFirstChild("esp_billboard") then
						local guiEsp = espGui:Clone()
						guiEsp.Parent = objective
						guiEsp.TextLabel.Text = objective.Name
						guiEsp.Adornee = objective.PrimaryPart
						table.insert(instances, guiEsp)
					end
				end
			end
		end
	end)
	
	--[[
	playersDir = game.Workspace:WaitForChild("Game"):WaitForChild("Players")
	
	for k,v in pairs(getconnections(playersDir.ChildAdded)) do
		v:Disable()
	end
	for k,v in pairs(getconnections(playersDir.ChildRemoved)) do
		v:Disable()
	end
	
	local function characterEventOverride(newChar)
		if not newChar then return end
		local oldParent = newChar.Parent
		local conn
		conn = newChar:GetPropertyChangedSignal("Parent"):Connect(function()
			if newChar.Parent ~= nil and oldParent == nil then
				print(_G.Stringify(newChar), "added to", _G.Stringify(newChar.Parent))
				_G.IndexEmulator:SetKeyValue(newChar, "Parent", playersDir)
				firesignal(playersDir.ChildAdded, newChar)
			elseif newChar.Parent == nil and oldParent ~= nil then
				print(_G.Stringify(newChar), "removed from", _G.Stringify(oldParent))
				_G.IndexEmulator:DeleteObject(newChar)
				conn:Disconnect()
				firesignal(playersDir.ChildRemoved, newChar)
			else
				print(_G.Stringify(newChar), "moved to", _G.Stringify(newChar.Parent))
			end
			oldParent = newChar.Parent
		end)
		table.insert(connections, conn)
	end
	
	table.insert(connections, game.Players.PlayerAdded:Connect(function(player)
		repeat task.wait() until player.Character
		characterEventOverride(player.Character)
		table.insert(connections, player.CharacterAdded:Connect(characterEventOverride))
	end))
	
	local function getValidChars()
		local validChars = {}
		for k,v in pairs(game.Players:GetPlayers()) do
			if v.Character and v.Character.Parent ~= nil
				and v.Character:GetAttribute("Tag") ~= nil
				and v.Character:FindFirstChildWhichIsA("Humanoid") then
				table.insert(validChars, v.Character)
			end
		end
		return validChars
	end
	_G.MethodEmulator:SetMethodOverride(playersDir, "GetChildren", function(self, ...)
		return getValidChars()
	end)
	_G.MethodEmulator:SetMethodOverride(playersDir, "FindFirstChild", function(self, fallback, childName)
		for k,v in pairs(getValidChars()) do
			if v and v.Name == childName then
				return v
			end
		end
		return fallback(self, childName)
	end)
	_G.IndexEmulator:SetIndexer(playersDir, function(self, fallback, key)
		for k,v in pairs(getValidChars()) do
			if v and v.Name == key then
				return v
			end
		end
		return fallback(self, key)
	end)
	
	print("Successful Evade Players Override")
	]]
end

function module.Shutdown()
	moduleOn = false
	for k,v in pairs(instances) do
		v:Destroy()
	end
	--[[
	_G.IndexEmulator:DeleteObject(playersDir)
	
	for k,v in pairs(getconnections(playersDir.ChildAdded)) do
		v:Enable()
	end
	for k,v in pairs(getconnections(playersDir.ChildRemoved)) do
		v:Enable()
	end
	]]
end

return module