local module = {
	GameName = "Pet Simulator X",
	ModuleVersion = "1.0"
}

--[[
local xp = 100
local total = xp
local startLevel = 75
local maxLevel = 99
local xpPer = 2300*6
local timeNeeded = (30*0.9)*60

for i = 1, startLevel-1 do
    xp = xp + 200
end

for i = startLevel, maxLevel do
	xp = xp + 200
	warn("Xp for lvl " .. tostring(i) .. " = " .. tostring(xp))
	total = xp + xp
end

warn("Total xp needed: " .. tostring(total))
local interactions = math.ceil(total / xpPer)
warn("Total interactions needed: " .. tostring(interactions))
local t = interactions * timeNeeded
warn("Time total: " .. tostring(t) .. " seconds or " .. tostring(math.floor(t/60)) .. " minutes")
]]

local plr = game.Players.LocalPlayer
local connections = {}

local Lib = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))

repeat
	wait(.1)
until Lib.Loaded

local PetsFolder = game.Workspace:WaitForChild("__THINGS"):WaitForChild("Pets")
local CoinsFolder = game.Workspace:WaitForChild("__THINGS"):WaitForChild("Coins")
local OrbsFolder = game.Workspace:WaitForChild("__THINGS"):WaitForChild("Orbs")
local LootbagsFolder = game.Workspace:WaitForChild("__THINGS"):WaitForChild("Lootbags")

local Remotes = game.Workspace:WaitForChild("__THINGS"):WaitForChild("__REMOTES")

local areas = {}
for k,v in pairs(Lib.Directory.Areas) do
	table.insert(areas, v)
end
table.sort(areas, function(a, b)
	return a.world:lower() < b.world:lower()
end)
local worlds = Lib.Directory.Worlds

local AutoFarmRangeIndicator = Instance.new("Part")
AutoFarmRangeIndicator.Anchored = true
AutoFarmRangeIndicator.CanCollide = false
AutoFarmRangeIndicator.Material = Enum.Material.SmoothPlastic
AutoFarmRangeIndicator.Shape = Enum.PartType.Cylinder
AutoFarmRangeIndicator.Color = Color3.new(10, 190, 50)
AutoFarmRangeIndicator.Transparency = 0.8

local Enabled = true
local buyingEggs = false
local autoEnchanting = false

local function CollectAllOrbs()
	local orbIds = {}
	for k,v in pairs(OrbsFolder:GetChildren()) do
		table.insert(orbIds, v.Name)
	end
	coroutine.wrap(function()
		Lib.Network.Fire("Claim Orbs", orbIds)
	end)()
end

local function CollectAllLootbags()
	for k,v in pairs(LootbagsFolder:GetChildren()) do
		if not v:GetAttribute("Collected") then
			v:SetAttribute("Collected", true)
			if v:GetAttribute("IsBoost") then
				Lib.Signal.Fire("Rewards Redeemed", { { v:GetAttribute("BoostType"), (v:GetAttribute("BoostAmount")) } })
			end
			Lib.Network.Fire("Collect Lootbag", v:GetAttribute("ID"), v.CFrame.Position)
			game:GetService("Debris"):AddItem(v, 1)
		end
		--CollectLootbagsRemote:FireServer({v.Name, v.Position})
	end
end

local function GetPetsDisplayList(targetPlayer)
	local pets = {}
	local resultList = {}
	for k,v in pairs(Lib.Save.Get(targetPlayer).Pets) do
		if not v.e then
			table.insert(pets, v)
		end
	end
	table.sort(pets, function(a, b)
		return a.s > b.s
	end)
	for k,v in ipairs(Lib.PetCmds.GetEquipped(targetPlayer)) do
		table.insert(pets, k, v)
	end
	for k,v in ipairs(pets) do
		local petClassInfo = Lib.Directory.Pets[v.id]
		local petStrengthRatio = (v.s - petClassInfo.strengthMin) / (petClassInfo.strengthMax - petClassInfo.strengthMin)
		local petType = v.dm and "Dm " or
						(v.r and "Rb " or
						(v.g and "Gold " or ""))
		table.insert(resultList,
		{
			Text = petType .. petClassInfo.name .. ' "' .. v.nk .. '"' .. "\n" .. tostring(Lib.Functions.NumberShorten(v.s)),
			Image = v.dm and petClassInfo.darkMatterThumbnail or ( v.g and petClassInfo.goldenThumbnail or petClassInfo.thumbnail ),
			Color = petClassInfo.isPremium and Color3.new(0.5, 0, 1) or 
				(petClassInfo.rarity == "Rare" and Color3.new(0, 0.9, 0.1) or
				(petClassInfo.rarity == "Epic" and Color3.new(1, 1, 0) or
				(petClassInfo.rarity == "Legendary" and Color3.new(1, 0, 0.5) or
				(petClassInfo.rarity == "Mythical" and Color3.new(1, 0, 0) or Color3.new(1, 1, 1) )))),
			PetData = {PetInfo = v, PetClass = petClassInfo}
		})
	end
	return resultList
