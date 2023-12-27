local module = {
	GameName = "Noob Army Tycoon 1",
	ModuleVersion = "1.0"
}

local moduleOn = true
local plr = game.Players.LocalPlayer

if not plr then return end

local Remotes = game.ReplicatedStorage:WaitForChild("Remotes")

local leaderstats = plr:WaitForChild("leaderstats")
local MyMoney = leaderstats:WaitForChild("Money")
local MyGems = leaderstats:WaitForChild("Gems")

local MyPets = plr:WaitForChild("Pets")

local MyInventory = plr:WaitForChild("Inventory")
local MyBloxyCrates = MyInventory:WaitForChild("Bloxy Cola Crate")

local Tycoons = game.Workspace:WaitForChild("Tycoons")
local MyTycoon
repeat
for k,v in pairs(Tycoons:GetChildren()) do
	if v:FindFirstChild("Owner") and v.Owner.Value == plr then
		MyTycoon = v
		break
	end
end
if not MyTycoon then wait(1) end
until MyTycoon ~= nil

local targetIndicator = Instance.new("Part")
targetIndicator.Shape = Enum.PartType.Cylinder
targetIndicator.Transparency = -3
targetIndicator.CanCollide = false
targetIndicator.Anchored = true
targetIndicator.Color = Color3.fromRGB(0, 255, 0)
targetIndicator.Material = Enum.Material.ForceField
targetIndicator.Size = Vector3.new(5, 40, 40)
local mesh = Instance.new("SpecialMesh")
mesh.MeshType = Enum.MeshType.Sphere
mesh.Parent = targetIndicator

local MySpawn = MyTycoon:WaitForChild("Model"):WaitForChild("SpawnLocation")

local Map = game.Workspace:WaitForChild("Map")
local Treasures = Map:WaitForChild("Treasures")
local Flowers = Map:WaitForChild("Flowers")

function module.PreInit()
	
end

