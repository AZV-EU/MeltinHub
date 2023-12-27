local module = {
	GameName = "Project Slayers",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer
if not plr then return end
local mouse = plr:GetMouse()

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local playerScripts, smallScripts
if not game.Workspace:FindFirstChild("Is_Customization_place") then
	playerScripts = plr:WaitForChild("PlayerScripts")
	smallScripts = playerScripts:WaitForChild("Small_Scripts")
end

local muzanPointer

local moduleOn = true

local function destroyConnection(conn)
	if conn then
		for k,v in pairs(getconnections(conn)) do
			v:Disable()
		end
	end
end
local function repairConnection(conn)
	if conn then
		for k,v in pairs(getconnections(conn)) do
			v:Enable()
		end
	end
end

local function DestroyConnections(target)
	if not target then return end
	destroyConnection(target.Changed)
	destroyConnection(target:GetPropertyChangedSignal("Parent"))
	destroyConnection(target:GetPropertyChangedSignal("Name"))
	if target:IsA("LocalScript") then
		destroyConnection(target:GetPropertyChangedSignal("Disabled"))
	end
	return target
end

local function findNearestToMousePoint()
	local closest, closestDistance = nil, 0
	local mousePos = Vector2.new(mouse.X, mouse.Y)
	local validTargets = {}
	for k,v in pairs(game.Players:GetPlayers()) do
		if v ~= plr then
			table.insert(validTargets, v.Character)
		end
	end
	for k,v in pairs(game.Workspace.Mobs:GetDescendants()) do
		if v:IsA("Model") and v:FindFirstChildWhichIsA("Humanoid") then
			table.insert(validTargets, v)
		end
	end
	for k,v in pairs(validTargets) do
		local head = v:FindFirstChild("Head")
		local humanoid = v:FindFirstChild("Humanoid")
		if head and humanoid and humanoid.Health > 0 and plr:DistanceFromCharacter(head.Position) < 300 then
			local pos = game.Workspace.CurrentCamera:WorldToScreenPoint(head.Position)
			if pos.Z > 0 then
				local targetPos = Vector2.new(pos.X, pos.Y)
				local distance = (targetPos - mousePos).Magnitude
				if not closest or distance < closestDistance then
					closest = v
					closestDistance = distance
				end
			end
		end
	end
	return closest
end

function module.Init(category, connections)
	do
		if game.Workspace:FindFirstChild("Is_Customization_place") then
			DestroyConnections(plr.PlayerScripts:WaitForChild("Client_Global_utility")).Disabled = true
		else
			DestroyConnections(smallScripts:WaitForChild("Client_Global_utility")).Disabled = true
			DestroyConnections(smallScripts:WaitForChild("client_global_delete_script")).Disabled = true
			plr.PlayerScripts:WaitForChild("Ragdoll_Client").Disabled = true
		end
		
		for k,v in pairs(game.ReplicatedStorage:GetDescendants()) do
			DestroyConnections(v)
		end
		
		do -- take care of Client_Global_Utility stuff
			game.ReplicatedStorage.Remotes:WaitForChild("getclientping").OnClientInvoke = function()
				return true
			end
			
			getrenv()._G.Skills_Performance = function(p6, p7, p8)
				game.ReplicatedStorage.Remotes.To_Server.Handle_Initiate_S:FireServer("skil_ting_asd", game.Players.LocalPlayer, p6, p8)
			end
			
			getrenv()._G.asdasd2123123 = function() end
			
			getrenv()._G.asda123123sddd = true
			game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("greenlight_to_start_new_combo").OnClientEvent:Connect(function()
				getrenv()._G.asda123123sddd = true
			end)
			function add_to_text(p1)
				local v1 = nil
				v1 = math.random(1, 26)
				if math.random(1, 2) == 2 then

				else
					p1 = p1 .. string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZ", v1, v1)
					return p1
				end
				p1 = p1 .. string.lower((string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZ", v1, v1)))
				return p1
			end;
			getrenv()._G.generateid = function()
				local v2 = nil
				v2 = add_to_text("")
				if math.random(1, 2) == 1 then
					local v3 = v2 .. tostring(math.random(1, 9))
				else
					v3 = add_to_text(v2)
				end;
				local v4 = add_to_text(v3)
				if math.random(1, 2) == 1 then
					local v5 = v4 .. tostring(math.random(1, 9))
				else
					v5 = add_to_text(v4)
				end;
				local v6 = add_to_text(v5)
				if math.random(1, 2) == 1 then
					local v7 = v6 .. tostring(math.random(1, 9))
				else
					v7 = add_to_text(v6)
				end;
				local v8 = add_to_text(v7)
				if math.random(1, 2) ~= 1 then
					return add_to_text(v8)
				end
				return v8 .. tostring(math.random(1, 9))
			end
			
			local v9 = require(game.ReplicatedStorage.Modules.Client:WaitForChild("character_handler"));
			local l__UserInputService__10 = game:GetService("UserInputService");
			
			wait_before_reset_time = 1.5
			if getrenv()._G.Combo == nil then
				getrenv()._G.aircombo = false
				l__UserInputService__10.InputBegan:Connect(function(p2, p3)
					if p3 == false and p2.KeyCode == Enum.KeyCode.Space and getrenv()._G.Combo.Value < 5 and tick() - v9.lastpunched <= 0.5 then
						getrenv()._G.aircombo = true
					end
				end)
				l__UserInputService__10.InputBegan:Connect(function(p4, p5)
					if p4.KeyCode == Enum.KeyCode.Space then
						getrenv()._G.aircombo = false
					end
				end)
				getrenv()._G.Combo = game.Lighting:FindFirstChild("ComboIntValue") or Instance.new("IntValue", game.Lighting)
				getrenv()._G.Combo.Name = "ComboIntValue"
				getrenv()._G.Combo.Value = 1
				getrenv()._G.Combo.Changed:Connect(function()
					if getrenv()._G.Combo ~= nil and getrenv()._G.Combo.Value ~= "" then
						local u2 = false
						local v11 = getrenv()._G.Combo.Changed:Connect(function()
							u2 = true
						end)
						task.wait(wait_before_reset_time)
						v11:Disconnect()
						if u2 == false then
							getrenv()._G.Combo.Value = 1
							getrenv()._G.aircombo = false
						end
					end
				end)
			end
			
			Mouse = game.Players.LocalPlayer:GetMouse()
			local v28 = require(game.ReplicatedStorage.Modules.Global.Utility)
			local l__Players__29 = game.Players
			local v30 = RaycastParams.new()
			v30.FilterType = Enum.RaycastFilterType.Blacklist
			local l__CollectionService__7 = game:GetService("CollectionService")
			local l__CurrentCamera__8 = workspace.CurrentCamera
			getrenv()._G.getmousepos = function(p12, p13, p14, p15, p16, p17)
				local v31 = nil
				v30.FilterDescendantsInstances = p15 or { game.Players.LocalPlayer.Character, workspace.Debree, l__CollectionService__7:GetTagged("Ignore") };
				if p16 ~= nil then
					v30.FilterType = p16;
				else
					v30.FilterType = Enum.RaycastFilterType.Blacklist;
				end;
				local v32 = Mouse.X;
				local v33 = Mouse.Y;
				if getrenv()._G.is_mobile ~= nil and getrenv()._G.is_mobile() == true and getrenv()._G.currentmobilemousepos ~= nil then
					v32 = getrenv()._G.currentmobilemousepos[1] - getrenv()._G.mobileskillthingoffset[1]
					v33 = getrenv()._G.currentmobilemousepos[2] - getrenv()._G.mobileskillthingoffset[2]
					if getrenv()._G.mouseiconthingg ~= nil then
						getrenv()._G.mouseiconthingg.Value = Vector3.new(v32, v33, 0)
					end;
				end;
				local v34 = l__CurrentCamera__8:ScreenPointToRay(v32, v33);
				local v35 = p14 or v34.Origin;
				local v36 = v34.Direction * 100000;
				local v37 = nil;
				local v38 = nil;
				local v39 = nil;
				local v40 = workspace:Raycast(v35, v36, v30);
				if v40 ~= nil and v40.Position ~= nil then
					v38 = v40.Position;
					v39 = v40.Normal;
					if v40.Instance ~= nil then
						v37 = v40.Instance;
					end;
				end;
				if v38 == nil then
					v38 = v35 + v36;
				end;
				local v41 = v35;
				if p17 ~= nil then
					v41 = p17;
				end;
				v31 = v41 + CFrame.new(v41, v38).LookVector * math.clamp((v41 - v38).Magnitude, 0, p12 and 500);
				if p13 ~= true then
					return v31;
				end;
				return v31, v37, v39;
			end;
			getrenv()._G.Completed_Excersie = function(p18)
				if p18 ~= nil and game.Players.LocalPlayer ~= nil and game.Players.LocalPlayer.Character ~= nil then
					local l__HumanoidRootPart__42 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
					if l__HumanoidRootPart__42 ~= nil then
						smallScripts:WaitForChild("Client_Global_utility").Event:Fire(l__HumanoidRootPart__42.Position - Vector3.new(0, 3, 0), l__HumanoidRootPart__42.Position + Vector3.new(0, 7, 0), p18)
					end
				end
			end;
			ma = math.abs;
			getrenv()._G.CheckQuest = function(p19, p20)
				local v43 = false;
				local v44 = game.ReplicatedStorage.Player_Data:FindFirstChild(game.Players.LocalPlayer.Name);
				if v44 ~= nil then
					local l__Quest__45 = v44:FindFirstChild("Quest");
					if (tonumber(#l__Quest__45.Current.Value) == 0 or tonumber(#l__Quest__45.Current.Value) == nil) and (typeof(p20) == "number" and p20 or 30) <= ma(os.time() - tonumber(l__Quest__45.Last_Did_A_Quest.Value)) then
						return true;
					end;
					if tonumber(#l__Quest__45.Current.Value) == 0 or tonumber(#l__Quest__45.Current.Value) == nil then
						return "ahsdacoldownasd";
					else
						v43 = "cantdoquestbecvausealreadydoingone";
					end;
				end;
				return v43;
			end;
			getrenv()._G.CheckQuestNoCooldown = function(p21, p22)
				local v46 = nil;
				local v47 = false;
				local v48 = game.ReplicatedStorage.Player_Data:FindFirstChild(game.Players.LocalPlayer.Name);
				if v48 ~= nil then
					local l__Quest__49 = v48:FindFirstChild("Quest");
					if tonumber(#l__Quest__49.Current.Value) ~= 0 and tonumber(#l__Quest__49.Current.Value) ~= nil and (p22 == nil or l__Quest__49.Current.Value ~= p22) then
						v47 = "cantdoquestbecvausealreadydoingone";
						v46 = v47;
						return v46;
					end;
				else
					v46 = v47;
					return v46;
				end;
				return true;
			end;
			if getrenv()._G.Air_Combo == nil then
				getrenv()._G.Air_Combo = Instance.new("IntValue");
				getrenv()._G.Air_Combo.Value = 1;
				local u9 = "";
				getrenv()._G.Air_Combo.Changed:Connect(function()
					if getrenv()._G.Air_Combo ~= nil and getrenv()._G.Air_Combo.Value ~= 1 then
						local v50 = getrenv()._G.generateid();
						u9 = v50;
						wait(1);
						if u9 == v50 then
							getrenv()._G.Air_Combo.Value = 1;
						end;
					end;
				end);
			end;
		end
		
		--[[
		for k,v in pairs(plr.PlayerScripts:GetDescendants()) do
			if v:IsA("LocalScript") and not v.Disabled and not v.Name == "Ragdoll_Client" then
				destroyConnection(v.Changed)
				v.Disabled = true
				v.Disabled = false
			end
		end
		]]
		
		for k,v in pairs(plr.PlayerGui:GetChildren()) do
			if v:IsA("ScreenGui") then
				for k,v in pairs(v:GetDescendants()) do
					if v:IsA("LocalScript") and not v.Disabled then
						destroyConnection(v.Changed)
						--[[v.Disabled = true
						v.Disabled = false
						for k,x in pairs(v:GetDescendants()) do
							if x:IsA("IntValue") or x:IsA("BoolValue") or x:IsA("StringValue") then
								x:Destroy()
							end
						end]]
					end
				end
			end
		end
		
		if game.Workspace:FindFirstChild("Is_Customization_place") then
			
		else
			local targets = {
				game.ReplicatedStorage:WaitForChild("fullnametangasddeletethisifuwanthackerlol"),
				game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("blockasodjasdn123"),
				game.ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("hackgamesystemasd123123"),
				game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("client_quest_add_check"),
				game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("skill_proof_checker")
			}
			for k, t in pairs(targets) do
				if t then
					destroyConnection(t.OnClientEvent)
				end
			end
		end
		
		local hg = game.ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("hackgamesystemasd123123")
		if hg then
			hg:Destroy()
		end
		
		_G.Notify("Anti-Cheats have been hijacked.", "Anti-Cheat Hijack")
	end
	
	if not getrenv()._G.Skills_Performance then
		getrenv()._G.Skills_Performance = function()
		end
	end
	
	-- GLOBALS
	
	local characterHandler = require(game.ReplicatedStorage.Modules.Client:WaitForChild("character_handler"))
	local playerValues = game.ReplicatedStorage:WaitForChild("PlayerValues"):WaitForChild(plr.Name)
	local playerData = game.ReplicatedStorage:WaitForChild("Player_Data"):WaitForChild(plr.Name)
	
	_G.MeltinHub_ValidAllyCheck = function(target)
		if target:IsA("Player") then
			local values = game.ReplicatedStorage.PlayerValues:WaitForChild(target.Name)
			local data = game.ReplicatedStorage.Player_Data:WaitForChild(target.Name)
			if data then
				return values:FindFirstChild("in_safe_zone") or data.Race == playerData.Race
			end
		end
		return false
	end
	
	if game.Workspace:FindFirstChild("Is_Customization_place") then -- customization menu
		if game.PlaceId == 5956785391 then
			local spinBtn = category:AddButton("Quick spin", function()
				local success, res = game.ReplicatedStorage.Remotes.To_Server.Handle_Initiate_S_:InvokeServer("check_can_spin")
				if success then
					warn("Spin new clan: " .. tostring(res))
				else
					warn("No more spins.")
				end
			end)
		end
	else -- begin gameplay place
	
	local autoFarmCheck
	
	if game.PlaceId ~= 7447158459 and game.PlaceId ~= 9366093452 then -- Auto-farm
		local autofarmCategory = _G.SenHub:AddCategory("Auto-farm")
		local targetLabel = autofarmCategory:AddLabel("Shift+T to select target at mouse")
		autoFarmCheck = autofarmCategory:AddCheckbox("Auto-farm")
		local target = nil
		
		local bosses = {}
		local bossNames = {}
		for k,v in pairs(game.Workspace:WaitForChild("Mobs"):WaitForChild("Bosses"):GetDescendants()) do
			if v:IsA("ModuleScript") and v.Name == "Npc_Configuration" then
				local config = require(v)
				bosses[config.Name] = v.Parent
				table.insert(bossNames, config.Name)
			end
		end
		
		local function GetSpawnPosFor(bossName)
			local config = require(bosses[bossName].Npc_Configuration)
			return config.Npc_Spawning.Spawn_Locations[1] or Vector3.new(0, 0, 0)
		end
		local bossSpawnPos = GetSpawnPosFor(bossNames[1])
		
		local autoFarmBoss
		autoFarmBoss = autofarmCategory:AddDropdown("Auto-farm Boss", bossNames, 1, function()
			bossSpawnPos = GetSpawnPosFor(autoFarmBoss.SelectedOption)
			target = nil
		end)
		
		do
			local human, root, myRoot, myHuman, tool, holderPos
			local inCombat = false
			local canAttack = false
			local fch = 0
			local lastpunch = tick()
			local attacking = false
			local delta = 1/60
			game:GetService("RunService"):BindToRenderStep("main_loop", Enum.RenderPriority.Camera.Value - 1, function(deltaTime)
				if target then
					inCombat = autoFarmCheck.Checked or UserInputService:IsKeyDown(Enum.KeyCode.V)
					
					tool = plr.Character:FindFirstChildWhichIsA("Tool")
					myRoot = plr.Character:FindFirstChild("HumanoidRootPart")
					myHuman = plr.Character:FindFirstChildWhichIsA("Humanoid")
					
					human = target:FindFirstChildWhichIsA("Humanoid")
					root = target:FindFirstChild("HumanoidRootPart")
					
					if myRoot and myHuman and human and human.Health > 0 and root then
						
						if plr:DistanceFromCharacter(root.Position) < 400 then
							if inCombat then
							
								if tool then
									
									canAttack = getrenv()._G.combaten == false-- and tick() - lastpunch > 0.3
									if getrenv()._G.Combo then
										if getrenv()._G.Combo.Value <= 1 then
											if plr:FindFirstChild("combotangasd123") then
												if plr.combotangasd123.Value > 0 then
													canAttack = false
												end
											end
										end
									end
									
									if canAttack then
										myRoot.CFrame = CFrame.new((root.Position + (root.AssemblyLinearVelocity * delta)) + Vector3.new(0, 1, 0), root.Position)
										if not attacking then
											attacking = true
											wait(0.05)
											getrenv()._G.Combo.Value = 1
											for i = 1, 5 do
												if getrenv()._G.Combo.Value < 5 then
													getrenv()._G.Combo.Value += 1
												else
													getrenv()._G.Combo.Value = 1
												end
												fch = getrenv()._G.Combo.Value
												if fch >= 5 then
													fch = 919
												end
												if tool:FindFirstChild("CombatIsEquiped") then
												
													if i <= 4 then
														if plr.Character:FindFirstChild("Tamari_Arms") ~= nil then
															local anim = myHuman:LoadAnimation(game.ReplicatedStorage.Animations.Tamari_Arms.Hits.Left:FindFirstChild(i))
															anim:AdjustSpeed(3)
															anim:Play()
															local anim2 = plr.Character.Tamari_Arms.Animator:LoadAnimation(game.ReplicatedStorage.Animations.Tamari_Arms.Hits.Left:FindFirstChild(i))
															anim2:AdjustSpeed(3)
															anim2:Play()
														else
															local anim = myHuman:LoadAnimation(game.ReplicatedStorage.Animations.Combat.Hits.Left:FindFirstChild(i));
															anim:AdjustSpeed(3)
															anim:Play()
														end
													end
													
													coroutine.resume(coroutine.create(function()
														getrenv()._G:Initiate_C2("fist_combat_handler", fch)
													end))
													getrenv()._G:Initiate_C("Play_Sound", myRoot, game.ReplicatedStorage.Sounds.Sword.Rapid_Swing, nil, nil)
													coroutine.resume(coroutine.create(function()
														game.ReplicatedStorage.Remotes.To_Server.Handle_Initiate_S_:InvokeServer("fist_combat", plr, plr.Character, myRoot, myHuman, fch)
													end))
												elseif tool:FindFirstChild("SwordIsEquiped") then
													if i <= 4 then
														local anim = myHuman:LoadAnimation(game.ReplicatedStorage.Animations.Sword.Hits.Left:FindFirstChild(i));
														anim:AdjustSpeed(3);
														anim:Play();
													end
													getrenv()._G:Initiate_C("Play_Sound", myRoot, game.ReplicatedStorage.Sounds.Sword.SwingSharp, nil, nil)
													coroutine.resume(coroutine.create(function()
														game.ReplicatedStorage.Remotes.To_Server.Handle_Initiate_S_:InvokeServer("Sword_Combat_Slash", plr, plr.Character, myRoot, myHuman, fch)
													end))
													coroutine.resume(coroutine.create(function()
														getrenv()._G:Initiate_C2("sword_combat_handler", fch)
													end))
												end
												wait(0.05)
											end
											wait(0.2)
											attacking = false
										end
									else
										myRoot.CFrame = CFrame.new(root.Position + Vector3.new(0, 30, 0), root.Position)
									end
								else
									myRoot.CFrame = CFrame.new(root.Position + Vector3.new(0, 30, 0), root.Position)
									attacking = false
								end
								myRoot.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
								myRoot.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
							end
						elseif autoFarmCheck.Checked then
							holderPos = holderPos + (root.Position - holderPos).Unit * 10
							myRoot.CFrame = CFrame.new(holderPos)
							myRoot.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
							myRoot.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
						else
							holderPos = myRoot.Position
						end
					else
						target = nil
					end
				else
					myRoot = plr.Character:FindFirstChild("HumanoidRootPart")
					if autoFarmCheck.Checked then
						if myRoot then
							if plr:DistanceFromCharacter(bossSpawnPos) > 300 then
								holderPos = holderPos + (bossSpawnPos - holderPos).Unit * 10
								myRoot.CFrame = CFrame.new(holderPos)
								myRoot.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
								myRoot.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
							else
								myRoot.CFrame = CFrame.new(bossSpawnPos + Vector3.new(0, 100, 0))
							end
						end
						target = bosses[autoFarmBoss.SelectedOption]:FindFirstChild(autoFarmBoss.SelectedOption)
						targetLabel.Text = "Target: " .. autoFarmBoss.SelectedOption
					else
						if myRoot then
							holderPos = myRoot.Position
						end
						targetLabel.Text = "Shift+T to select target at mouse"
					end
				end
			end)
		end
		
		table.insert(connections, UserInputService.InputBegan:Connect(function(input)
			if (not autoFarmCheck or not autoFarmCheck.Checked) and input.UserInputType == Enum.UserInputType.Keyboard and ((input.KeyCode == Enum.KeyCode.T and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)) or (input.KeyCode == Enum.KeyCode.LeftShift and UserInputService:IsKeyDown(Enum.KeyCode.T))) then
				target = findNearestToMousePoint()
				targetLabel.Text = target and "Target: " .. tostring(target.Name) or "Shift+T to select target at mouse"
				_G.SenHub:Update()
			end
		end))
	end
	
	do -- QUESTS
		local sourceScript, targetScript
		local function hijack()
			wait(1)
			sourceScript = game.Players.LocalPlayer.PlayerGui:WaitForChild("Npc_Dialogue"):WaitForChild("LocalScript")
			require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("quest_add_checker"))[sourceScript] = function(p)
				return true
			end
			require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("quest_add_checker2"))[sourceScript] = function(p)
				return true
			end
			
			targetScript = game.Players.LocalPlayer.PlayerScripts:WaitForChild("Small_Scripts"):WaitForChild("Ouwbih_gem_stone")
			require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("quest_add_checker"))[targetScript] = function(p)
				return true
			end
		end
		spawn(hijack)
		local questFolder = playerData.Quest
		
		local autoCompleteGemstoneQuest = category:AddButton("Auto-complete gemstone quest", function()
			local osTime = os.clock()
			game.ReplicatedStorage.Remotes.To_Server.Handle_Initiate_S:FireServer("AddQuest", sourceScript.Functions:GetFullName(), osTime, questFolder, {
				Current = "Find Betty's missing gem stone", 
				List = { {
						Name = "Find missing gem stone", 
						Progress = { 0, 1 }
					} }
			})
			wait(.1)
			
			getrenv()._G.fullnames[targetScript:GetFullName()] = osTime
			game.ReplicatedStorage.Remotes.To_Server.Handle_Initiate_S:FireServer("Quest_add", targetScript:GetFullName(), osTime, {}, plr, "done_betty_gem_quest")
		end)
		table.insert(connections, plr.CharacterAdded:Connect(hijack))
	end
	
	do -- Auto-Collect & Misc Functions
		local autoCollectCheck = category:AddCheckbox("Auto-collect chests")
		autoCollectCheck:SetChecked(true)
		
		table.insert(connections, game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("spawn_chest_asd123").OnClientEvent:Connect(function(chest)
			if autoCollectCheck.Checked then
				wait(1)
				for k,v in pairs(chest.Drops:GetChildren()) do
					if v:IsA("StringValue") then
						_G.Notify("Auto-collecting from chest: '" .. tostring(v.Name) .. "'", "Auto-collect")
						chest.Add_To_Inventory:InvokeServer(v.Name)
					end
				end
			end
		end))
		
		local autoClashCheck = category:AddCheckbox("Auto-win clashes")
		do -- auto-clash
			autoClashCheck:SetChecked(true)
			local clashFolder = game.ReplicatedStorage:WaitForChild("Misc"):WaitForChild("Clashing")
			
			table.insert(connections, clashFolder.ChildAdded:Connect(function()
				if not autoClashCheck.Checked then return end
				local myClash = clashFolder:FindFirstChild(plr.Name)
				if myClash then
					local myPoints = myClash:FindFirstChild("Points")
					if myPoints then
						spawn(function()
							local newValue
							while autoClashCheck.Checked and myPoints.Value < myPoints.MaxValue do
								newValue = math.clamp(myPoints.Value + 1, 0, myPoints.MaxValue)
								game.ReplicatedStorage.Remotes.To_Server.Handle_Initiate_S:FireServer("Change_Value", myPoints, newValue)
								if newValue == myPoints.MaxValue then break end
								wait(math.random(0.3, 0.8))
							end
						end)
					end
				end
			end))
		end
	
		category:AddButton("Reset Health to 0", function()
			plr.Character.Humanoid.Health = 0
		end)
		
		category:AddButton("Repair sword", function()
			if not playerData then return end
			local swordTag = plr.Character:FindFirstChild("SwordIsEquiped", true)
			if swordTag then
				local sword = swordTag.Parent
				local swordId = sword:FindFirstChild("Id")
				if swordId then
					local properties = playerData.Custom_Properties:FindFirstChild(swordId.Value)
					if properties and properties:FindFirstChild("Health") and properties.Health["1"].Value < properties.Health["2"].Value then
						game.ReplicatedStorage.Remotes.To_Server.Handle_Initiate_S:FireServer("repairsword", playerData.Yen, properties:FindFirstChild("Health"), 1)
					end
				end
			end
		end)
		
		category:AddButton("Enable Safe Zone", function()
			local safeZoneEvent = plr.PlayerGui:FindFirstChild("Pop_Ups"):FindFirstChild("Safe_Zone_Script"):FindFirstChild("RemoteEvent")
			if safeZoneEvent then
				safeZoneEvent:FireServer(true)
			end
		end).Inline = true
		
		category:AddButton("Disable Safe Zone", function()
			local safeZoneEvent = plr.PlayerGui:FindFirstChild("Pop_Ups"):FindFirstChild("Safe_Zone_Script"):FindFirstChild("RemoteEvent")
			if safeZoneEvent then
				safeZoneEvent:FireServer(false)
			end
		end)
	end
	
	do -- Augments
		local augments = _G.SenHub:AddCategory("Augments")
		
		---- AUGMENTED WEAPONRY
		
		local function HijackWeapon(tool)
			spawn(function()
				wait(1)
				if tool:IsA("Tool") then
					if tool:FindFirstChild("CombatIsEquiped") or
						tool:FindFirstChild("SwordIsEquiped") then
						for k,v in pairs(tool:GetChildren()) do
							if v:IsA("LocalScript") and v.Name ~= "LocalScript" then
								v.Disabled = true
							end
						end
					end
				end
			end)
		end
		for k,v in pairs(plr.Backpack:GetChildren()) do
			HijackWeapon(v)
		end
		if plr.Character then
			for k,v in pairs(plr.Character:GetChildren()) do
				HijackWeapon(v)
			end
		end
		local oldConn = plr.Backpack.ChildAdded:Connect(HijackWeapon)
		table.insert(connections, plr.CharacterAdded:Connect(function()
			if oldConn then
				oldConn:Disconnect()
			end
			oldConn = plr.Backpack.ChildAdded:Connect(HijackWeapon)
			table.insert(connections, oldConn)
		end))
		
		local lastcombo = tick()
		local targetCombo = "LRLRL"
		if getrenv()._G.ComboValue == nil then
			getrenv()._G.ComboValue = Instance.new("StringValue")
		end
		table.insert(connections, RunService.RenderStepped:Connect(function()
			if (not autoFarmCheck or not autoFarmCheck.Checked) and plr.Character and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
				local tool = plr.Character:FindFirstChildWhichIsA("Tool")
				local myHuman, myRoot = plr.Character:FindFirstChildWhichIsA("Humanoid"),
					plr.Character:FindFirstChild("HumanoidRootPart")
				if tool and myHuman and myRoot then
					if tool then
						local CombatIsEquiped = tool:FindFirstChild("CombatIsEquiped")
						local SwordIsEquiped = tool:FindFirstChild("SwordIsEquiped")
						if CombatIsEquiped or SwordIsEquiped then
							if tick() - lastcombo >= 1.5 then
								getrenv()._G.Combo.Value = 1
							end
							local canAttack = characterHandler:Check("combat") == true and tick() - lastcombo >= 0.21
							if getrenv()._G.Combo then
								if getrenv()._G.Combo.Value <= 1 then
									if plr:FindFirstChild("combotangasd123") then
										if plr.combotangasd123.Value > 0 then
											canAttack = false
										end
									end
								end
							end
							
							if canAttack then
								local i = getrenv()._G.Combo.Value or 1
								getrenv()._G.ComboValue.Value = targetCombo:sub(1, i)
								local fch = i > 4 and 919 or i
								if CombatIsEquiped then
									if fch <= 4 then
										if plr.Character:FindFirstChild("Tamari_Arms") ~= nil then
											local anim = myHuman:LoadAnimation(game.ReplicatedStorage.Animations.Tamari_Arms.Hits.Left:FindFirstChild(fch))
											anim:AdjustSpeed(1.25)
											anim:Play()
											local anim2 = plr.Character.Tamari_Arms.Animator:LoadAnimation(game.ReplicatedStorage.Animations.Tamari_Arms.Hits.Left:FindFirstChild(fch))
											anim2:AdjustSpeed(1.25)
											anim2:Play()
										else
											local anim = myHuman:LoadAnimation(game.ReplicatedStorage.Animations.Combat.Hits.Left:FindFirstChild(fch));
											anim:AdjustSpeed(1.25)
											anim:Play()
										end
									end
									
									spawn(function()
										getrenv()._G.skilleffectmodules.fist_combat_handler(fch)
									end)
									--[[
									getrenv()._G:Initiate_C("Play_Sound", myRoot, game.ReplicatedStorage.Sounds.Sword.Rapid_Swing, nil, nil)
									coroutine.resume(coroutine.create(function()
										game.ReplicatedStorage.Remotes.To_Server.Handle_Initiate_S_:InvokeServer("fist_combat", plr, plr.Character, myRoot, myHuman, fch)
									end))
									]]
								elseif SwordIsEquiped then
									if fch <= 4 then
										local anim = myHuman:LoadAnimation(game.ReplicatedStorage.Animations.Sword.Hits.Left:FindFirstChild(fch));
										anim:AdjustSpeed(1.25);
										anim:Play();
									end
									--[[
									getrenv()._G:Initiate_C("Play_Sound", myRoot, game.ReplicatedStorage.Sounds.blood_burst_fury["Sound" .. tostring(i)], nil, nil)
									]]
									local lastDamaged = playerValues:FindFirstChild("LastDamagedSomeone") and game.Workspace.Server_Age.Value + 1000 - tonumber(playerValues.LastDamagedSomeone.Value) < 0.6
									if i < 5 or (i >= 5 and (getrenv()._G.air_combo_en or not lastDamaged)) then
										getrenv()._G.skilleffectmodules.sword_combat_handler(fch)
										--[[
										coroutine.resume(coroutine.create(function()
											game.ReplicatedStorage.Remotes.To_Server.Handle_Initiate_S_:InvokeServer("Sword_Combat_Slash", plr, plr.Character, myRoot, myHuman, fch)
										end))
										coroutine.resume(coroutine.create(function()
											getrenv()._G:Initiate_C2("sword_combat_handler", fch)
										end))
										]]
									elseif i == 5 and lastDamaged and getrenv()._G.air_combo_en == false and not UserInputService:IsKeyDown(Enum.KeyCode.C) then
										getrenv()._G.air_combo_en = true
										getrenv()._G.previouslydidcomboasd123 = tick()
										myHuman:LoadAnimation(game.ReplicatedStorage.Animations.Insect_Sword.Air_Combo.Slash1):Play()
										spawn(function()
											if getrenv()._G.skilleffectmodules ~= nil then
												if getrenv()._G.skilleffectmodules.fist_combat_handler then
													getrenv()._G.skilleffectmodules.fist_combat_handler(19, true)
												end
											end
											wait(0.21)
											getrenv()._G.air_combo_en = false
										end)
									end
								end
								if getrenv()._G.Combo.Value < 5 then
									getrenv()._G.Combo.Value += 1
								else
									getrenv()._G.Combo.Value = 1
								end
								lastcombo = tick()
							end
						end
					end
				end
			end
		end))
		
		---- AUGMENTED SKILLS
		local originalPowers = game.StarterGui:WaitForChild("Power_Adder")
		
		local fasterCooldowns
		
		local function updateCooldowns(reset)
			local powers = plr.PlayerGui:WaitForChild("Power_Adder")
			wait(2)
			for k,v in pairs(powers:GetDescendants()) do
				if v.Name == "CoolDown" then
					local original = originalPowers:FindFirstChild(v.Parent.Name, true)
					if original then
						v.Value = reset and original.CoolDown.Value or (game.PlaceId == 9366093452 and original.CoolDown.Value / 1.25 or original.CoolDown.Value / 2)
					end
				end
			end
		end
		
		fasterCooldowns = augments:AddCheckbox("Faster Cooldowns", function(state)
			spawn(function() updateCooldowns(not state) end)
		end)
		fasterCooldowns:SetChecked(game.PlaceId ~= 9366093452)
		
		table.insert(connections, plr.CharacterAdded:Connect(updateCooldowns))
		
		local infiniteStamina = augments:AddCheckbox("Infinite Stamina", function(state)
			if state then
				_G.IndexEmulator:SetKeyValue(playerValues:WaitForChild("Stamina"), "Value", playerValues:WaitForChild("Stamina").MaxValue)
			else
				_G.IndexEmulator:DeleteKey(playerValues:WaitForChild("Stamina"), "Value")
			end
		end)
		infiniteStamina:SetChecked(true)
		local infiniteBreath = augments:AddCheckbox("Infinite Breath", function(state)
			if state then
				_G.IndexEmulator:SetKeyValue(playerValues:WaitForChild("Breath"), "Value", playerValues:WaitForChild("Breath").MaxValue)
			else
				_G.IndexEmulator:DeleteKey(playerValues:WaitForChild("Breath"), "Value")
			end
		end)
		infiniteBreath:SetChecked(true)
		local noRagdoll = augments:AddCheckbox("No Ragdoll")
		noRagdoll:SetChecked(game.PlaceId ~= 9366093452)
		
		local function standup(character)
			local human = character:WaitForChild("Humanoid")
			human:ChangeState(Enum.HumanoidStateType.Landed)
			table.insert(connections, human.StateChanged:Connect(function(oldState, newState)
				if noRagdoll.Checked and newState == Enum.HumanoidStateType.Physics then
					human:ChangeState(Enum.HumanoidStateType.Landed)
				end
			end))
		end
		--standup(plr.Character)
		table.insert(connections, plr.CharacterAdded:Connect(standup))
		
		do -- Godspeed and heal powers
			_G.LastSuperPowersUse = _G.LastSuperPowersUse or 0
			local superpowerswordconn
			
			function togglePowers(safetyBypass)
				local root = plr.Character:FindFirstChild("HumanoidRootPart")
				if not root then return end
				local power = playerData:FindFirstChild("Power")
				if not power or not power.Value == "Thunder" then return end
				local isOn = root:FindFirstChild("thundergodglow")
				
				if not isOn and tick() - _G.LastSuperPowersUse > 25 then
					--game.ReplicatedStorage.Remotes.thundertang123:FireServer(true)
					if safetyBypass or game.PlaceId ~= 9366093452 then
						game.ReplicatedStorage.Remotes.heal_tang123asd:FireServer(true)
						for i = 1, 3 do
							getrenv()._G:Initiate_C("Demon_Scream_Effect", root)
							getrenv()._G:Initiate_C("thunder_clap_six_fold_eff", root.CFrame)
						end
						for k,v in pairs(game.Players:GetPlayers()) do
							if v ~= plr and v.Character then
								local human, targetRoot =
									v.Character:FindFirstChildWhichIsA("Humanoid"),
									v.Character:FindFirstChild("HumanoidRootPart")
								if human and targetRoot and plr:DistanceFromCharacter(targetRoot.Position) < 40 then
									spawn(function()
										getrenv()._G:Initiate_C("change_state", human, "Physics")
										getrenv()._G:Initiate_C("set_velocity", targetRoot, ((root.Position + Vector3.new(0, -3, 0)) - targetRoot.Position).Unit * -100)
										wait(2)
										getrenv()._G:Initiate_C("change_state", human, "Jumping")
									end)
								end
							end
						end
						getrenv()._G:Initiate_C("sword_trail_eff_for_flame", plr.Character, true)
						spawn(function()
							while wait(1) do
								if moduleOn and root:FindFirstChild("thundergodglow") then
									local blade = plr.Character:FindFirstChild("Blade", true)
									if blade and not blade:FindFirstChild("swordt1flame", true) then
										getrenv()._G:Initiate_C("sword_trail_eff_for_flame", plr.Character, true)
									end
								else
									getrenv()._G:Initiate_C("sword_trail_eff_for_flame", plr.Character, false)
									break
								end
							end
						end)
					end
					isOn = true
					_G.LastSuperPowersUse = tick()
				elseif isOn and tick() - _G.LastSuperPowersUse > 1 then
					game.ReplicatedStorage.Remotes.thundertang123:FireServer(false)
					game.ReplicatedStorage.Remotes.heal_tang123asd:FireServer(false)
					getrenv()._G:Initiate_C("sword_trail_eff_for_flame", plr.Character, false)
					if superpowerswordconn then
						superpowerswordconn:Disconnect()
					end
					superpowerswordconn = nil
					isOn = false
					_G.LastSuperPowersUse = tick()
				end
			end
			
			local superPowersBtn = augments:AddButton("Thunder Super-powers [F5]", togglePowers)
			
			table.insert(connections, UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.Keyboard and (input.KeyCode == Enum.KeyCode.F5 or input.KeyCode == Enum.KeyCode.F6) and not UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
					togglePowers(input.KeyCode == Enum.KeyCode.F6)
				end
			end))
		end
		
		-- Select clan
		
		do
			local clanNames = {}
			local clanPerks = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Global"):WaitForChild("Clan_Perks")).clan_perks
			local myClan = playerData:WaitForChild("Clan").Value
			for k,v in pairs(clanPerks) do
				table.insert(clanNames, k)
			end
			local default = 1
			for i = 1, #clanNames do
				if clanNames[i] == myClan then
					default = i
					break
				end
			end
			
			local selection = augments:AddDropdown("Custom Clan (client-side only)", clanNames, default, function(index, newClan)
				local clan = playerData:FindFirstChild("Clan")
				if clan and clan.Value ~= newClan then
					local copy = clan:Clone()
					clan:Destroy()
					copy.Value = newClan
					copy.Parent = playerData
				end
			end)
		end
	end
	
	do -- flowers location
		
	end
	
	do -- muzan location
		local function UpdateMuzan()
			local muzan = game.Workspace:FindFirstChild("Muzan")
			wait(2)
			if muzan then
				local pos = muzan:FindFirstChild("SpawnPos")
				if pos then
					if not muzanPointer then
						muzanPointer = Instance.new("Part", game.Workspace)
						muzanPointer.Anchored = true
						muzanPointer.Transparency = 1
						local bg = Instance.new("BillboardGui", muzanPointer)
						bg.Adornee = muzanPointer
						bg.AlwaysOnTop = true
						bg.ResetOnSpawn = false
						bg.Size = UDim2.fromOffset(100, 20)
						bg.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
						local tx = Instance.new("TextLabel", bg)
						tx.BackgroundTransparency = 1
						tx.Text = "Muzan"
						tx.TextScaled = true
						tx.TextColor3 = Color3.new(1, 0.9, 0.9)
						tx.Size = UDim2.fromScale(1, 1)
					end
					muzanPointer.CFrame = CFrame.new(pos.Value)
				end
			end
		end
		spawn(UpdateMuzan)
		if game.Workspace:FindFirstChild("Muzan") then
			if game.Workspace.Muzan:FindFirstChild("SpawnPos") then
				table.insert(connections, game.Workspace.Muzan.Changed:Connect(function() spawn(UpdateMuzan) end))
			end
		end
	end
	
	end -- end of gameplay place
end

function module.Shutdown()
	moduleOn = false
	game:GetService("RunService"):UnbindFromRenderStep("main_loop")
	if muzanPointer then
		muzanPointer:Destroy()
	end
end

return module