end

function module.Init(category)
	do -- Main Category
		local function showMenu(menuName)
			if plr:FindFirstChild("PlayerGui") and
				plr.PlayerGui:FindFirstChild(menuName) then
				Lib.Variables.UsingMachine = false
				plr.PlayerGui[menuName].Enabled = true
			end
		end
		
		category:AddButton("Fuse Pets", function()
			showMenu("FusePets")
		end)
		
		category:AddButton("Golden Machine", function()
			showMenu("Golden")
		end)
		
		category:AddButton("Rainbow Machine", function()
			showMenu("Rainbow")
		end)
		
		category:AddButton("Dark Matter Machine", function()
			showMenu("DarkMatter")
		end)
		
		category:AddButton("Pets Enchantments", function()
			showMenu("EnchantPets")
		end)
		
		category:AddButton("Bank Menu", function()
			showMenu("Bank")
		end)
		
		category:AddButton("Merchant Menu", function()
			showMenu("Merchant")
		end)
		
		do
			local playerSelectionPopup
			local peekPPBtn
			local function UpdatePlayersList()
				if playerSelectionPopup then
					local list = {}
					for k,v in pairs(game.Players:GetPlayers()) do
						if v ~= plr then
							list[v] = {
								Text = v.DisplayName .. "\n(@" .. v.Name .. ")",
								Image = function()
									return game.Players:GetUserThumbnailAsync(v.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size180x180)
								end,
								Color = v.TeamColor.Color
							}
						end
					end
					playerSelectionPopup.UpdateList(list)
				end
				peekPPBtn.Text = targetPlayer and targetPlayer.DisplayName or "Peek Player Pets"
			end
			
			local instaCancelbtn
			local currentTrade = nil
			table.insert(connections, Lib.Network.Fired("Init Trade"):Connect(function(tradeId)
				currentTrade = tradeId
				warn("New trade!")
			end))
			local function TradeEnded()
				currentTrade = nil
				warn("Trade ended")
			end
			instaCancelbtn = category:AddButton("Cancel Trade", function()
				if currentTrade then
					Lib.Network.Invoke("Cancel Trade", currentTrade)
				end
			end)
			table.insert(connections, Lib.Network.Fired("Trade Cancelled"):Connect(TradeEnded))
			table.insert(connections, Lib.Network.Fired("Trade Processed"):Connect(TradeEnded))
			
			peekPPBtn = category:AddButton("Peek Player Pets", function()
				peekPPBtn.Enabled = false
				playerSelectionPopup = _G.SenHub:CreatePopup("GridList", {
					Title = "Player Selection",
					List = list,
					UserChoice = function(indexes)
						playerSelectionPopup = nil
						if indexes[1] and indexes[1] ~= 0 then
							local targetPlayer = indexes[1]
							local peekPets = GetPetsDisplayList(targetPlayer)
							_G.SenHub:CreatePopup("GridList", {
								Title = targetPlayer.DisplayName .. "'s Pets",
								List = peekPets,
								UserChoice = function(indexes)
									if indexes[1] ~= 0 and currentTrade then
										local pet = peekPets[indexes[1]]
										if pet and pet.PetData then
											local result, b = Lib.Network.Invoke("Add Trade Pet", currentTrade, pet.PetData.PetInfo.uid)
											warn(tostring(result) .. " - " .. tostring(b))
										else
											warn("Could not hijack trade for pet: " .. tostring(pet))
										end
									end
									peekPPBtn.Enabled = true
								end
							})
						else
							peekPPBtn.Enabled = true
						end
					end
				})
				UpdatePlayersList()
			end)
			
			table.insert(connections, game.Players.PlayerAdded:Connect(function()
				UpdatePlayersList()
			end))
			table.insert(connections, game.Players.PlayerRemoving:Connect(function()
				UpdatePlayersList()
			end))
		end
		
		spawn(function()
			local statsBillboard = Instance.new("BillboardGui")
			statsBillboard.Size = UDim2.new(0, 150, 0, 30)
			statsBillboard.ResetOnSpawn = false
			statsBillboard.ClipsDescendants = false
			statsBillboard.AlwaysOnTop = true
			statsBillboard.LightInfluence = 0
			statsBillboard.StudsOffsetWorldSpace = Vector3.new(0, 2.5, 0)
			statsBillboard.Name = "StatsBillboard"
			statsBillboard.MaxDistance = 200
			do
				local txt = Instance.new("TextLabel", statsBillboard)
				txt.Name = "Diamonds"
				txt.Text = "??"
				txt.BackgroundTransparency = 1
				txt.Font = Enum.Font.GothamBlack
				txt.TextSize = 24
				txt.TextColor3 = Color3.new(1, 1, 1)
				txt.TextStrokeColor3 = Color3.new(106/255, 106/255, 106/255)
				txt.TextStrokeTransparency = 0
				local ico = Instance.new("ImageLabel", txt)
				ico.Size = UDim2.new(0, 30, 1, 0)
				ico.Position = UDim2.fromScale(1, 0)
				ico.BackgroundTransparency = 1
				ico.Image = "rbxassetid://7786012670"
				game:GetService("ReplicatedStorage").Assets.UI.Currency["Diamonds Gradient"]:Clone().Parent = txt
			end
		
			while Enabled do
				local f, err = pcall(function()
					for k,v in pairs(game.Players:GetPlayers()) do
						if v ~= plr and v.Character then
							local save = Lib.Save.Get(v)
							local billboard = v.Character:FindFirstChild("StatsBillboard") or statsBillboard:Clone()
							billboard.Parent = v.Character
							billboard.Adornee = v.Character.PrimaryPart
							
							billboard.Diamonds.Text = save and Lib.Functions.Commas(save.Diamonds, false) or "???"
							billboard.Diamonds.Size = UDim2.new(0, billboard.Diamonds.TextBounds.X + 5, 1, 0)
							billboard.Diamonds.Position = UDim2.new(0.5, -billboard.Diamonds.Size.X.Offset/2, 0, 0)
						end
					end
					
					local save = Lib.Save.Get()
					if ((Lib.Directory.Ranks[save.Rank].rewardCooldown + save.RankTimer) - Lib.Network.Invoke("Get OSTime")) < 0 then
						Lib.Network.Invoke("Redeem Rank Rewards")
						warn("Auto-Redeemed rank rewards")
					end
					
					for giftId,gift in pairs(Lib.Directory.FreeGifts) do
						local redeemed = false
						for k,v in pairs(save.FreeGiftsRedeemed) do
							if v == giftId then
								redeemed = true
								break
							end
						end
						if not redeemed then
							if gift.waitTime <= save.FreeGiftsTime then
								if Lib.Network.Invoke("Redeem Free Gift", giftId) then
									Lib.Signal.Fire("Fireworks Animation")
									warn("Auto-Redeemed gift number " .. tostring(giftId))
								end
							end
						end
					end
				end)
				if not f then warn(err) end
				wait(1)
			end
		end)
	end
	
	do -- Auto-Farm
		local category = _G.SenHub:AddCategory("Auto-Farm")
		
		local AutoCollectOrbs = category:AddCheckbox("Auto-Collect Orbs", function(state)
			if state then
				CollectAllOrbs()
			end
		end)
		
		table.insert(connections, OrbsFolder.ChildAdded:Connect(function()
			if AutoCollectOrbs.Checked then
				CollectAllOrbs()
			end
		end))
		
		local AutoCollectLootbags = category:AddCheckbox("Auto-Collect Lootbags", function(state)
			if state then
				CollectAllLootbags()
			end
		end)
		
		table.insert(connections, LootbagsFolder.ChildAdded:Connect(function()
			if AutoCollectLootbags.Checked then
				CollectAllLootbags()
			end
		end))
		
		local AutoFarmIndicatorEnabled, AutoFarmRange, AutoFarmArea, AutoFarmStrategy
		
		local AutoFarm = category:AddCheckbox("Auto-Farm", function(state)
			AutoFarmRange.Visible = (state and AutoFarmArea.SelectedIndex == 1)
			AutoFarmIndicatorEnabled.Visible = (state and AutoFarmArea.SelectedIndex == 1)
			AutoFarmArea.Visible = state
			AutoFarmStrategy.Visible = state
		end)
		
		do
			local modes = {
				{Text = "Near Player"}
			}
			for k,v in pairs(areas) do
				if v.name ~= "" then
					table.insert(modes, {Text = v.name})
				end
			end
			AutoFarmArea = category:AddButton("Auto-Farm Area", function()
				AutoFarmArea.Enabled = false
				_G.SenHub:CreatePopup("GridList", {
					Title = "Area Selection",
					List = modes,
					UserChoice = function(indexes)
						local index = indexes[1] or 1
						if index == 0 then
							index = 1
						end
						AutoFarmIndicatorEnabled.Visible = index == 1
						AutoFarmRange.Visible = index == 1
						AutoFarmArea.SelectedIndex = index
						AutoFarmArea.SelectedOption = modes[index].Text
						AutoFarmArea.Enabled = true
					end
				})
			end)
			AutoFarmArea.Visible = false
			AutoFarmArea.SelectedIndex = 1
		end
		
		AutoFarmStrategy = category:AddDropdown("Auto-Farm Strategy", {"Optimized", "Spread", "Focused"}, 1)
		AutoFarmStrategy.Visible = false
		
		AutoFarmIndicatorEnabled = category:AddCheckbox("Auto-Farm Range Indicator")
		AutoFarmIndicatorEnabled:SetChecked(false)
		AutoFarmIndicatorEnabled.Visible = false
		
		AutoFarmRange = category:AddSlider("Auto-Farm Range", 185, 10, 1000, function(newValue)
			AutoFarmRangeIndicator.Size = Vector3.new(1, newValue*2, newValue*2)
		end)
		AutoFarmRange.Visible = false
		
		--[[
			COIN STRUCT
			a = area name
			p = vector3 position
			r = float rotation
			d = bool is diamonds
			w = world name
			pets = ?
			h = int health
			mh = int maxhealth
			petsFarming = table
			n = string name
			
			-> ADDED
			distance = distance to the player
			cid = coin id
		]]
		local function GetCoins()
			local coins = {}
			local coinPiles = {}
			local diamondPiles = {}
			
			local distance, coinPhysical
			for coinId, coinData in pairs(Lib.Network.Invoke("Get Coins")) do
				coinPhysical = CoinsFolder:FindFirstChild(coinId)
				if coinPhysical and coinPhysical:GetAttribute("HasLanded") then
					coinData.distance = AutoFarmArea.SelectedIndex == 1 and plr:DistanceFromCharacter(coinData.p) or 0
					coinData.cid = coinId
					if coinData.n:lower():find("diamond", 1, true) then
						table.insert(diamondPiles, coinData)
					else
						table.insert(coinPiles, coinData)
					end
				end
			end
			for k, coinData in pairs(coinPiles) do
				if (AutoFarmArea.SelectedIndex == 1 and coinData.distance <= AutoFarmRange.Value) or
					(AutoFarmArea.SelectedIndex ~= 1 and coinData.a == tostring(AutoFarmArea.SelectedOption)) then
					table.insert(coins, coinData)
				end
			end
			if AutoFarmArea.SelectedIndex == 1 then
				table.sort(coins, function(a,b)
					return a.distance < b.distance
				end)
			else
				table.sort(coins, function(a,b)
					return a.mh > b.mh
				end)
			end
			for k, coinData in pairs(diamondPiles) do
				table.insert(coins, 1, coinData)
			end
			return coins
		end
		
		--[[
			PET STRUCT
			uid = unique ID
			s = strength
			e = equipped
			idt = pet type id
			nk = name
			dm = dark matter
		]]
		spawn(function()
			local pets, coins, suitableCoin,
				collectiveEffort, farmingPet
			while Enabled and wait(.05) do
				if AutoFarm.Checked then
					if AutoFarmIndicatorEnabled.Checked then
						AutoFarmRangeIndicator.Parent = game.Workspace
						AutoFarmRangeIndicator.Size = Vector3.new(1, AutoFarmRange.Value*2, AutoFarmRange.Value*2)
						AutoFarmRangeIndicator.CFrame = CFrame.new(plr.Character:GetPivot().Position) * CFrame.fromEulerAnglesXYZ(0, 0, math.pi/2)
					else
						AutoFarmRangeIndicator.Parent = nil
					end
					local f, err = pcall(function()
						coins = GetCoins()
						if #coins > 0 then
							pets = Lib.PetCmds.GetEquipped(plr)
							for k, pet in pairs(pets) do
								suitableCoin = nil
								for x, coin in pairs(coins) do
									if AutoFarmStrategy.SelectedIndex == 1 then
										collectiveEffort = 0
										for x, fp in pairs(coin.petsFarming) do
											if pf ~= pet.uid then
												farmingPet = Lib.PetCmds.Get(fp)
												if farmingPet then
													collectiveEffort += farmingPet.s
												end
											end
										end
										if collectiveEffort < coin.h then
											suitableCoin = coin
											break
										end
									elseif AutoFarmStrategy.SelectedIndex == 2 then
										local isFarming = false
										for k,v in pairs(Lib.Network.Invoke("Get Coins")) do
											for x, fp in pairs(v.petsFarming) do
												if pf == pet.uid then
													isFarming = true
													break
												end
											end
										end
										if not isFarming then
											local nobodyElse = true
											for x, fp in pairs(coin.petsFarming) do
												nobodyElse = false
												break
											end
											if nobodyElse then
												suitableCoin = coin
												break
											end
										end
									elseif AutoFarmStrategy.SelectedIndex == 3 then
										suitableCoin = coin
										break
									end
								end
								suitableCoin = suitableCoin or (AutoFarmStrategy.SelectedIndex ~= 2 and coins[1] or nil)
								if not suitableCoin then break end
								local data = Lib.Network.Invoke("Join Coin", suitableCoin.cid, {pet.uid})
								for petUID, canJoin in pairs(data) do
									if canJoin then
										--local petPhysical = PetsFolder:FindFirstChild(petUID)
										--local coinPhysical = CoinsFolder:FindFirstChild(suitableCoin.cid)
										--Lib.WorldFX.CoinSelection(petPhysical, coinPhysical)()
										Lib.Network.Fire("Farm Coin", suitableCoin.cid, petUID);
										--Lib.Network.Fire("Change Pet Target", suitableCoin.cid, petUID);
										--warn("Assigned pet " .. petUID .. " to " .. suitableCoin.cid)
										coins = GetCoins()
									else
										warn("Pet failed to join coin -- " .. petUID)
									end
								end
							end
						end
					end)
					if not f then
						warn("Error during Auto-Farm: " .. tostring(err))
						--AutoFarm:SetChecked(false)
					end
				else
					AutoFarmRangeIndicator.Parent = nil
				end
			end
		end)
	end
	
	do -- Teleports
		local function TeleportTo(areaData)
			if Lib.WorldCmds.Get() ~= areaData.world then
				Lib.WorldCmds.Load(areaData.world)
			end
			local spawnPoint = Lib.WorldCmds.GetMap().Teleports:FindFirstChild(areaData.name)
			if not spawnPoint then
				warn("ERROR! NO SPAWN POINT OF: " .. tostring(areaData.name))
				return
			end
			plr.Character:SetPrimaryPartCFrame(spawnPoint.CFrame + Vector3.new(0, 5, 0));
		end
		
		do -- World Teleports
			local category = _G.SenHub:AddCategory("Area Teleports")
			local currentWorld = nil
			for v, areaData in pairs(areas) do
				if areaData and worlds[areaData.world] ~= nil and not areaData.isShop then
					if currentWorld ~= areaData.world then
						currentWorld = areaData.world
						category:AddLabel("~ " .. worlds[areaData.world].display .. " ~")
					end
					category:AddButton(areaData.name, function()
						TeleportTo(areaData)
					end)
				end
			end
		end
	end
	
	do
		local category = _G.SenHub:AddCategory("Auto-Hatch-Fuse")
		
		category:AddCheckbox("Instant Open", function(state)
			plr.PlayerScripts.Scripts.Game:FindFirstChild("Open Eggs").Disabled = state
		end):SetChecked(true)
		
		local autoFuseBtn = category:AddCheckbox("Auto-Fuse")
		local autoGoldBtn = category:AddCheckbox("Auto-Gold (6 normal pets)")
		local autoRainbowBtn = category:AddCheckbox("Auto-Rainbow (6 gold pets)")
		
		local autoFuseLimit = 5000000000000
		
		local UpdateUI
		local function CanFuse(petData)
			local petClass = Lib.Directory.Pets[petData.id]
			return not petData.e and
				not petData.dm and
				not petClass.isPremium and
				petClass.rarity ~= "Exclusive" and
				petClass.rarity ~= "Mythical"
		end
		spawn(function()
			while Enabled do
				if autoFuseBtn.Checked then
					local toFuse = {}
					local fused = {}
					for k,mainPet in pairs(Lib.Save.Get().Pets) do
						toFuse = {}
						if not fused[mainPet.uid] and CanFuse(mainPet) and mainPet.s <= autoFuseLimit then
							table.insert(toFuse, mainPet.uid)
							for k,v in pairs(Lib.Save.Get().Pets) do
								if v.uid ~= mainPet.uid and CanFuse(v) and v.s <= autoFuseLimit and
									math.abs(mainPet.s - v.s) < mainPet.s*0.25 then
									if #toFuse < 12 then
										table.insert(toFuse, v.uid)
									else
										break
									end
								end
							end
						end
						if (not autoRainbowBtn.Checked and #toFuse >= 3) or (autoRainbowBtn.Checked and #toFuse >= 12) then
							local result, err = Lib.Network.Invoke("Fuse Pets", toFuse)
							if result then
								for k,v in pairs(toFuse) do
									fused[v] = true
								end
							else
								warn("FAILED FUSE: " .. tostring(err))
							end
						end
					end
				end
				if autoGoldBtn.Checked then
					local toGold = {}
					local goldTransformed = {}
					for k,mainPet in pairs(Lib.Save.Get().Pets) do
						local mainPetClass = Lib.Directory.Pets[mainPet.id]
						toGold = {}
						if not goldTransformed[mainPet.uid] and not mainPet.g and not mainPet.r and not mainPet.dm and not mainPetClass.isPremium and mainPetClass.rarity ~= "Exclusive" then
							table.insert(toGold, mainPet.uid)
							for k,v in pairs(Lib.Save.Get().Pets) do
								local petClass = Lib.Directory.Pets[v.id]
								if #toGold < 6 then
									if v.id == mainPet.id and v.uid ~= mainPet.uid and not goldTransformed[v.uid] and (not v.g and not v.r and not v.dm) and not petClass.isPremium and petClass.rarity ~= "Exclusive" then
										table.insert(toGold, v.uid)
									end
								else
									break
								end
							end
						end
						if #toGold == 6 then
							local result, err = Lib.Network.Invoke("Use Golden Machine", toGold)
							if result then
								for k,v in pairs(toGold) do
									goldTransformed[v] = true
								end
							else
								warn("FAILED GOLD TRANSFORM: " .. tostring(err))
							end
						end
					end
				end
				if autoRainbowBtn.Checked then
					local toRainbow = {}
					local rainbowed = {}
					for k,mainPet in pairs(Lib.Save.Get().Pets) do
						toRainbow = {}
						if not rainbowed[mainPet.uid] and mainPet.g then
							table.insert(toRainbow, mainPet.uid)
							for k,v in pairs(Lib.Save.Get().Pets) do
								if #toRainbow < 6 then
									if v.id == mainPet.id and v.uid ~= mainPet.uid and not rainbowed[v.uid] and v.g then
										table.insert(toRainbow, v.uid)
									end
								else
									break
								end
							end
						end
						if #toRainbow == 6 then
							local result, err = Lib.Network.Invoke("Use Rainbow Machine", toRainbow)
							if result then
								for k,v in pairs(toRainbow) do
									rainbowed[v] = true
								end
							else
								warn("FAILED RAINBOW: " .. tostring(err))
							end
						end
					end
				end
				wait(1)
			end
		end)
		
		local selectedEgg = nil
		local selectEggBtn
		local eggsList = {}
		local eggsData = {}
		do
			local sorted = {}
			for k,v in pairs(Lib.Directory.Eggs) do
				if v.hatchable then
					if type(v.drops) == "string" then
						v.drops = Lib.Directory.Eggs[v.drops].drops
					end
					table.insert(sorted, v)
				end
			end
			table.sort(sorted, function(a, b)
				return a.cost > b.cost
			end)
			for k,v in ipairs(sorted) do
				table.insert(eggsList, {Text=v.displayName .. "\n" .. tostring(Lib.Functions.NumberShorten(v.cost)) .. " " .. tostring(v.currency), Color = v.isGolden and Color3.new(1, 1, 0) or Color3.new(1, 1, 1), EggData = v})
				table.insert(eggsData, 1, v)
			end
		end
		
		local function NextAutoCollectEgg()
			local rarities = {"Basic", "Rare", "Epic", "Legendary"}
			local petTypes = {[1] = "", [2] = "Gold ", [3] = "Rb "}
			for _, targetRarity in pairs(rarities) do
				for targetTypeID, targetType in pairs(petTypes) do
					for k,egg in ipairs(eggsData) do
						if targetTypeID == 1 or (targetTypeID >= 1 and egg.isGolden) then
							for k,v in pairs(egg.drops) do
								local drop = tostring(v[1])
								local petData = Lib.Directory.Pets[drop]
								if petData.rarity == targetRarity then
									local petCollectionEntry = drop .. "-" .. tostring(targetTypeID)
									local fullyCollected = false
									for k,v in pairs(Lib.Save.Get().Collection) do
										if v == petCollectionEntry then
											fullyCollected = true
											break
										end
									end
									if not fullyCollected then
										return egg, targetType .. petData.name .. " (" .. targetRarity .. ")"
									end
								end
							end
						end
					end
				end
			end
		end
		
		local autoDarkMatterToggle = category:AddCheckbox("Auto-Dark Matter (6 rb pets)")
		
		local autoCollectionToggle = category:AddCheckbox("Auto-Collection", function()
			selectedEgg = NextAutoCollectEgg()
			UpdateUI()
		end)
		
		spawn(function()
			while Enabled do
				local ost = Lib.Network.Invoke("Get OSTime")
				local qLength, maxQLength = 0, Lib.Save.Get().DarkMatterSlots
				for slotId,v in pairs(Lib.Save.Get().DarkMatterQueue) do
					if v.readyTime - ost <= 0 then
						if Lib.Network.Invoke("Redeem Dark Matter Pet", slotId) then
							warn("Redeemed Dark Matter Pet '" .. Lib.Directory.Pets[v.petId].name .. "'")
						end
					else
						qLength += 1
					end
				end
				if autoDarkMatterToggle.Checked and qLength < maxQLength then
					for k, mainPet in pairs(Lib.Save.Get().Pets) do
						local petClass = Lib.Directory.Pets[mainPet.id]
						if petClass.rarity ~= "Mythical" and mainPet.r then
							local pets = {mainPet.uid}
							for k, pet in pairs(Lib.Save.Get().Pets) do
								if #pets < 6 then
									if pet.uid ~= mainPet.uid and pet.id == mainPet.id and pet.r then
										table.insert(pets, pet.uid)
									end
								else
									break
								end
							end
							if #pets == 6 then
								if Lib.Network.Invoke("Convert To Dark Matter", pets) then
									break
								end
							end
						end
					end
				end
				wait(1)
			end
		end)
		
		local priceLabel = category:AddLabel("No egg selected!")
		local buyEggBtn
		buyEggBtn = category:AddButton("Buy Egg(s)", function()
			if buyingEggs then
				buyingEggs = false
			elseif selectedEgg then
				buyingEggs = true
				local i = 0
				local reason
				while buyingEggs and selectedEgg do
					if Lib.Network.Invoke("Buy Egg", selectedEgg.displayName, false) then
						i += 1
					end
					if not autoCollectionToggle.Checked then
						buyEggBtn.Text = "Stop ( " .. tostring(i) .. " egg(s) bought )"
						_G.SenHub:Update()
					else
						selectedEgg, reason = NextAutoCollectEgg()
						if selectedEgg and reason then
							buyEggBtn.Text = reason
							UpdateUI()
						end
					end
					wait(0.75)
				end
				buyEggBtn.Text = "Buy Egg(s)"
				buyingEggs = false
			end
		end)
		
		UpdateUI = function()
			priceLabel.Text = selectedEgg and "Price: " .. tostring(Lib.Functions.NumberShorten(selectedEgg.cost)) .. " " .. tostring(selectedEgg.currency) or "No egg selected!"
			selectEggBtn.Text = selectedEgg and selectedEgg.displayName or "Select Egg"
			buyEggBtn.Visible = selectedEgg ~= nil
			_G.SenHub:Update()
		end
		
		selectEggBtn = category:AddButton("Select Egg", function()
			_G.SenHub:CreatePopup("GridList", {
				Title = "Egg Selection",
				List = eggsList,
				UserChoice = function(indexes)
					if indexes[1] ~= 0 then
						selectedEgg = eggsList[indexes[1]].EggData
					else
						selectedEgg = nil
					end
					UpdateUI()
				end
			})
		end)
		
		UpdateUI()
	end
	
	do
		local category = _G.SenHub:AddCategory("Auto-Enchant")
		
		local powers = {}
		do
			local maxDropWeight = 0
			for k,v in pairs(Lib.Directory.Powers) do
				if v.canDrop then
					maxDropWeight += v.dropWeight
				end
			end
			for k,v in pairs(Lib.Directory.Powers) do
				if v.canDrop then
					v.name = k
					v.CustomDropdownDisplayName = k .. " (" .. string.format("%.2f", (v.dropWeight/maxDropWeight)*100) .. "%)"
					table.insert(powers, v)
				end
			end
		end
		
		local selectedPet = nil
		local selectPetBtn
		
		local stopAtUnique, selectedPowerLevel, selectedPower
		
		local singleEnchantBtn, autoEnchantBtn
		
		local function HasDesiredPowers()
			local petInfo = Lib.PetCmds.Get(selectedPet.PetInfo.uid)
			if not petInfo then return false end
			for k,v in pairs(petInfo.powers) do
				if v[1] == selectedPower.SelectedOption.name and v[2] >= selectedPowerLevel.Value then
					warn("SUCCESSFULLY ENCHANTED PET!")
					return true
				elseif stopAtUnique.Checked then
					for x,p in pairs(petInfo.powers) do
						if p.isUnique then
							warn("HIT UNIQUE ENCHANT!")
							return true
						end
					end
				end
			end
			return false
		end
		
		singleEnchantBtn = category:AddButton("Single Enchant", function()
			if HasDesiredPowers() and
				not Lib.Message.New("Pet already has desired enchants.\nAre you sure?", true) then
				return
			end
			Lib.Network.Invoke("Enchant Pet", selectedPet.PetInfo.uid)
		end)
		
		autoEnchantBtn = category:AddButton("Auto-Enchant", function()
			if autoEnchanting then
				autoEnchanting = false
			else
				if HasDesiredPowers() and
					not Lib.Message.New("Pet already has desired enchants.\nAre you sure?", true) then
					
					return
				end
				autoEnchanting = true
				autoEnchantBtn.Text = "Enchanting..."
				while autoEnchanting do
					if Lib.Network.Invoke("Enchant Pet", selectedPet.PetInfo.uid) and
						HasDesiredPowers() then
						Lib.Message.New("Auto-Enchanting finished successfully!")
						break
					end
					wait()
				end
				autoEnchanting = false
				autoEnchantBtn.Text = "Auto-Enchant"
			end
		end)
		
		stopAtUnique = category:AddCheckbox("Stop at Unique(s)")
		stopAtUnique:SetChecked(true)
		
		local function UpdateUI()
			selectPetBtn.Text = selectedPet and selectedPet.PetClass.name .. " " .. '"' .. selectedPet.PetInfo.nk .. '" ' .. tostring(Lib.Functions.NumberShorten(selectedPet.PetInfo.s)) or "Select Pet"
			singleEnchantBtn.Visible = selectedPet ~= nil
			autoEnchantBtn.Visible = selectedPet ~= nil
			selectedPower.Visible = selectedPet ~= nil
			if selectedPet then
				selectedPowerLevel:SetSliderMinMax(nil, #selectedPower.SelectedOption.tiers)
			end
			selectedPowerLevel.Visible = selectedPet ~= nil
			stopAtUnique.Visible = selectedPet ~= nil
		end
		
		selectedPower = category:AddDropdown("Enchantment", powers, 1, function(index)
			UpdateUI()
		end)
		selectedPowerLevel = category:AddSlider("Minimum Enchant Level", 1, 1, 5)
		
		selectPetBtn = category:AddButton("Select Pet", function()
			selectPetBtn.Enabled = false
			local petsList = GetPetsDisplayList(plr)
			while true do
				local stop = true
				for k,v in pairs(petsList) do
					if v.PetData.PetClass.rarity == "Mythical" or
						v.PetData.PetClass.isPremium then
						table.remove(petsList, k)
						stop = false
					end
				end
				if stop then break end
			end
			
			_G.SenHub:CreatePopup("GridList", {
				Title = "Pet Selection",
				List = petsList,
				UserChoice = function(indexes)
					if indexes[1] ~= 0 then
						selectedPet = petsList[indexes[1]].PetData
					else
						selectedPet = nil
					end
					selectPetBtn.Enabled = true
					UpdateUI()
				end
			})
		end)
		
		UpdateUI()
	end
	
	do
		local category = _G.SenHub:AddCategory("Statistics")
		
		category:AddLabel("~ Currency (Rate of Change/h) ~")
		
		local cacheSpan = 5
		local currencies = {}
		local currencyLabels = {}
		local cache = {}
		local averages = {}
		do
			for k,v in pairs(Lib.Shared.Currency) do
				v.name = k
				table.insert(currencies, v)
			end
			table.sort(currencies, function(a, b)
				return a.order < b.order
			end)
			for k,v in pairs(currencies) do
				currencyLabels[v.name] = category:AddLabel()
				currencyLabels[v.name]._GuiObject.TextXAlignment = Enum.TextXAlignment.Left
				currencyLabels[v.name]._GuiObject.TextTruncate = Enum.TextTruncate.None
				cache[v.name] = Lib.Save.Get()[v.name] or 0
				averages[v.name] = {}
			end
		end
		local function UpdateRoCs()
			local current, RoC, RoCavg = 0, 0, 0
			for k,v in pairs(currencies) do
				current = Lib.Save.Get()[v.name] or 0
				RoC = (current - cache[v.name])
				RoCavg = 0
				table.insert(averages[v.name], 1, RoC)
				if #averages[v.name] > cacheSpan then
					table.remove(averages[v.name], cacheSpan+1)
				end
				for k,v in pairs(averages[v.name]) do
					RoCavg += v
				end
				RoCavg = (RoCavg / #averages[v.name]) * 3600
				currencyLabels[v.name].Text = (v.name .. "\t\tRoC/h: " ..
					(RoCavg > 0 and "+" or (RoCavg < 0 and "-" or "")) ..
					tostring(Lib.Functions.NumberShorten(math.abs(RoCavg))))
				currencyLabels[v.name]._GuiObject.TextColor3 = (RoCavg > 0 and Color3.new(0, 1, 0) or (RoCavg < 0 and Color3.new(1, 0, 0) or Color3.new(1, 1, 1)))
				cache[v.name] = current
			end
		end
		
		spawn(function()
			while Enabled do
				local test, err = pcall(UpdateRoCs)
				if not test then
					warn(err)
					break
				end
				wait(1)
			end
		end)
		
		category:AddButton("Reset Averages", function()
			for k,v in pairs(averages) do
				averages[k] = {}
			end
		end)
		UpdateRoCs()
	end
end

function module.Shutdown()
	Enabled = false
	buyingEggs = false
	autoEnchanting = false
	if AutoFarmRangeIndicator then
		AutoFarmRangeIndicator:Destroy()
	end
	for k,v in pairs(game.Players:GetPlayers()) do
		if v.Character then
			local billboard = v.Character:FindFirstChild("StatsBillboard")
			if billboard then
				billboard:Destroy()
			end
		end
	end
	for k,v in pairs(connections) do
		if v then v:Disconnect() end
	end
end

return module