function module.Init(category, connections)
	local MTGui = plr.PlayerGui:WaitForChild("MainTycoonGui")
	local othersButtons = MTGui:WaitForChild("OthersButtons")
	
	for k,v in pairs(game.Workspace:WaitForChild("Map"):WaitForChild("WaterParts"):GetChildren()) do
		if v:IsA("BasePart") then
			v.CanCollide = true
		end
	end
	
	do
		local bestPet, bestMoney = nil, 0
		for k,v in pairs(MyPets:GetChildren()) do
			local money = v:GetAttribute("Money")
			if not bestPet or not money or money > bestMoney then
				bestPet = v
				bestMoney = money
			end
		end
		if not bestPet then
			warn("Couldn't find best pet!")
		else
			print("Auto-equip best pet '", bestPet.Name, "'")
			Remotes:WaitForChild("EquipItem"):FireServer(
				"Pets",
				bestPet
			)
		end
	end
	
	
	do
		if othersButtons:FindFirstChild("Home") then
			othersButtons.Home:Destroy()
		end
		local homeButton = othersButtons:WaitForChild("Help"):Clone()
		homeButton.Name = "Home"
		homeButton.ImageLabel:Destroy()
		local homeText = Instance.new("TextLabel", homeButton)
		homeText.Text = "Home"
		homeText.TextScaled = true
		homeText.TextColor3 = Color3.new(1, 1, 1)
		homeText.BackgroundTransparency = 1
		homeText.Size = UDim2.fromScale(1, 1)
		homeText.Font = "Roboto"
		homeButton.Parent = othersButtons
		table.insert(connections, homeButton.MouseButton1Click:Connect(function()
			_G.TeleportPlayerTo(MySpawn.Position + Vector3.new(0, 5, 0))
		end))
	end
	
	local autocategory = _G.SenHub:AddCategory("Automation")
	
	local gamemodes = {}
	local autoVote = autocategory:AddCheckbox("Auto-vote")
	autoVote:SetChecked(true)
	
	local bloxyProx, bloxyColaTimer, autoBloxyCola
	local bloxyCrate = MyTycoon:WaitForChild("Models"):FindFirstChild("Bloxy Cola Crate", true)
	if bloxyCrate then
		bloxyProx = bloxyCrate.Parent:FindFirstChildWhichIsA("ProximityPrompt", true)
		bloxyColaTimer = MyTycoon:WaitForChild("Timers"):FindFirstChild("BloxyCola")
		if bloxyProx and bloxyColaTimer then
			autoBloxyCola = autocategory:AddCheckbox("Auto-BloxyCola")
		end
	end
	
	do
		local autoPotions, attackPotionSel, supportPotionSel
		local function ReplenishPotions()
			if not autoPotions.Checked then return end
			local originPos = plr.Character:GetPivot()
			local hasReplenished = false
			
			local function GrabPotion(potion)
				if not plr.Backpack:FindFirstChild(potion) then
					local target = MyTycoon.Models:FindFirstChild(potion)
					if target and target:FindFirstChild("Model") then
						local root = target.Model:FindFirstChild("Liquid")
						local prox = target.Model:FindFirstChildWhichIsA("ProximityPrompt", true)
						print(root, prox)
						if root and prox then
							repeat
								_G.TeleportPlayerTo(root.Position + Vector3.new(0, 5, 0))
								fireproximityprompt(prox, 1)
								wait(0.05)
							until not moduleOn or not autoPotions.Checked or plr.Backpack:FindFirstChild(potion) or plr.Character:FindFirstChild(potion)
							hasReplenished = true
						end
					end
				end
			end
			GrabPotion(attackPotionSel.SelectedOption)
			GrabPotion(supportPotionSel.SelectedOption)
			
			if hasReplenished then
				_G.TeleportPlayerTo(originPos)
			end
		end
		
		autoPotions = category:AddCheckbox("Auto-potions", function(state)
			attackPotionSel:SetVisible(state)
			supportPotionSel:SetVisible(state)
			if state then
				ReplenishPotions()
			end
		end)
		
		attackPotionSel = category:AddDropdown("Attack Potion",
			{"Damage Potion", "Poison Potion", "Zombie Potion", "Death Potion"}, 4, ReplenishPotions)
		attackPotionSel.Visible = false
		supportPotionSel = category:AddDropdown("Support Potion",
			{"Slow Heal Potion", "Heal Potion", "Forcefield Potion"}, 3, ReplenishPotions)
		supportPotionSel.Visible = false
		autoPotions:SetChecked(true)
		
		local function RemovalReplenish(tool)
			if tool == nil or tool.Parent == nil then
				ReplenishPotions()
			end
		end
		
		table.insert(connections, plr:WaitForChild("Backpack").ChildRemoved:Connect(RemovalReplenish))
		table.insert(connections, plr.CharacterAdded:Connect(function(chr)
			table.insert(connections, plr:WaitForChild("Backpack").ChildRemoved:Connect(RemovalReplenish))
			wait(1)
			if autoPotions.Checked then
				ReplenishPotions()
			end
		end))
	end
	local autoTreasures = autocategory:AddCheckbox("Auto-treasure")
	local autoFlowers = autocategory:AddCheckbox("Auto-flowers")
	local autoUpgradeWorkerPCs = autocategory:AddCheckbox("Auto-upgrade Workers' PCs")
	local autoUpgradeResearcherPCs = autocategory:AddCheckbox("Auto-upgrade Researchers' PCs")
	
	local function GetPCs(researchers)
		local sorted = {}
		local stats, price, level, pcproxAttach, pcprox
		for k,v in pairs(MyTycoon.Models:GetChildren()) do
			stats = v:FindFirstChild("Stats")
			if stats then
				if (researchers and stats:FindFirstChild("GiveResearch")) or
				   (not researchers and stats:FindFirstChild("GiveMoney")) then
					price = stats:FindFirstChild("Price")
					level = stats:FindFirstChild("NoobLevel")
					if price and level then
						pcproxAttach = v:FindFirstChild("ProximityPromptPCAttachment", true)
						if pcproxAttach then
							pcprox = pcproxAttach:FindFirstChildWhichIsA("ProximityPrompt")
							if pcprox and pcprox.Enabled then
								table.insert(sorted, {price = price.Value * (level.Value * 5), pcprox = pcprox, root = pcproxAttach.Parent})
							end
						end
					end
				end
			end
		end
		table.sort(sorted, function(a,b)
			return a.price < b.price
		end)
		return sorted
	end
	
	table.insert(connections, game.ReplicatedStorage:WaitForChild("Infos"):WaitForChild("Votes").Changed:Connect(function()
		wait(1)
		if autoVote.Checked then
			game:GetService("ReplicatedStorage").Remotes.VoteGamemode:FireServer(
				"King of the hill"
			)
		end
	end))
	
	do
		local cratescategory = _G.SenHub:AddCategory("Crates")
		
		local baseCrates = {}
		for k,v in pairs(game.ReplicatedStorage:WaitForChild("Crates"):GetChildren()) do
			local ct = "Pets"
			if v.Name:find("Hat") then
				ct = "Hats"
			elseif v.Name:find("Skin") then
				ct = "Skins"
			end
			table.insert(baseCrates, {ct = ct, name = v.Name})
		end
		local counts = {1, 5, 20}
		for k,v in pairs(baseCrates) do
			for _, cnt in pairs(counts) do
				cratescategory:AddButton(v.name .. " x" .. tostring(cnt), function()
					Remotes.OpenCrate:InvokeServer(
						v.ct,
						v.name,
						cnt
					)
				end)
			end
		end
	end
	
	spawn(function()
		while moduleOn and wait(3) do
			local startPos = plr.Character:GetPivot()
			local goBack = false
			if autoBloxyCola.Checked and bloxyColaTimer.Value <= 0 and MyBloxyCrates.Value > 0 then
				_G.TeleportPlayerTo(bloxyProx.Parent.Parent.Position + Vector3.new(0, 5, 0))
				wait(0.1)
				fireproximityprompt(bloxyProx, 1)
				goBack = true
			end
			if autoUpgradeWorkerPCs.Checked then
				local upgradeRun = true
				while upgradeRun and moduleOn and autoUpgradeWorkerPCs.Checked do
					upgradeRun = false
					for k,v in pairs(GetPCs()) do
						if v.price <= MyMoney.Value then
							_G.TeleportPlayerTo(v.root.Position + Vector3.new(0, 5, 0))
							wait(0.1)
							fireproximityprompt(v.pcprox, 0)
							goBack = true
							upgradeRun = true
						end
						break
					end
				end
			end
			if autoUpgradeResearcherPCs.Checked then
				local upgradeRun = true
				while upgradeRun and moduleOn and autoUpgradeResearcherPCs.Checked do
					upgradeRun = false
					for k,v in pairs(GetPCs(true)) do
						if v.price <= MyMoney.Value then
							_G.TeleportPlayerTo(v.root.Position + Vector3.new(0, 5, 0))
							wait(0.1)
							fireproximityprompt(v.pcprox, 0)
							goBack = true
							upgradeRun = true
						end
						break
					end
				end
			end
			if autoTreasures.Checked then
				local prox
				for k,v in pairs(Treasures:GetChildren()) do
					prox = v:FindFirstChildWhichIsA("ProximityPrompt")
					if prox then
						repeat
							_G.TeleportPlayerTo(v.Position + Vector3.new(0, 5, 0))
							fireproximityprompt(prox, 1)
							wait(0.05)
						until v == nil or v.Parent == nil or not moduleOn or not autoTreasures.Checked
						goBack = true
					end
					if not moduleOn or not autoTreasures.Checked then break end
				end
			end
			if autoFlowers.Checked then
				local stem, prox
				for k,v in pairs(Flowers:GetChildren()) do
					stem = v:FindFirstChild("Stem")
					if stem and stem:FindFirstChild("Attachment") then
						prox = stem.Attachment:FindFirstChildWhichIsA("ProximityPrompt")
						if prox then
							_G.TeleportPlayerTo(stem.Position + Vector3.new(0, 5, 0))
							wait(.1)
							fireproximityprompt(prox, 1)
							goBack = true
						end
					end
					if not moduleOn or not autoFlowers.Checked then break end
				end
			end
			if goBack then
				_G.TeleportPlayerTo(startPos)
			end
		end
	end)
end

function module.Shutdown()
	moduleOn = false
	if targetIndicator then
		targetIndicator:Destroy()
	end
end

return module