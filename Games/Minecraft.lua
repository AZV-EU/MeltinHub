local module = {
	GameName = "Minecraft",
	ModuleVersion = "1.4"
}

function module.PreInit()
	--[[
	if not _G.AntiTp then
		local TeleportService = _G.SafeGetService("TeleportService")
		local OldNameCall = nil
		OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
			local Args = {...}
			local NamecallMethod = getnamecallmethod()

			if not checkcaller() and Self == TeleportService and NamecallMethod == "Teleport" then
				print("Prevented teleport")
				return nil
			end

			return OldNameCall(Self, ...)
		end)
		print("Setup anti-tp")
		_G.AntiTp = true
	end
	]]
end

local moduleOn = true

local hand
function module.Init(category, connections)
	local plr = game.Players.LocalPlayer
	local PlayerGui = plr:WaitForChild("PlayerGui")
	local hud = PlayerGui:WaitForChild("HUDGui")

	local function FixGui()
		task.spawn(function()
			-- remove gamepasses
			for k,v in pairs(PlayerGui:WaitForChild("GamePass Shop Gui"):GetChildren()) do
				v.Visible = false
			end
			
			-- remove vignette
			hud:WaitForChild("Vignette").Visible = false
			
			-- remove pesky paid items
			hud:WaitForChild("Inventory"):WaitForChild("Inventory").Visible = false
		end)
	end
	FixGui()
	table.insert(connections, plr.CharacterAdded:Connect(FixGui))
	
	local cam = game.Workspace.CurrentCamera
	if cam then
		local hand
		local function SetHandVisible(visible)
			hand = cam:FindFirstChild("Hand")
			if hand then
				hand.Transparency = visible and 0 or 1
				for k,v in pairs(hand:GetChildren()) do
					if v:IsA("Texture") then
						v.Transparency = visible and 0 or 1
					end
				end
				for k,v in pairs(hud:GetChildren()) do
					if v:IsA("Frame") and v.Name == "Crosshair" then
						v.Visible = visible
					end
				end
			end
		end
		table.insert(connections, game.Workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Connect(function()
			SetHandVisible((cam.CFrame.Position - cam.Focus.Position).Magnitude < 1)
		end))
	end

	local RunService = _G.SafeGetService("RunService")
	local UserInputService = _G.SafeGetService("UserInputService")
	local MainLocalScript = plr:WaitForChild("PlayerScripts"):WaitForChild("MainLocalScript")
	local CWorld = require(MainLocalScript:WaitForChild("CWorld"))

	local GameRemotes = game.ReplicatedStorage:WaitForChild("GameRemotes")

	local DemoRemote = GameRemotes:FindFirstChild("Demo")
	if DemoRemote then
		_G.MethodEmulator:SetMethodOverride(DemoRemote, "FireServer", function() end)
	else
		warn("Couldn't implement anti-fall damage: no Demo remote")
	end
	local Blocks = game.Workspace:WaitForChild("Blocks")
	local Fluids = game.Workspace:WaitForChild("Fluid")

	local AssetsMod = game.ReplicatedStorage:WaitForChild("AssetsMod")
	local _blockInfo = require(AssetsMod:WaitForChild("BlockInfo"));
	local _itemInfo = require(AssetsMod:WaitForChild("ItemInfo"));
	local _ItemLevels = require(AssetsMod:WaitForChild("ItemLevels"))
	local _IDs = require(AssetsMod:WaitForChild("IDs"))

	local BlocksData = _IDs.ByName.Blocks

	local Remotes = {
		Attack = GameRemotes:WaitForChild("Attack"),
		ChangeSlot = GameRemotes:WaitForChild("ChangeSlot"),
		BreakBlock = GameRemotes:WaitForChild("BreakBlock"),
		AcceptBreakBlock = GameRemotes:WaitForChild("AcceptBreakBlock"),
		UseBlock = GameRemotes:WaitForChild("UseBlock")
	}

	local Constants = {
		PlayerReachBlocks = 5.5,
		BlockSize = 3
	}
	Constants.PlayerReach = Constants.PlayerReachBlocks * Constants.BlockSize - 1

	local function ToRegionPos(worldPos)
		return Vector3.new(
			math.floor(worldPos.X / Constants.BlockSize + 0.5),
			math.floor(worldPos.Y / Constants.BlockSize + 0.5),
			math.floor(worldPos.Z / Constants.BlockSize + 0.5)
		)
	end

	local function FindBlockUnderMouse()
		local msPos = Vector2.new(game.Workspace.CurrentCamera.ViewportSize.X / 2, game.Workspace.CurrentCamera.ViewportSize.Y / 2 - 36)
		local ray = game.Workspace.CurrentCamera:ScreenPointToRay(msPos.X, msPos.Y, 0)
		local raycastParams = RaycastParams.new()
		raycastParams.FilterDescendantsInstances = { Blocks }
		raycastParams.FilterType = Enum.RaycastFilterType.Whitelist
		local result = game.Workspace:Raycast(ray.Origin, ray.Unit.Direction * 999, raycastParams);
		if result then
			local dist = (result.Position - workspace.CurrentCamera.CFrame.Position).Magnitude
			if dist < Constants.PlayerReach then
				local cf = CFrame.new(result.Position, result.Position + ray.Unit.Direction)
				local pos = ToRegionPos(cf.Position + cf.LookVector / 64)
				return pos
			end
		end
	end

	local function setXray(state)
		for _, region in pairs(Blocks:GetChildren()) do
			for _, block in pairs(region:GetChildren()) do
				if block:FindFirstChild("BoxHandleAdornment") then
					if block.Name == "SapphireOre" then
						block.BoxHandleAdornment.Visible = true
					else
						block.BoxHandleAdornment.Visible = state
					end
				elseif block.Name == "SapphireOre" then
					local bha = Instance.new("BoxHandleAdornment", block)
					bha.Adornee = block
					bha.AlwaysOnTop = true
					bha.Color3 = Color3.fromRGB(29, 29, 211)
					bha.Size = Vector3.new(3, 3, 3)
					bha.Transparency = 0.7
					bha.ZIndex = 10
					bha.Visible = true
				end
			end
		end
	end

	local autoAttack = category:AddCheckbox("Auto-Attack")
	autoAttack.Inline = true
	local lastAttack = tick()
	local cooldown = 0
	local attackSlot = 1
	coroutine.resume(coroutine.create(function()
		while moduleOn and task.wait(.33) do
			if autoAttack.Checked then
				local closest, dist = nil, 0
				local tdist = 0
				for k,v in pairs(game.Players:GetPlayers()) do
					if v ~= plr and v.Character ~= nil and not v.Character:FindFirstChildWhichIsA("ForceField") then
						tdist = plr:DistanceFromCharacter(v.Character:GetPivot().Position)
						if tdist <= Constants.PlayerReach and not plr:IsFriendsWith(v.UserId) then
							if not closest or tdist < dist then
								closest = v
								dist = tdist
							end
						end
					end
				end
				if closest then
					--attackSlot = attackSlot == 1 and 2 or 1
					task.spawn(function()
						--Remotes.ChangeSlot:InvokeServer(attackSlot)
						Remotes.Attack:InvokeServer(closest.Character)
					end)
				end
			end
		end
	end))
	
	if DemoRemote then
		local function SetupSuperMode(chr)
			local human = chr:WaitForChild("Humanoid")
			table.insert(connections, human.HealthChanged:Connect(function()
				if human.Health < human.MaxHealth then
					DemoRemote:FireServer(-human.MaxHealth, "fall")
				end
			end))
		end
		table.insert(connections, plr.CharacterAdded:Connect(SetupSuperMode))
		repeat task.wait() until plr.Character
		SetupSuperMode(plr.Character)
	else
		warn("No demo-remote, can't setup super-mode!")
	end
		
	local xray
	xray = category:AddCheckbox("X-Ray", function(state)
		setXray(state)
		if state then
			task.spawn(function()
				while task.wait(5) and xray.Checked and module.On do
					setXray(true)
				end
			end)
		end
	end)
	
	--[[
	local massMine
	massMine = category:AddButton("Mass-Mine", function()
		massMine.Enabled = false
		local startPos = game.Players.LocalPlayer.Character:GetPivot()
		local ores = {}
		
		for _, region in pairs(Blocks:GetChildren()) do
			for _, block in pairs(region:GetChildren()) do
				if block:FindFirstChild("BoxHandleAdornment") and plr:DistanceFromCharacter(block.Position) < Constants.PlayerReach then
					table.insert(ores, block)
				end
			end
		end
		
		for k, block in pairs(ores) do
			massMine.Text = "Mining " .. tostring(k) .. " / " .. tostring(#ores) .. " ores"
			_G.SenHub:Update()
			local blockPos = ToRegionPos(block.Position)
			Remotes.BreakBlock:FireServer(blockPos.X, blockPos.Y, blockPos.Z)
			wait(0.7)
			if Remotes.AcceptBreakBlock:InvokeServer() then
				CWorld.destroyBlock(
					blockPos.X,
					blockPos.Y,
					blockPos.Z
				)
			end
		end
		
		massMine.Text = "Waiting..."
		_G.SenHub:Update()
		wait(1)
		
		massMine.Text = "Teleporting..."
		_G.SenHub:Update()
		
		for k,v in pairs(game.Workspace:GetChildren()) do
			if (v:IsA("BasePart") and v:FindFirstChild("SurfaceGui")) or v:IsA("MeshPart") then
				_G.TeleportPlayerTo(CFrame.new(v.Position))
				wait(.25)
			end
		end
		
		_G.TeleportPlayerTo(startPos)
		massMine.Enabled = true
		massMine.Text = "Mass-Mine"
		_G.SenHub:Update()
	end)]]
end

function module.Shutdown()
	moduleOn = false
end

return module