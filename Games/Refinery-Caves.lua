local module = {
	GameName = "Refinery Caves",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer

local moduleOn = true

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
	tl.TextColor3 = Color3.new(1, 1, 1)
	tl.TextStrokeTransparency = 0
end

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Modules = game.ReplicatedStorage:WaitForChild("Modules")
local PlotsModule = require(Modules:WaitForChild("Plots"))
local AncModule = require(Modules:WaitForChild("Anc"))

local Events = game.ReplicatedStorage:WaitForChild("Events")
local GrabRemote = Events:WaitForChild("Grab")
local UngrabRemote = Events:WaitForChild("Ungrab")

local WorldSpawn = game.Workspace:WaitForChild("WorldSpawn")
local Mineables = game.ReplicatedStorage:WaitForChild("Mineables")
local Grabables = game.Workspace:WaitForChild("Grabable")
local Trees = game.Workspace:WaitForChild("Trees")

local TierColors = {
	Special = Color3.new(1, 0, 1),
	Unknown = Color3.new(1, 1, 1),
	[0] = Color3.fromHex("#6E260E"), -- dirt
	[1] = Color3.new(0.3, 0.3, 0.3), -- stone
	[2] = Color3.fromHex("#A19D94"), -- iron
	[3] = Color3.fromHex("#B87333"), -- copper
	[4] = Color3.fromHex("#FFD700"), -- gold
	[5] = Color3.new(0.5, 0.75, 0.45), -- industrial
	[6] = Color3.fromHex("#294cff")
}

local Specials = {"Sunstone", "Morganite", "Astatine", "Tolmedit", "Moonstone", "Soulstone", "Cursed Pumpkin", "Fallen Crystal", "Candy Corn"}

local function IsAnchored(part)
    if not part or not part:IsA("BasePart") then return end
	local isAnchored = part.Anchored
	for k,v in pairs(part:GetConnectedParts()) do
		if v:IsA("BasePart") and v.Anchored then
			isAnchored = true
			break
		end
	end
	if isAnchored then
		for k,v in pairs(part:GetConnectedParts()) do
			if v:IsA("BasePart") and v:FindFirstChild("__ThatWeld") then
				return false
			end
		end
	end
	return isAnchored
end

local function Grab(object, pos, duration)
	if object == nil then warn("attempt to grab nil object") return end
	if type(object) == "table" and #object >= 1 then
		GrabRemote:InvokeServer(object[1], object)
		local hold = RunService.RenderStepped:Connect(function()
			for k, part in pairs(object) do
				part.Position = pos or plr.Character:GetPivot().Position + Vector3.new(0, 3, 0)
				part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
				part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			end
		end)
		task.wait(duration or 0.25)
		UngrabRemote:FireServer(object[1], false, object)
		task.wait(0.25)
		hold:Disconnect()
		for k, part in pairs(object) do
			part:BreakJoints()
			part.Anchored = false
			part.Locked = false
		end
	else
		GrabRemote:InvokeServer(object, {})
		local hold = RunService.RenderStepped:Connect(function()
			object.Position = pos or plr.Character:GetPivot().Position + Vector3.new(0, 3, 0)
			object.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			object.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
		end)
		task.wait(0.25)
		UngrabRemote:FireServer(object, false, {})
		task.wait(duration or 0.25)
		hold:Disconnect()
		if object ~= nil then
			object:BreakJoints()
			object.Anchored = false
			object.Locked = false
		end
	end
end

local function GetPlot()
	for k,v in pairs(game.Workspace.Plots:GetChildren()) do
		if v:FindFirstChild("Owner") and v.Owner.Value == plr then
			return v
		end
	end
end

local function GetClosestOreVein(maxDist, minTier)
	maxDist = maxDist or 600
	minTier = minTier or -1
	local oreStage, hasOres, mineable, config
	local closest, closestDist, dist
	for k,v in pairs(WorldSpawn:GetChildren()) do
		if v:IsA("Model") and v.PrimaryPart and v:FindFirstChild("Rock") and v:FindFirstChild("RockString") then
			oreStage = v.Rock:FindFirstChildWhichIsA("Model")
			if oreStage then
				hasOres = false
				for _,ore in pairs(oreStage:GetChildren()) do
					if ore:IsA("BasePart") and ore:FindFirstChild("PartInfo")
						and ore.PartInfo:FindFirstChild("Health") and ore.PartInfo.Health.Value > 0 then
						hasOres = true
						break
					end
				end
				if hasOres then
					mineable = Mineables:FindFirstChild(v.RockString.Value)
					if mineable then
						config = mineable:FindFirstChild("Configuration")
						if config and config:FindFirstChild("Tier") and config.Tier.Value >= minTier then
							dist = plr:DistanceFromCharacter(v.PrimaryPart.Position)
							if dist <= maxDist and (not closest or closestDist > dist) then
								closest = v
								closestDist = dist
							end
						end
					end
				end
			end
		end
	end
	return closest
end

function module.Init(category, connections)
	--[[
	PlotsModule.ItemOwned = function(player, object)
		if not player or not object then
			return
		end
		return true, AncModule(object, "Grabable", { "Vehicles", "Objects" })
	end
	print("Overriden item owned")
	]]
	
	local oresFilter
	local lavendarC3 = BrickColor.new("Lavendar").Color
	local function SetOresESP(state)
		oresFilter:SetVisible(state)
		for k,v in pairs(WorldSpawn:GetChildren()) do
			if v:IsA("Model") and v:FindFirstChild("RockString") then
				if state then
					local mineable = Mineables:FindFirstChild(v.RockString.Value)
					if mineable then
						local config = mineable:FindFirstChild("Configuration")
						if config and config:FindFirstChild("Tier") then
							if oresFilter.Checked and config.Tier.Value < 4 then
								if v:FindFirstChild("esp_billboard") then
									v.esp_billboard:Destroy()
								end
								continue
							end
							if not v:FindFirstChild("esp_billboard") then
								local esp = espGui:Clone()
								esp.Parent = v
								esp.Adornee = v.PrimaryPart
								esp.TextLabel.Text = v.RockString.Value .. " [" .. tostring(config.Tier.Value) .. "]"
								esp.TextLabel.TextColor3 = Specials[v.RockString.Value] and TierColors.Special or (TierColors[config.Tier.Value] or TierColors.Unknown)
							end
						end
					end
				elseif not state and v:FindFirstChild("esp_billboard") then
					v.esp_billboard:Destroy()
				end
			end
		end
		local interact, root
		for k,v in pairs(Trees:GetChildren()) do
			if v:IsA("Model") then
				root = v:FindFirstChild("Part")
				if root then
					interact = root:FindFirstChild("Interact")
					if interact then
						if not v:FindFirstChild("esp_billboard") then
							warn("FOUND PURPLE TREE")
							local esp = espGui:Clone()
							esp.Parent = v
							esp.Adornee = root
							esp.TextLabel.Text = "Purple Tree"
							esp.Size = UDim2.new(0, 150, 0, 30)
							esp.TextLabel.TextColor3 = lavendarC3
							esp.TextLabel.TextStrokeTransparency = 0.5
						end
						break
					end
				end
			end
		end
	end
	
	local oresESP = category:AddCheckbox("Ores ESP", SetOresESP)
	oresFilter = category:AddCheckbox("Only tier 4+", function() SetOresESP(oresESP.Checked) end)
	
	SetOresESP(false)
	--oresESP:SetChecked(true)
	
	local autoMineCheckbox = category:AddCheckbox("Automine closest", function(state)
		if state then
			_G.MouseEmulator:TakeMouseControl()
		else
			_G.MouseEmulator:FreeMouseControl()
		end
	end)
	spawn(function()
		local currentTool, human
		local closestOre, closestOreDist, dist
		local oreVein, oreVeinStage
		while task.wait(0.05) and moduleOn do
			if autoMineCheckbox.Checked and plr.Character then
				human = plr.Character:FindFirstChildWhichIsA("Humanoid")
				if human and human.Health <= 0 then
					autoMineCheckbox:SetChecked(false)
					continue
				end
				closestOre = nil
				currentTool = plr.Character:FindFirstChildWhichIsA("Tool")
				if currentTool and currentTool:FindFirstChild("RedOutline") then
					oreVein = GetClosestOreVein(300, oresFilter.Checked and 4 or -1)
					if oreVein then
						oreVeinStage = oreVein.Rock:FindFirstChildWhichIsA("Model")
						if oreVeinStage then
							for k,v in pairs(oreVeinStage:GetChildren()) do
								if v:IsA("BasePart") and v:FindFirstChild("PartInfo") and v.PartInfo:FindFirstChild("Health") and v.PartInfo.Health.Value > 0 then
									dist = plr:DistanceFromCharacter(v.Position)
									if not closestOre or closestOreDist > dist then
										closestOre = v
										closestOreDist = dist
									end
								end
							end
							if closestOre then
								if plr:DistanceFromCharacter(oreVein.PrimaryPart.Position) > 15 then
									_G.TeleportPlayerTo(plr.Character:GetPivot().Position + Vector3.new(0, 50, 0))
									_G.TeleportPlayerTo(oreVein.PrimaryPart.Position + Vector3.new(0, 10, 0))
								end
								_G.MouseEmulator:TargetPart(closestOre)
								currentTool:Activate()
							end
						end
					end
				end
			end
		end
	end)
	
	category:AddCheckbox("Permanent daytime", function(state)
		if state then
			_G.IndexEmulator:SetKeyValue(game.Workspace:WaitForChild("Cycle"):WaitForChild("Current"), "Value", 12)
		else
			_G.IndexEmulator:DeleteObject(game.Workspace:WaitForChild("Cycle"):WaitForChild("Current"))
		end
	end):SetChecked(true)
	
	category:AddButton("Tp to Base", function()
		_G.TeleportPlayerTo(GetPlot().Base.Position + Vector3.new(0, 3, 0))
	end).Inline = true
	
	do
		local popup = nil
		category:AddButton("Grab...", function()
			if popup then return end
			local myStuff = {}
			local grabbableName
			for k,v in pairs(Grabables:GetChildren()) do
				if not v:FindFirstChild("Shop")
					and v.PrimaryPart and not IsAnchored(v.PrimaryPart)
					and not v.PrimaryPart.Locked and (not v:FindFirstChild("Owner") or v.Owner.Value == plr) then
					grabbableName = v.Name
					if (grabbableName == "MaterialBox" or grabbableName == "MaterialPart")
						and v:FindFirstChild("Configuration") and v.Configuration:FindFirstChild("Data")
						and v.Configuration.Data:FindFirstChild("MatInd") then
						grabbableName = (grabbableName == "MaterialBox" and "Boxed " or "") .. v.Configuration.Data.MatInd.Value
					end
					if myStuff[grabbableName] then
						table.insert(myStuff[grabbableName], v.PrimaryPart)
					else
						myStuff[grabbableName] = {v.PrimaryPart}
					end
				end
			end
			
			local gridList = {}
			for k,v in pairs(myStuff) do
				gridList[k] = {
					Text = k .. " (" .. tostring(#v) .. ")",
					Color = v[1].Color
				}
			end
			_G.SenHub:CreatePopup("GridList", {
				Title = "Grab my stuff",
				List = gridList,
				UserChoice = function(indexes)
					if indexes[1] and indexes[1] ~= 0 and indexes[1] ~= nil then
						Grab(myStuff[indexes[1]])
					end
					popup = nil
				end
			})
		end)
	end
	
	do
		local popup = nil
		category:AddButton("Illegal Grab (shops)...", function()
			if popup then return end
			local myStuff = {}
			local grabbableName
			for k,v in pairs(Grabables:GetChildren()) do
				if v:FindFirstChild("Shop")
					and v.PrimaryPart and not IsAnchored(v.PrimaryPart)
					and not v.PrimaryPart.Locked and (not v:FindFirstChild("Owner") or v.Owner.Value == plr) then
					grabbableName = v.Name
					if (grabbableName == "MaterialBox" or grabbableName == "MaterialPart")
						and v:FindFirstChild("Configuration") and v.Configuration:FindFirstChild("Data")
						and v.Configuration.Data:FindFirstChild("MatInd") then
						grabbableName = (grabbableName == "MaterialBox" and "Boxed " or "") .. v.Configuration.Data.MatInd.Value
					end
					if myStuff[grabbableName] then
						table.insert(myStuff[grabbableName], v.PrimaryPart)
					else
						myStuff[grabbableName] = {v.PrimaryPart}
					end
				end
			end
			
			local gridList = {}
			for k,v in pairs(myStuff) do
				gridList[k] = {
					Text = k .. " (" .. tostring(#v) .. ")",
					Color = v[1].Color
				}
			end
			_G.SenHub:CreatePopup("GridList", {
				Title = "Grab my stuff",
				List = gridList,
				UserChoice = function(indexes)
					if indexes[1] and indexes[1] ~= 0 and indexes[1] ~= nil then
						Grab(myStuff[indexes[1]])
					end
					popup = nil
				end
			})
		end)
	end
	
	category:AddButton("Grab all your ores outside", function()
		local basePos = GetPlot().Base.Position
		local myOres = {}
		for k,v in pairs(Grabables:GetChildren()) do
			if v.Name == "MaterialPart" and v.PrimaryPart and not IsAnchored(v.PrimaryPart)
				and not v.PrimaryPart.Locked and v:FindFirstChild("Owner") and v.Owner.Value == plr
				and (v.PrimaryPart.Position - basePos).Magnitude >= 107 then
				table.insert(myOres, v.PrimaryPart)
			end
		end
		Grab(myOres)
	end)
	category:AddButton("Grab all your stuff outside", function()
		local basePos = GetPlot().Base.Position
		local myStuff = {}
		for k,v in pairs(Grabables:GetChildren()) do
			if v.Name ~= "MaterialPart" and v.PrimaryPart and not IsAnchored(v.PrimaryPart)
				and not v.PrimaryPart.Locked and v:FindFirstChild("Owner") and v.Owner.Value == plr
				and (v.PrimaryPart.Position - basePos).Magnitude >= 107 then
				table.insert(myStuff, v.PrimaryPart)
			end
		end
		Grab(myStuff)
	end)
	
	--[[
	category:AddButton("Grab other's stuff", function()
		for k,v in pairs(Grabables:GetChildren()) do
			if v:IsA("Model") and v.PrimaryPart and not IsAnchored(v.PrimaryPart) and not v.PrimaryPart.Locked and v:FindFirstChild("Owner") and v.Owner.Value ~= plr then
				Grab(v.PrimaryPart, plr.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
			end
		end
	end)
	]]
	
	do -- factory utilities
		local factoryCategory = _G.SenHub:AddCategory("Factory")
		
		do
			local popup = nil
			local smelting = false
			local smeltBtn = nil
			smeltBtn = factoryCategory:AddButton("Auto-smelt", function()
				if popup then return end
				if smelting then
					smelting = false
					return
				end
				smeltBtn:SetEnabled(false)
				
				local myPlot = GetPlot()
				local objects = myPlot:WaitForChild("Objects")
				
				local targetFurnace = objects:FindFirstChild("Atom-8 Furnace")
				if not targetFurnace
					or not targetFurnace:FindFirstChild("Refine")
					or not targetFurnace.Refine:FindFirstChild("Part") then
					return
				end
				local targetRefinePart = targetFurnace.Refine.Part
				
				local mySmeltables = {}
				for k,v in pairs(Grabables:GetChildren()) do
					if v.Name == "MaterialPart" and not v:FindFirstChild("Shop")
						and v.PrimaryPart and not IsAnchored(v.PrimaryPart)
						and not v.PrimaryPart.Locked and (not v:FindFirstChild("Owner") or v.Owner.Value == plr)
						and v:FindFirstChild("Configuration") and v.Configuration:FindFirstChild("Data")
						and v.Configuration.Data:FindFirstChild("MatInd") then
						if mySmeltables[v.Configuration.Data.MatInd.Value] then
							table.insert(mySmeltables[v.Configuration.Data.MatInd.Value], v.PrimaryPart)
						else
							mySmeltables[v.Configuration.Data.MatInd.Value] = {v.PrimaryPart}
						end
					end
				end
				
				local gridList = {}
				for k,v in pairs(mySmeltables) do
					gridList[k] = {
						Text = k .. " (" .. tostring(#v) .. ")",
						Color = v[1].Color
					}
				end
				_G.SenHub:CreatePopup("GridList", {
					Title = "Select ores to smelt",
					List = gridList,
					UserChoice = function(indexes)
						if indexes[1] and indexes[1] ~= 0 and indexes[1] ~= nil then
							smelting = true
							spawn(function()
								local parts = mySmeltables[indexes[1]]
								_G.TeleportPlayerTo(targetRefinePart.Position + Vector3.new(0, 5, 0))
								for i = 1, #parts do
									smeltBtn:SetText("Cancel Smelting [" .. tostring(i) .. " / " .. tostring(#parts) .. "]")
									if not moduleOn or not smelting then break end
									Grab(parts[i], (targetRefinePart.CFrame * CFrame.new(0, 0, -targetRefinePart.Size.Z/2)).Position)
									task.wait(0.5)
								end
								smeltBtn:SetText("Auto-smelt")
								smelting = false
							end)
						end
						smeltBtn:SetEnabled(true)
						popup = nil
					end
				})
			end)
		end
		
		do
			local popup = nil
			local building = false
			local buildBtn
			buildBtn = factoryCategory:AddButton("Auto-build", function()
				if popup then return end
				if building then
					building = false
					return
				end
				buildBtn:SetEnabled(false)
				
				local myPlot = GetPlot()
				local objects = myPlot:WaitForChild("Objects")
				
				local myBuildables = {}
				for k,v in pairs(Grabables:GetChildren()) do
					if v.Name == "MaterialPart" and not v:FindFirstChild("Shop")
						and v.PrimaryPart and not IsAnchored(v.PrimaryPart)
						and not v.PrimaryPart.Locked and (not v:FindFirstChild("Owner") or v.Owner.Value == plr)
						and v:FindFirstChild("Configuration") and v.Configuration:FindFirstChild("Data")
						and v.Configuration.Data:FindFirstChild("MatInd") then
						if myBuildables[v.Configuration.Data.MatInd.Value] then
							table.insert(myBuildables[v.Configuration.Data.MatInd.Value], v.PrimaryPart)
						else
							myBuildables[v.Configuration.Data.MatInd.Value] = {v.PrimaryPart}
						end
					end
				end
				
				local gridList = {}
				for k,v in pairs(myBuildables) do
					gridList[k] = {
						Text = k .. " (" .. tostring(#v) .. ")",
						Color = v[1].Color
					}
				end
				_G.SenHub:CreatePopup("GridList", {
					Title = "Select stuff to build blueprints with",
					List = gridList,
					UserChoice = function(indexes)
						if indexes[1] and indexes[1] ~= 0 and indexes[1] ~= nil then
							building = true
							spawn(function()
								local parts = myBuildables[indexes[1]]
								table.sort(parts, function(a, b) return a:GetMass() < b:GetMass() end)
								
								local blueprints = {}
								for k,v in pairs(GetPlot().Objects:GetChildren()) do
									if v:FindFirstChild("Blueprint") then
										table.insert(blueprints, v)
									end
								end
								table.sort(blueprints, function(a,b) return a.PrimaryPart:GetMass() < b.PrimaryPart:GetMass() end)
								--table.sort(blueprints, function(a,b) return a.PrimaryPart.Position.Y < b.PrimaryPart.Position.Y end)
								--table.sort(blueprints, function(a,b) return plr:DistanceFromCharacter(a.PrimaryPart.Position) < plr:DistanceFromCharacter(b.PrimaryPart.Position) end)
								
								local maxCount = math.min(#blueprints, #parts)
								local bpIndex = 1
								local i = 1
								while i < maxCount do
									buildBtn:SetText("Cancel building [" .. tostring(i) .. " / " .. tostring(maxCount) .. "]")
									if not moduleOn or not building then break end
									
									local blueprint = blueprints[bpIndex]
									local totalMass = 0
									for k,v in pairs(blueprint:GetChildren()) do
										if v:IsA("BasePart") and not v:FindFirstChild("ignore") then
											totalMass += v:GetMass()*1.5
										end
									end
									--print(blueprint.Name, totalMass, "mass")
									local startIndex = i
									local accumulatedMass = parts[i]:GetMass()
									while i < #parts and accumulatedMass < totalMass do
										i += 1
										accumulatedMass += parts[i]:GetMass()
									end
									--print("accumulated mass", accumulatedMass)
									--print("parts needed", (i - startIndex)+1)
									Grab({table.unpack(parts, startIndex, i)}, blueprint.PrimaryPart.Position, 0.75)
									bpIndex += 1
									i += 1
								end
								buildBtn:SetText("Auto-build")
								building = false
							end)
						end
						buildBtn:SetEnabled(true)
						popup = nil
					end
				})
			end)
		end
	end
	
	local function AntiOwoChan(chr)
		print("Anti-owo-channing character")
		chr:WaitForChild("OwoChan Character"):WaitForChild("Main").Disabled = true
		print("Disabling connections")
		--[[
		for k,v in pairs(getconnections(Grabables.ChildAdded)) do
			v:Disable()
		end
		for k,v in pairs(getconnections(chr:WaitForChild("Humanoid").Changed)) do
			v:Disable()
		end
		]]
	end
	
	AntiOwoChan(plr.Character)
	table.insert(connections, plr.CharacterAdded:Connect(AntiOwoChan))
	
	do
		_G.IndexEmulator:SetKeyValue(game.Workspace:WaitForChild("Raining"), "Value", false)
		_G.IndexEmulator:SetKeyValue(game.Workspace:WaitForChild("Foggy"), "Value", false)
	end
	
	spawn(function()
		while moduleOn and task.wait(5) do
			SetOresESP(oresESP.Checked)
		end
	end)
end

function module.Shutdown()
	moduleOn = false
	_G.IndexEmulator:DeleteObject(game.Workspace:WaitForChild("Cycle"):WaitForChild("Current"))
	_G.IndexEmulator:DeleteObject(game.Workspace:WaitForChild("Raining"))
	_G.IndexEmulator:DeleteObject(game.Workspace:WaitForChild("Foggy"))
end

return module