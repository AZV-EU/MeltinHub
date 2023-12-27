local module = {
	GameName = "Impossible Squid Game",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local YLEVEL = 1990.73

local connections = {}

local map = game.Workspace:WaitForChild("Map")
local tiles = map:WaitForChild("Game"):WaitForChild("Tiles")
local spawn = map.Game:WaitForChild("SpawnLocation")

local allTiles = {}
local safePlates = {}

local safeBasePlate = map:FindFirstChild("SafeBasePlate") or Instance.new("Part")
safeBasePlate.Name = "SafeBasePlate"
safeBasePlate.Anchored = true
safeBasePlate.Size = Vector3.new(2000, 1, 1000)
safeBasePlate.Position = Vector3.new(spawn.Position.X - safeBasePlate.Size.X/2, YLEVEL-1, spawn.Position.Z)
safeBasePlate.Transparency = 1
safeBasePlate.Parent = map

local safePlatesFolder = tiles:FindFirstChild("SafePlates") or Instance.new("Folder", tiles)
safePlatesFolder.Name = "SafePlates"

local neutralCol = BrickColor.new("Tr. Flu. Blue")
local greenCol = BrickColor.new("Lime green")
local redCol = BrickColor.new("Really red")

local function SetSkin(name)
	coroutine.resume(coroutine.create(function()
		game.ReplicatedStorage.Shared.Remotes.morphRequest.RemoteFunction:InvokeServer(name)
	end))
end

local function SafePlate(tile)
	if safePlates[tile.Name] then
		safePlates[tile.Name]:Destroy()
		safePlates[tile.Name] = nil
	end
	sp = tile:Clone()
	sp.Parent = safePlatesFolder
	sp.Transparency = 0.9
	sp.BrickColor = BrickColor.new(1, 1, 1)
	sp.Name = "SafePlateFor" .. tostring(tile.Name)
	sp.Size = Vector3.new(1, tile.Size.Y, tile.Size.Z)
	tile.Position = Vector3.new(tile.Position.X, YLEVEL-1.5, tile.Position.Z)
	sp.CFrame = tile.CFrame * CFrame.new(1, 0, 0)
	sp.CanCollide = true
	safePlates[tile.Name] = sp
end

local function ClearSafePlates()
	safePlatesFolder:ClearAllChildren()
	safePlates = {}
end
ClearSafePlates()

local function AutoColor(tile)
	local side = tiles:FindFirstChild(tile.Parent.Name == "Left" and "Right" or "Left")
	local opposite = side:FindFirstChild(tile.Name)
	if not opposite then return end
	if tile.BrickColor == greenCol then
		opposite.BrickColor = redCol
		tile.Position = Vector3.new(tile.Position.X, YLEVEL, tile.Position.Z)
		opposite.Position = Vector3.new(opposite.Position.X, YLEVEL-1.5, opposite.Position.Z)
		SafePlate(opposite)
	elseif tile.BrickColor == redCol then
		opposite.BrickColor = greenCol
		tile.Position = Vector3.new(tile.Position.X, YLEVEL-1.5, tile.Position.Z)
		opposite.Position = Vector3.new(opposite.Position.X, YLEVEL, opposite.Position.Z)
		SafePlate(tile)
	else
		opposite.BrickColor = tile.BrickColor
		tile.Position = Vector3.new(tile.Position.X, YLEVEL, tile.Position.Z)
		opposite.Position = Vector3.new(opposite.Position.X, YLEVEL, opposite.Position.Z)
	end
end

function touchObject(object)
	if not object then return end
	if not object:IsA("BasePart") and not object:FindFirstChildWhichIsA("TouchTransmitter") then return end
	if plr.Character and plr.Character:FindFirstChild("Humanoid") then
		firetouchinterest(plr.Character.Humanoid.RootPart, object, 0)
		firetouchinterest(plr.Character.Humanoid.RootPart, object, 1)
		return true
	end
end

local scanning = false
local jumping = false
function module.Init(category)
	local label = category:AddLabel("Waiting for all tiles...")
	do
		repeat
			allTiles = {}
			for k,v in pairs(tiles:GetDescendants()) do
				if v:IsA("BasePart") and v:FindFirstChildWhichIsA("TouchTransmitter")
					and v.Name:sub(1, 4) == "Tile" then
					table.insert(allTiles, v)
					AutoColor(v)
				end
			end
			wait(1)
		until #allTiles >= 160
		label.Text = "Setup ready"
	end
	local half = #allTiles / 2
	
	category:AddButton("Reset Tiles" , function()
		for k,v in pairs(allTiles) do
			v.BrickColor = neutralCol
			AutoColor(v)
		end
		ClearSafePlates()
	end)
	
	local function FindFirstNeutralTile()
		for i = half, 1, -1 do
			local tile = tiles.Right:FindFirstChild("Tile" .. tostring(i))
			if tile then
				if tile.BrickColor == neutralCol then
					return tile
				end
			end
		end
	end
	
	local function CountNeutralTiles()
		local n = 0
		for k,v in pairs(tiles.Right:GetChildren()) do
			if v.BrickColor == neutralCol then
				n += 1
			end
		end
		return n
	end
	
	local scanBtn
	scanBtn = category:AddButton("Scan Tiles", function()
		if scanning then
			scanning = false
		elseif CountNeutralTiles() > 0 then
			scanning = true
			local tile = FindFirstNeutralTile()
			while tile do
				if not scanning or not tile then break end
				if tile.Transparency == 1 then
					tile.BrickColor = redCol
				else
					scanBtn.Text = "Scanning tiles (" .. tostring(CountNeutralTiles()) .. " left)"
					_G.SenHub:Update()
					plr.Character.HumanoidRootPart.CFrame = CFrame.new(tile.Position + Vector3.new(0, 4, 0))
					touchObject(tile)
					wait(.75)
					if plr.Character.Humanoid.Health == 0 then
					--	tile.BrickColor = redCol
						plr.CharacterAdded:Wait()
						repeat wait() until plr.Character:FindFirstChild("HumanoidRootPart")
					--else
					--	tile.BrickColor = greenCol
					end
				end
				--AutoColor(tile)
				
				tile = FindFirstNeutralTile()
			end
			scanBtn.Text = "Scan Tiles"
			_G.SenHub:Update()
			scanning = false
		end
	end)
	
	local autoBtn
	autoBtn = category:AddButton("Auto-jump", function()
		if jumping then
			jumping = false
		else
			jumping = true
			for i = 1, half do
				if not jumping or plr.Character.Humanoid.Health == 0 then break end
				autoBtn.Text = "Jumping to Tile " .. tostring(i)
				local tile = tiles.Left:FindFirstChild("Tile" .. tostring(i))
				if tile.BrickColor == redCol then
					tile = tiles.Right:FindFirstChild("Tile" .. tostring(i))
				end
				if not tile then break end
				plr.Character.HumanoidRootPart.CFrame = CFrame.new(tile.Position + Vector3.new(0, 3, 0))
				touchObject(tile)
				_G.SenHub:Update()
				wait(0.2)
			end
			jumping = false
		end
		autoBtn.Text = "Auto-jump"
	end)
	
	category:AddButton("Tp To Start", function()
		plr.Character.HumanoidRootPart.CFrame = CFrame.new(spawn.Position + Vector3.new(0, 3, 0))
	end)
	
	category:AddButton("All Safe Tiles", function()
		for k,v in pairs(allTiles) do
			SafePlate(v)
		end
	end)
	
	for k,v in pairs(allTiles) do
		table.insert(connections, v.Changed:Connect(function(prop)
			if prop == "Transparency" and v.Transparency == 1 then
				wait(.2)
				local opposite = v.Parent.Name == "Left" and tiles.Right:FindFirstChild(v.Name) or tiles.Left:FindFirstChild(v.Name)
				if opposite and opposite.Transparency == 1 then
					v.BrickColor = neutralCol
				end
				AutoColor(v)
			end
		end))
		local cooldown = false
		table.insert(connections, v.Touched:Connect(function(p)
			if cooldown then return end
			local player = game.Players:GetPlayerFromCharacter(p.Parent)
			if not player then return end
			local human = player.Character:FindFirstChild("Humanoid")
			if not human then return end
			if human.Health <= 0 then return end
			cooldown = true
			wait(.5)
			if v.Transparency == 0.5 then
				v.BrickColor = greenCol
			else
				v.BrickColor = redCol
			end
			AutoColor(v)
			cooldown = false
		end))
	end
	
	local setRedBtn
	setRedBtn = category:AddButton("Red", function()
		SetSkin("Ruby Front Man")
	end)
	setRedBtn.Inline = true
	setRedBtn._GuiObject.TextColor3 = Color3.new(1, 0, 0)
	
	local setOrangeBtn
	setOrangeBtn = category:AddButton("Yellow", function()
		SetSkin("Golden Front Man")
	end)
	setOrangeBtn._GuiObject.TextColor3 = Color3.new(1, 1, 0)
	setOrangeBtn.Inline = true
	
	local setGreenBtn
	setGreenBtn = category:AddButton("Green", function()
		SetSkin("Sapphire Front Man")
	end)
	setGreenBtn._GuiObject.TextColor3 = Color3.new(0, 1, 0)
	
	local resetSkinBtn = category:AddButton("Reset", function()
		SetSkin("You")
	end)
end

function module.Shutdown()
	for k,v in pairs(connections) do
		if v then
			v:Disconnect()
		end
	end
	jumping = false
	scanning = false
	ClearSafePlates()
end

return module