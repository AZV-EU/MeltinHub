local module = {
	GameName = "Anime Adventures",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer
if not plr then return end
local moduleOn = true

local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local function SetupOverheadUI(target, templates)
	if target and target.Character then
		local overhead = target.Character:FindFirstChild("_overhead", true)
		if overhead then
			local frame = overhead:FindFirstChild("Frame")
			if frame then
				for k,v in pairs(templates) do
					if not frame:FindFirstChild(v.Name) then
						local temp = v:Clone()
						temp.text.LayoutOrder = 0
						temp.text.TextXAlignment = Enum.TextXAlignment.Right
						temp.Size = UDim2.new(1, 0, 0, 22)
						if temp:FindFirstChild("icon") then
							temp.icon.LayoutOrder = 1
						end
						temp.Parent = frame
						temp.LayoutOrder = 0
					end
				end
				overhead.Size = UDim2.new(0, 100, 0, 100)
				overhead.StudsOffset = Vector3.new(0, 3, 0)
				overhead.MaxDistance = 200
				return frame
			end
		end
	end
end

local OVERHEADS = {}

function module.Init(category, connections)
	local IsLobby = game.Workspace:WaitForChild("_MAP_CONFIG"):WaitForChild("IsLobby").Value
	if game.Workspace:WaitForChild("_MAP_CONFIG"):FindFirstChild("IsTimeMachine") then
		category:AddLabel("In time machine (no cheats available)")
		return
	end
	
	repeat wait() until
		game.Workspace:FindFirstChild("SERVER_READY") and
		game.Workspace.SERVER_READY.Value and
		plr.Character ~= nil
	
	local Loader = require(game.ReplicatedStorage:WaitForChild("src"):WaitForChild("Loader"))
	local EndpointsClient = Loader.load_client_service(script, "EndpointsClient")
	_G.session_data = EndpointsClient.session
	local GUIService = Loader.load_client_service(script, "GUIService")
	local UnitServiceCore = Loader.load_core_service(script, "UnitServiceCore")
	local Units = Loader.load_data(script, "Units")
	
	do -- overheads
		local ISC = game:GetService("ReplicatedStorage"):WaitForChild("packages"):WaitForChild("assets"):WaitForChild("gui"):WaitForChild("ItemShopCosts")
		local gemsTemplate = ISC:WaitForChild("gems")
		local yenTemplate = ISC:WaitForChild("gold"):Clone()
		yenTemplate.Name = "yen"
		yenTemplate:FindFirstChild("icon"):Destroy()
		
		local function SetupOverheadPlayer(p)
			local overhead = IsLobby and SetupOverheadUI(p, {gemsTemplate}) or SetupOverheadUI(p, {yenTemplate})
			if not overhead then return end
			if not OVERHEADS[p] then
				local stats = p:FindFirstChild("_stats")
				if not stats then return end
				local pGems = stats:FindFirstChild("gem_amount")
				local pResource = stats:FindFirstChild("resource")
				if not pGems then return end
				if not pResource then return end
				
				if IsLobby then
					OVERHEADS[p] = {conns={},guis={overhead.gems}}
					local gemsConn = pGems:GetPropertyChangedSignal("Value"):Connect(function()
						overhead.gems.text.Text = tostring(pGems.Value)
					end)
					overhead.gems.text.Text = tostring(pGems.Value)
					table.insert(OVERHEADS[p].conns, gemsConn)
					table.insert(connections, gemsConn)
				else
					OVERHEADS[p] = {conns={},guis={overhead.yen}}
					local resConn = pResource:GetPropertyChangedSignal("Value"):Connect(function()
						overhead.yen.text.Text = string.format("%d ¥", pResource.Value)
					end)
					overhead.yen.text.Text = string.format("%d ¥", pResource.Value)
					OVERHEADS[p] = {conns={},guis={overhead.yen}}
					table.insert(OVERHEADS[p].conns, resConn)
					table.insert(connections, resConn)
				end
			end
		end
		
		for k,v in pairs(game.Players:GetPlayers()) do
			SetupOverheadPlayer(v)
		end
		spawn(function()
			while moduleOn do
				for k,v in pairs(game.Players:GetPlayers()) do
					SetupOverheadPlayer(v)
				end
				task.wait(3)
			end
		end)
	end
	
	if IsLobby then -- in-lobby
		repeat wait() until _G.session_data
		local pity_data = _G.session_data.pity_data
		local GameplaySettings = require(game.ReplicatedStorage.src.Data.GameplaySettings)
		local ChallengeAndRewards = require(game.ReplicatedStorage.src.Data.ChallengeAndRewards)
		
		do -- teleports
			category:AddLabel("Teleports:")
			category:AddButton("Play", function()
				local target = game.Workspace["_LOBBIES"].Barrier
				_G.TeleportPlayerTo((target.CFrame * CFrame.new(0, 0, -5)).Position)
			end).Inline = true
			category:AddButton("Raid", function()
				local target = game.Workspace["_RAID"].shell.Barrier
				_G.TeleportPlayerTo((target.CFrame * CFrame.new(0, -(target.Size.Y/2), -10)).Position)
			end).Inline = true
			category:AddButton("Evolve", function()
				local target = game.Workspace["_EVOLVE"].void.floor
				_G.TeleportPlayerTo(target.Position + Vector3.new(0, 3, 0))
			end)
			category:AddButton("Teleport to Merchant", function()
				local merchant = game.Workspace:FindFirstChild("travelling_merchant")
				if merchant then
					local stand = merchant:FindFirstChild("stand")
					if stand then
						local target = stand:FindFirstChild("area")
						_G.TeleportPlayerTo(CFrame.new(target.Position + Vector3.new(0, 3, 0)) * CFrame.new(0, 0, -2).Position)
					end
				end
			end)
		end
		
		do -- hatching
			local category = _G.SenHub:AddCategory("Hatching")
			
			local banners = {}
			for banner, data in pairs(_G.session_data.profile_data.pity_data) do
				category:AddLabel(string.format("%s Banner", tostring(banner)))
				banners[banner] = {
					legendaryPity = category:AddLabel(),
					mythicPity = category:AddLabel()
				}
			end
			
			local nextBannerLabel = category:AddLabel("Time to next banner: ")
			
			local function UpdatePityInfo()
				for banner, data in pairs(_G.session_data.profile_data.pity_data) do
					local legendary_pity = data.opens_since_legendary and data.opens_since_legendary or 0
					local mythic_pity = data.opens_since_mythic and data.opens_since_mythic or 0
					banners[banner].legendaryPity.Text = string.format("\tLegendary Pity: %d / %d", legendary_pity, GameplaySettings.LEGENDARY_PITY)
					banners[banner].mythicPity.Text = string.format("\tMythic Pity: %d / %d", mythic_pity, GameplaySettings.MYTHIC_PITY)
				end
				_G.SenHub:Update()
			end
			UpdatePityInfo()
			
			table.insert(connections, game.ReplicatedStorage.endpoints["server_to_client"]["pity_data_changed"].OnClientEvent:Connect(function(newPityData)
				_G.session_data.pity_data = newPityData
				UpdatePityInfo()
			end))
		end
		
		do -- challenges
			local category = _G.SenHub:AddCategory("Challenges")
			
			local challengeData = game.Workspace["_LOBBIES"]["_DATA"]["_CHALLENGE"]
			
			local challengeRemainingTimeLabel = category:AddLabel("Remaining time")
			local challengeRewardLabel = category:AddLabel("Reward")
			local function UpdateChallengesInfo()
				local remainingTime = challengeData.challenge_remaining_time.Value
				local timeFormat = string.format("Remaining time: %02d:%02d", math.floor(remainingTime / 60), remainingTime % 60)
				challengeRemainingTimeLabel._GuiObject.Text = string.format("Remaining time: %02d:%02d", math.floor(remainingTime / 60), remainingTime % 60)
				challengeRemainingTimeLabel.Text = string.format("Remaining time: %02d:%02d", math.floor(remainingTime / 60), remainingTime % 60)
				challengeRewardLabel.Text = "Reward: " .. ChallengeAndRewards.rewards[challengeData.current_reward.Value].name
			end
			UpdateChallengesInfo()
			_G.SenHub:Update()
			
			table.insert(connections, challengeData.challenge_remaining_time:GetPropertyChangedSignal("Value"):Connect(function()
				UpdateChallengesInfo()
			end))
			table.insert(connections, challengeData.current_reward:GetPropertyChangedSignal("Value"):Connect(function()
				UpdateChallengesInfo()
				_G.SenHub:Update()
			end))
			category:AddButton("Teleport to challenges", function()
				_G.TeleportPlayerTo(game.Workspace["_CHALLENGES"].shell.floor.Position + Vector3.new(0, 3, 0))
			end)
		end
	elseif not IsLobby then -- in-game
		local Settings = Loader.load_data(script, "Settings")
		
		local function ToggleSetting(settingId, val)
			if plr:WaitForChild("_settings"):WaitForChild(settingId).Value ~= val then
				plr._settings[settingId].Value = val
				game.ReplicatedStorage.endpoints.client_to_server.toggle_setting:InvokeServer(settingId, val)
				for k,v in pairs(plr.PlayerGui["settings_new"]:FindFirstChild("Scroll", true):GetChildren()) do
					if v.Name == "SettingFrame" and v:FindFirstChild("Main") and v.Main:FindFirstChild("Button") then
						if v.Main.SettingName.Text == Settings[settingId].text then
							if val then
								GUIService.toggle_slider_on(v.Main.Button, false)
								return
							end
							GUIService.toggle_slider_off(v.Main.Button, false)
							return
						end
					end
				end
			end
		end
		
		ToggleSetting("autoskip_waves", true)
		
		local TeleportData = game:GetService("TeleportService"):GetLocalPlayerTeleportData()
		
		local playerStats = plr:WaitForChild("_stats")
		
		local units = game.Workspace:WaitForChild("_UNITS")
		local unitsData = require(game.ReplicatedStorage.src.Data.Units)
		local endpoints = game.ReplicatedStorage:WaitForChild("endpoints")

		local use_active_attack = endpoints:WaitForChild("client_to_server"):WaitForChild("use_active_attack")
		local sell_unit_ingame = endpoints:WaitForChild("client_to_server"):WaitForChild("sell_unit_ingame")
		local upgrade_unit_ingame = endpoints:WaitForChild("client_to_server"):WaitForChild("upgrade_unit_ingame")

		local function GetEnemies()
			return CollectionService:GetTagged("pve_minions_alive")
		end

		local function GetPlayableUnits()
			return CollectionService:GetTagged("player_units")
		end

		local function GetOwnedUnits()
			local ownedUnits = {}
			for k,v in pairs(CollectionService:GetTagged("nonminion_units")) do
				if v:FindFirstChild("_stats") and CollectionService:HasTag(v, "player_units:" .. tostring(plr.UserId)) then
					table.insert(ownedUnits, v)
				end
			end
			return ownedUnits
		end

		local function GetIsBossPresent()
			for k,v in pairs(units:GetChildren()) do
				if v:FindFirstChild("bossIndicator") then
					return true
				end
			end
			return false
		end

		local function ForEachUnitByName(unitName, func)
			for k,v in pairs(units:GetChildren()) do
				if v.Name == unitName then
					--spawn(function()
						local f, err = pcall(func, v)
						if not f then error(err) end
					--end)
				end
			end
		end
		local function ForEachPlayerUnitByName(unitName, func)
			for k,v in pairs(GetOwnedUnits()) do
				if v.Name == unitName then
					--spawn(function()
						local f, err = pcall(func, v)
						if not f then error(err) end
					--end)
				end
			end
		end
		
		local autoErwin = category:AddCheckbox("Auto-Erwin")
		--autoErwin:SetChecked(true)
		autoErwin.Inline = true
		local autoWendy = category:AddCheckbox("Auto-Wendy")
		--autoWendy:SetChecked(true)
		
		local autoKisuko = category:AddCheckbox("Auto-Kisuko")
		--autoKisuko:SetChecked(true)
		
		local autoUpgrade = category:AddCheckbox("Auto-Upgrade")
		autoUpgrade.Inline = true
		local autoUpgradeFarmFirst = category:AddCheckbox("Farm-first")
		autoUpgradeFarmFirst:SetChecked(true)
		local autoSellAtWave10
		local autoSellAtWave50 = category:AddCheckbox("Auto-Sell All at Wave 50+", function(state)
			autoSellAtWave10.Visible = state
			_G.SenHub:Update()
		end)
		autoSellAtWave10 = category:AddCheckbox("Auto-Sell All at Wave 10+")
		autoSellAtWave10.Visible = false
		
		local function UpgradeUnit(unit)
			local data = unitsData[unit._stats.id.Value]
			local upgrade = unit._stats.upgrade.Value
			if data and data.upgrade[upgrade + 1] and data.upgrade[upgrade + 1].cost <= playerStats.resource.Value then
				upgrade_unit_ingame:InvokeServer(unit)
			end
		end
		
		local upgradeAll = category:AddButton("Upgrade all units", function()
			for k,v in pairs(GetOwnedUnits()) do
				UpgradeUnit(v)
			end
		end)
		
		local sellAll
		sellAll	= category:AddButton("Sell all units", function()
			sellAll.Enabled = false
			_G.SenHub:Update()
			_G.SenHub:CreatePopup("MessageBox", {
				Title = "Sell All Units",
				Message = "Are you sure?",
				Buttons = {{Text = "Yes"}, {Text = "Cancel"}},
				UserChoice = function(choice)
					if choice[1] == 1 then
						for k,v in pairs(GetOwnedUnits()) do
							local data = unitsData[v._stats.id.Value]
							if data and not data.unsellable then
								sell_unit_ingame:InvokeServer(v)
							end
						end
					end
					sellAll.Enabled = true
					_G.SenHub:Update()
				end
			})
		end)
		
		local function GetUnitsInRangeOf(unit)
			local stats, root = unit["_stats"], unit["_root"].Value
			local validUnits = {}
			if root and stats then
				local range = stats.range.Value * stats.range_multiplier.Value
				for k, other in pairs(GetPlayableUnits()) do
					if other ~= unit and other.Name ~= unit.Name and
						CollectionService:HasTag(other, "nonminion_units") and
						other:FindFirstChild("_stats") and other._stats:FindFirstChild("damage") and
						other._stats.damage.Value > 0 and other._stats:FindFirstChild("parent_unit") and
						other._stats.parent_unit.Value == nil and
						other:FindFirstChild("_root") and other["_root"].Value and
						(other["_root"].Value.Position - root.Position).Magnitude <= range then
						table.insert(validUnits, other)
					end
				end
			end
			return validUnits
		end
		
		spawn(function()
			while moduleOn and wait(2) do
				if not moduleOn then break end
				
				local f, err = pcall(function()
				if autoErwin.Checked then
					for k,unit in pairs(GetOwnedUnits()) do
						if unit.Name == "erwin" or unit.Name == "erwin:shiny" then
							local stats = unit["_stats"]
							if stats.upgrade.Value >= 3 then
								local lastCast = stats.last_active_cast.Value
								local cooldown = stats.active_attack_cooldown.Value * stats.active_attack_cooldown_multiplier.Value
								if tick() - lastCast >= cooldown then
									local range = stats.range.Value * stats.range_multiplier.Value
									local allBuffed = true
									for k, other in pairs(GetUnitsInRangeOf(unit)) do
										if other["_buffs"].damage_buff__erwin.Value == 0 then
											allBuffed = false
											break
										end
									end
									if not allBuffed then
										pcall(function()
											use_active_attack:InvokeServer(unit)
										end)
										break
									end
								end
							end
						end
					end
				end
				
				if autoWendy.Checked then
					print("autowendy check 1")
					for k,unit in pairs(GetOwnedUnits()) do
						if unit.Name == "wendy" or unit.Name == "wendy:shiny" then
							local stats = unit["_stats"]
							local lastCast = stats.last_active_cast.Value
							local cooldown = stats.active_attack_cooldown.Value * stats.active_attack_cooldown_multiplier.Value
							if tick() - lastCast >= cooldown then
								local range = stats.range.Value * stats.range_multiplier.Value
								local allBuffed = true
								for k, other in pairs(GetUnitsInRangeOf(unit)) do
									if other["_buffs"].damage_buff__wendy.Value == 0 then
										allBuffed = false
										break
									end
								end
								if not allBuffed then
									pcall(function()
										use_active_attack:InvokeServer(unit)
									end)
									break
								end
							end
						end
					end
				end
				
				if autoKisuko.Checked then
					for k,unit in pairs(GetOwnedUnits()) do
						if unit.Name == "kisuke_evolved" or unit.Name == "kisuke_evolved:shiny" then
							local stats = unit["_stats"]
							if stats.upgrade.Value >= 6 then
								local lastCast = stats.last_active_cast.Value
								local cooldown = stats.active_attack_cooldown.Value * stats.active_attack_cooldown_multiplier.Value
								if tick() - lastCast >= cooldown then
									local range = stats.range.Value * stats.range_multiplier.Value
									local allBuffed = true
									for k, other in pairs(GetUnitsInRangeOf(unit)) do
										if other["_buffs"].attack_cooldown_buff.Value == 0 and
											other["_buffs"].range_buff.Value == 0 then
											allBuffed = false
											break
										end
									end
									if not allBuffed then
										pcall(function()
											use_active_attack:InvokeServer(unit)
										end)
										break
									end
								end
							end
						end
					end
				end
				
				if autoUpgrade.Checked then
					if autoUpgradeFarmFirst.Checked then
						local found = nil
						for k,v in pairs(GetOwnedUnits()) do
							local data = unitsData[v._stats.id.Value]
							local upgrade = v._stats.upgrade.Value
							if data.farm_amount ~= nil and data.upgrade[upgrade + 1] then
								found = v
								break
							end
						end
						if found then
							UpgradeUnit(found)
						else
							for k,v in pairs(GetOwnedUnits()) do
								UpgradeUnit(v)
							end
						end
					else
						for k,v in pairs(GetOwnedUnits()) do
							UpgradeUnit(v)
						end
					end
				end
				
				if autoSellAtWave50.Checked then
					local waveNum, waveTime =
						game.Workspace:FindFirstChild("_wave_num"),
						game.Workspace:FindFirstChild("_wave_time")
					if waveNum then
						if waveNum.Value >= 50 or (autoSellAtWave10.Checked == true and waveNum.Value >= 10) then
							if not plr._settings.autoskip_waves.Value then
								ToggleSetting("autoskip_waves", true)
							end
							--if waveTime and waveTime.Value <= 35 then
								for k,v in pairs(GetOwnedUnits()) do
									local data = unitsData[v._stats.id.Value]
									if data and not data.unsellable then
										sell_unit_ingame:InvokeServer(v)
									end
								end
							--end
						end
					end
				end
				
				end)
				if not f then
					warn(err)
				end
			end
		end)
		
		category:AddButton("Teleport back to lobby", function()
			_G.SenHub:CreatePopup("MessageBox", {
				Title = "Teleport to Lobby",
				Message = "Are you sure?",
				Buttons = {{Text = "Yes"}, {Text = "Cancel"}},
				UserChoice = function(choice)
					if choice[1] == 1 then
						game:GetService("TeleportService"):Teleport(8304191830)
					end
				end
			})
		end)
		
		do -- permanent cooldown
			local hpBar = plr.PlayerGui:WaitForChild("Waves"):WaitForChild("HealthBar")
			table.insert(connections, hpBar:WaitForChild("Timer"):GetPropertyChangedSignal("Visible"):Connect(function()
				if not hpBar.Timer.Visible and not game.Workspace._is_last_wave.Value then
					hpBar.Timer.Visible = true
				end
			end))
			hpBar.Timer.Visible = true
			table.insert(connections, hpBar:WaitForChild("ImageLabel"):GetPropertyChangedSignal("Visible"):Connect(function()
				if not hpBar.ImageLabel.Visible and not game.Workspace._is_last_wave.Value then
					hpBar.ImageLabel.Visible = true
				end
			end))
			hpBar.ImageLabel.Visible = true
		end
		
		do -- place anywhere
			local terrain = game.Workspace:FindFirstChild("_terrain")
			if not terrain then
				warn("Place-anywhere can't function: no _terrain found!")
			else
				local ground = terrain:FindFirstChild("ground")
				if ground then
					--[[
					local forbiddenTerrain = terrain:FindFirstChild("terrain")
					if forbiddenTerrain then
						for k,v in pairs(forbiddenTerrain:GetChildren()) do
							v.Parent = ground
						end
					end
					
					local hill = terrain:FindFirstChild("hill")
					if hill then
						for k,v in pairs(hill:GetChildren()) do
							v.Parent = ground
						end
					end
					]]
					
					if ground:FindFirstChild("rain") then
						ground.rain:Destroy()
					end
					
					if not ground:FindFirstChild("_road") then
						local road = game.Workspace:FindFirstChild("_road", true)
						if road then
							road.Parent = ground
						end
					end
					if not game.Workspace:FindFirstChild("_road") then
						local fake = game.Workspace:FindFirstChild("_road") or Instance.new("Model", game.Workspace)
						fake.Name = "_road"
					end
					if game.Workspace:FindFirstChild("_map") then
						for k,v in pairs(game.Workspace._map:GetChildren()) do
							v.Parent = ground
						end
					end
					local fakeBounds = game.ReplicatedStorage:FindFirstChild("fake_bounds") or Instance.new("Folder", game.ReplicatedStorage)
					fakeBounds.Name = "fake_bounds"
					if game.ReplicatedStorage:FindFirstChild("_bounds") then
						for k,v in pairs(game.ReplicatedStorage._bounds:GetChildren()) do
							v.Parent = fakeBounds
						end
					end
				end
				local function UpdateHitbox(hitbox)
					if hitbox.Name == "_hitbox" then
						hitbox.Size = Vector3.new(0.1, 0.1, 0.1)
						table.insert(connections, hitbox:GetPropertyChangedSignal("Size"):Connect(function()
							hitbox.Size = Vector3.new(0.1, 0.1, 0.1)
						end))
					end
				end
				for k,v in pairs(units:GetDescendants()) do
					UpdateHitbox(v)
				end
				table.insert(connections, units.DescendantAdded:Connect(function(desc)
					UpdateHitbox(desc)
				end))
				_G._place_anywhere_enabled = true
				_G.Notify("Place-anywhere initialized.")
			end
			
			--[[
			local NumLobbyPlayers = TeleportData.level_data.levelData._number_of_lobby_players or 1
			if not _G._place_anywhere_enabled and NumLobbyPlayers == 1 then
				--EnablePlaceAnywhere()
				if game.Workspace:FindFirstChild("_barrier") then
					game.Workspace._barrier:ClearAllChildren()
				end
			end
			local enableBtn
			enableBtn = category:AddButton("Enable Place-Anywhere", function()
				enableBtn:Remove()
				EnablePlaceAnywhere()
			end)
			]]
		end
		
		do -- advanced upgrade stats
			local GUIService = Loader.load_client_service(script, "GUIService")
			local function ShowAdvancedStats(unitChar)
				if not unitChar then warn("No selected unit char") return end
				local unitSessionData = _G.session_data.collection.collection_profile_data.owned_units[unitChar._stats.uuid.Value]
				local unitData = Units[unitChar._stats.id.Value]
				local currentUpgradeNum = unitChar._stats.upgrade.Value
				local maxUpgradeNum = #unitData.upgrade
				if currentUpgradeNum < maxUpgradeNum then
					local curUpgData, nextUpgData = (currentUpgradeNum > 0 and unitData.upgrade[currentUpgradeNum] or unitData), unitData.upgrade[currentUpgradeNum+1]
					if curUpgData and nextUpgData then
						local upgradeCost = nextUpgData.cost * UnitServiceCore.calculate_upgrade_cost_multiplier()
						local difference = ""
						if nextUpgData.farm_amount then
							local farmMult = unitChar._stats:FindFirstChild("farm_amount_multiplier") and unitChar._stats.farm_amount_multiplier.Value or 1
							local curFarm, nextFarm =
								curUpgData.farm_amount * UnitServiceCore.calculate_static_stat_multiplier(unitSessionData, unitSessionData.xp, "farm_amount") * farmMult,
								nextUpgData.farm_amount * UnitServiceCore.calculate_static_stat_multiplier(unitSessionData, unitSessionData.xp, "farm_amount") * farmMult
							difference = string.format("+%0.2f ¥ / 100¥", ((nextFarm - curFarm) / upgradeCost)*100)
						elseif nextUpgData.damage and nextUpgData.attack_cooldown then
							local dmgMult = unitChar._stats:FindFirstChild("damage_multiplier") and unitChar._stats.damage_multiplier.Value or 1
							local cooldownMult = unitChar._stats:FindFirstChild("attack_cooldown_multiplier") and unitChar._stats.attack_cooldown_multiplier.Value or 1
							local curDmg, nextDmg =
								curUpgData.damage * UnitServiceCore.calculate_static_stat_multiplier(unitSessionData, unitSessionData.xp, "damage") * dmgMult,
								nextUpgData.damage * UnitServiceCore.calculate_static_stat_multiplier(unitSessionData, unitSessionData.xp, "damage") * dmgMult
							local curCooldown, nextCooldown =
								curUpgData.attack_cooldown * UnitServiceCore.calculate_static_stat_multiplier(unitSessionData, unitSessionData.xp, "attack_cooldown") * cooldownMult,
								nextUpgData.attack_cooldown * UnitServiceCore.calculate_static_stat_multiplier(unitSessionData, unitSessionData.xp, "attack_cooldown") * cooldownMult
							local upgDiff = (((nextDmg/nextCooldown) - (curDmg/curCooldown)) / upgradeCost)*100
							difference = string.format(upgDiff > 0 and "+%0.2f DPS / 100¥" or "-%0.2f DPS / 100¥", upgDiff)
						else
							return
						end
						GUIService.unit_upgrade_ui.Buttons.Upgrade.Main.Text.Text = 
							"Upgrade: " .. tostring(upgradeCost) .. "¥\n" .. difference
					end
				end
			end
			
			local unitUpgradeUI = Loader.load_client_class(script, "UnitUpgradeUI")
			if _G.UnitUpgradeUI_OriginalHookFunc then
				print("Reverting primitive hook")
				unitUpgradeUI.update_upgrades = _G.UnitUpgradeUI_OriginalHookFunc
				_G.UnitUpgradeUI_OriginalHookFunc = nil
			end
			_G.UnitUpgradeUI_OriginalHookFunc = unitUpgradeUI.update_upgrades
			unitUpgradeUI.update_upgrades = function(self)
				local f, err = pcall(function()
					_G.UnitUpgradeUI_OriginalHookFunc(self)
				end)
				if not f then
					warn(err)
				end
				ShowAdvancedStats(self.unit_char)
			end
		end
		
		do -- placement override
			local placementServiceClient = Loader.load_client_service(script, "PlacementServiceClient")
			if _G.PlacementServiceClient_OriginalHookFunc then
				print("Reverting auto-place allow hook")
				placementServiceClient.on_place = _G.PlacementServiceClient_OriginalHookFunc
				_G.PlacementServiceClient_OriginalHookFunc = nil
			end
			_G.PlacementServiceClient_OriginalHookFunc = placementServiceClient.on_place
			placementServiceClient.on_place = function(...)
				placementServiceClient.can_place = true
				_G.PlacementServiceClient_OriginalHookFunc(...)
			end
		end
		
		do -- stats	category
			local category = _G.SenHub:AddCategory("Statistics")
			local myStats = plr:WaitForChild("_stats")
			local myKills = myStats:WaitForChild("kills")
			
			local killsLabel = category:AddLabel(string.format("Kills: %d", myKills.Value))
			table.insert(connections, myKills:GetPropertyChangedSignal("Value"):Connect(function() killsLabel:SetText(string.format("Kills: %d", myKills.Value)) end))
		end
		
		do -- move UI
			_G.SenHub.Position = UDim2.new(1, -_G.SenHub.Size.X.Offset - 50, 0.5, 0)
		end
	end
	
	do -- debug
		local category = _G.SenHub:AddCategory("Data/Debug")
		
		local function GatherDataForUnits(units, targetTrait, doubleTrait, forceMax)
			local targetLevel = 100
			local targetXp = math.ceil(UnitServiceCore:calculate_xp(targetLevel))
			local data = {}
			
			local select_traits = {
				[1] = {
					trait = "unique",
					tier = "1"
				}
			}
			
			for k, unit in pairs(units) do
				local unitData = Units[unit.unit_id or unit.id]
				if unitData and unitData.upgrade and unitData.upgrade[#unitData.upgrade] then
					local lastUpgrade = unitData.upgrade[#unitData.upgrade]
					unit.xp = forceMax and targetXp or (unit.xp or targetXp)
					unit.unit_id = unit.unit_id or unit.id
					unit.traits = targetTrait and { select_traits[targetTrait] } or (unit.traits or {})
					if doubleTrait then
						unit.traits = targetTrait and {
							select_traits[targetTrait],
							select_traits[targetTrait]
						} or (unit.traits or {})
					end
					unit.trait_stats = unit.trait_stats or {
						speed_stat = 1,
						potency_stat = 1,
						range_stat = 1
					}
					local dominantTrait = #unit.traits > 0 and (unit.traits[1].trait .. " " .. unit.traits[1].tier) or nil
					local unitCapOverride = (dominantTrait ~= nil and dominantTrait == "unique 1") and 1 or nil
					local unitCap = unitCapOverride or unitData.spawn_cap or 1
					local damage = 1
					if lastUpgrade.damage ~= nil and lastUpgrade.damage > 0 then
						damage = lastUpgrade.damage * UnitServiceCore.calculate_static_stat_multiplier(unit, unit.xp, "damage")
					elseif lastUpgrade.health ~= nil then
						damage = lastUpgrade.health * UnitServiceCore.calculate_static_stat_multiplier(unit, unit.xp, "health")
						if unit.id == "eren_final" then
							damage = damage * 20
						end
					end
					local cooldown = 1
					if lastUpgrade.attack_cooldown then
						cooldown = lastUpgrade.attack_cooldown * UnitServiceCore.calculate_static_stat_multiplier(unit, unit.xp, "attack_cooldown")
					elseif unit.active_attack then
						cooldown = unit.active_attack_stats.attack_cooldown * UnitServiceCore.calculate_static_stat_multiplier(unit, unit.xp, "active_attack_cooldown")
					end
					if unit.id == "uryu" or unit.id == "uryu_evolved" then
						unitCap = unitCapOverride or 5
					end
					if unit.id == "starrk_evolved" then
						damage = damage + ((damage/3)/1.5)
					end
					local dpsUnit = (damage > 0 and cooldown > 0) and damage/cooldown or 0
					local dpsTotal = dpsUnit * unitCap
					table.insert(data, 
						{
							unit,
							dpsTotal,
							str = string.format(
								"%s \tDMG/cast: %d\tCD: %.1f\tDMG/s/cast: %d\tTotal DMG/s: %d",
								_G.StrFixedLength(string.format("%s at %d lvl %s x%s", unitData.name, UnitServiceCore:calculate_level(unit.xp), (dominantTrait ~= nil and " [" .. dominantTrait .. "]" or ""), tostring(unitCap)), 45),
								damage, cooldown, dpsUnit, dpsTotal
							)
						}
					)
				end
			end
			table.sort(data, function(a, b)
				return a[2] < b[2]
			end)
			local strings = {}
			for k,v in pairs(data) do
				table.insert(strings, v.str)
			end
			setclipboard(table.concat(strings, "\n"))
		end
		
		local forceMaxLevel = category:AddCheckbox("Force Max Level (100)")
		local uniqueTraitCheck = category:AddCheckbox("With Unique Trait")
		local doubleTraitCheck = category:AddCheckbox("x2 Trait")
		
		category:AddButton("Log All Units Ranking", function()
			local units = {}
			for k,v in pairs(Units) do
				table.insert(units, {
					uuid = v.uuid,
					unit_id = v.id
				})
			end
			GatherDataForUnits(units, uniqueTraitCheck.Checked and 1 or nil, doubleTraitCheck.Checked, forceMaxLevel.Checked)
		end)
		category:AddButton("Log Owned Units Ranking", function()
			local units = {}
			for k,v in pairs(_G.session_data.collection.collection_profile_data.owned_units) do
				table.insert(units, {
					uuid = v.uuid,
					traits = v.traits,
					xp = v.xp,
					unit_id = v.unit_id,
					trait_stats = v.trait_stats,
					further_modifiers = v.further_modifiers
				})
			end
			setclipboard(_G.Discover(units))
			--GatherDataForUnits(units, uniqueTraitCheck.Checked and 1 or nil, doubleTraitCheck.Checked, forceMaxLevel.Checked)
		end)
		category:AddButton("Log Equipped Units Ranking", function()
			local equipped = {}
			for k,v in pairs(_G.session_data.collection.collection_profile_data.equipped_units) do
				equipped[v] = true
			end
			local units = {}
			for k,v in pairs(_G.session_data.collection.collection_profile_data.owned_units) do
				if equipped[v.uuid] then
					table.insert(units, {
						uuid = v.uuid,
						traits = v.traits,
						xp = v.xp,
						unit_id = v.unit_id,
						trait_stats = v.trait_stats,
						further_modifiers = v.further_modifiers
					})
				end
			end
			GatherDataForUnits(units, uniqueTraitCheck.Checked and 1 or nil, doubleTraitCheck.Checked, forceMaxLevel.Checked)
		end)
	end
end

function module.Shutdown()
	moduleOn = false
	for k,v in pairs(OVERHEADS) do
		if v then
			if v.guis then
				for _, gui in pairs(v.guis) do
					gui:Destroy()
				end
			end
			if v.conns then
				for _, conn in pairs(v.conns) do
					if conn then
						conn:Disconnect()
					end
				end
			end
		end
	end
end

return module