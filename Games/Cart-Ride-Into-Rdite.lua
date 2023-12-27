local RunService = game:GetService("RunService")

local module = {
	GameName = "Cart Ride into Rdite",
	ModuleVersion = "1.0"
}
local currentMode = 1
local modes = {
	[1] = "All",
	[2] = "Nearest",
	[3] = "Random"
}

local optimalSpeed = 125
local connections = {}
local plr = game.Players.LocalPlayer

function getCarts()
	local results = {}
	if plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.RootPart then
		for k,v in pairs(game.Workspace:GetDescendants()) do
			if v:IsA("Model") and v:FindFirstChild("Body") and v:FindFirstChild("Configuration") then
				table.insert(results, {
					Cart = v,
					Distance = (v.Body.Engine.Position - plr.Character.Humanoid.RootPart.Position).Magnitude
				})
			end
		end
	end
	if currentMode == 1 then
		return results
	elseif currentMode == 2 then
		table.sort(results,
			function(a, b)
				return a.Distance < b.Distance
			end
		)
		return #results > 0 and {results[1]} or {}
	elseif currentMode == 3 then
		return #results > 0 and {results[math.random(1, #results)]} or {}
	end
end

local function setSpeedTo(cart, speed)
	local needsMore = cart.Configuration.Speed.Value < speed
	local steps = math.abs(speed - cart.Configuration.Speed.Value) / 5
	for i = 1, steps do
		fireclickdetector(needsMore and cart.Up.Click or cart.Down.Click)
	end
end

local isForcing = true

function module.Init(category)
	category:AddDropdown("Current Mode", {"All", "Nearest", "Random"}, 1, function(selectedIndex)
		currentMode = selectedIndex
		print("Current mode: " .. currentMode)
	end)
	
	local forceState = false
	
	local customSpeed = category:AddSlider("Custom Speed", 125, -250, 250, nil, 5)
	local setSpeed = category:AddButton("Set speed", function()
		for k,v in pairs(getCarts()) do
			setSpeedTo(v.Cart, customSpeed.Value)
		end
	end)
	
	local forceSpeed
	local forceCarts = category:AddCheckbox("Force Carts On", function(state)
		forceState = state
		setSpeed.Visible = not state
		forceSpeed.Visible = state
	end)
	
	forceSpeed = category:AddCheckbox("Also force speed")
	forceSpeed:SetChecked(true)
	forceSpeed.Visible = false
	
	coroutine.resume(coroutine.create(function()
		while isForcing and wait(.2) do
			if forceState then
				for k,v in pairs(getCarts()) do
					--local seat = v.Cart:FindFirstChildWhichIsA("Seat")
					--if seat and seat:FindFirstChild("SeatWeld") then
					if forceSpeed.Checked then
						local f, err = pcall(function()
							setSpeedTo(v.Cart, customSpeed.Value)
						end)
						if not f then
							warn(err)
							break
						end
					end
					if not v.Cart.Configuration.CarOn.Value then
						fireclickdetector(v.Cart.On.Click)
					end
					--end
				end
			end
		end
	end))
	
	do
		local sc = category:AddButton("Start Carts", function()
			for k,v in pairs(getCarts()) do
				if not v.Cart.Configuration.CarOn.Value then
					fireclickdetector(v.Cart.On.Click)
				end
			end
		end)
		sc.Inline = true
		sc._GuiObject.TextColor3 = Color3.new(0, 1, 0)
	end
	
	category:AddButton("Stop Carts", function()
		for k,v in pairs(getCarts()) do
			if v.Cart.Configuration.CarOn.Value then
				fireclickdetector(v.Cart.On.Click)
			end
		end
	end)._GuiObject.TextColor3 = Color3.new(1, 0, 0)
	
	category:AddButton("Speed +", function()
		for k,v in pairs(getCarts()) do
			fireclickdetector(v.Cart.Up.Click)
		end
	end).Inline = true
	
	category:AddButton("Speed -", function()
		for k,v in pairs(getCarts()) do
			fireclickdetector(v.Cart.Down.Click)
		end
	end)
	
	category:AddButton("Max+", function()
		for k,v in pairs(getCarts()) do
			setSpeedTo(v.Cart, 250)
		end
	end).Inline = true
	
	category:AddButton("Max-", function()
		for k,v in pairs(getCarts()) do
			setSpeedTo(v.Cart, -250)
		end
	end).Inline = true
	
	category:AddButton("Reset", function()
		for k,v in pairs(getCarts()) do
			setSpeedTo(v.Cart, 0)
		end
	end)
end

function module.Shutdown()
	isForcing = false
	forceState = false
end

return module