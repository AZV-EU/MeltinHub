local module = {
	GameName = "Car Factory Tycoon",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer
if not plr then return end

local moduleOn = true

local OPTIONS = {
	BEST_BID_THRESHOLD = 0.80
}

local Knit = require(game.ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local DataController
do
	local f, err
	repeat
		f = pcall(function()
			DataController = Knit.GetController("DataController")
		end)
		task.wait(.25)
	until f and DataController
end	
local GamepassController = Knit.GetController("GamepassController")

local Rebirths = Knit.Modules.Rebirths
local Library = Knit.Modules.Library
local Conveyors = Knit.Modules.Conveyors

local MyTycoon = game.Workspace:WaitForChild("Tycoons"):WaitForChild(plr.Team.Name)
local Model = MyTycoon:WaitForChild("Model")
local Lines = Model:WaitForChild("Lines")
local NPCs = Model:WaitForChild("NPCs")

local Info_Conveyors = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Info"):WaitForChild("Conveyors"))

local function GetBids()
	local bids = {}
	local hasGamepass = DataController.Data.Gamepasses[tostring(117108016)]
	local priceMult = (hasGamepass and 2 or 1) + DataController.Data.Upgrades.Negotiation * 0.02
	
	for k,v in pairs(NPCs:GetChildren()) do
		if v.Name == "BidderPrompt" then
			local conveyor, carIndex = v:GetAttribute("Conveyor"), v:GetAttribute("CarIndex")
			local bidRange = Conveyors[conveyor].Vehicles[carIndex].BidRange
			local bid = {}
			for i = 1, 3 do
				local bidPrice = v:GetAttribute("Bid" .. tostring(i))
				table.insert(bid, {
					BidderPrompt = v,
					Price = math.round(bidPrice * priceMult),
					Chance = (bidPrice - bidRange.Min) / (bidRange.Max - bidRange.Min)
				})
			end
			table.insert(bids, bid)
		end
	end
	return bids
end

function module.PreInit()
	
end

function module.Init(category, connections)
	local chance_threshold = category:AddSlider("Auto-bid Risk %", 90, 1, 100)

	local autoDropoff = category:AddCheckbox("Auto-dropoff")
	autoDropoff.Inline = true
	autoDropoff:SetChecked(true)
	
	local autoBid = category:AddCheckbox("Auto-bid")
	autoBid:SetChecked(true)
	
	local autoBuild = category:AddCheckbox("Auto-build")
	autoBuild.Inline = true
	
	local autoUpgrade = category:AddCheckbox("Auto-upgrade")
	
	table.insert(connections, game.Workspace:WaitForChild("World"):WaitForChild("AirDrops"):WaitForChild("Drops").ChildAdded:Connect(function(child)
		if child.Name == "AirDrop" then
			_G.TouchObject(child:WaitForChild("Base"))
		end
	end))
	
	spawn(function()
		while moduleOn and task.wait(1) do
			local f, err = pcall(function()
				if autoDropoff.Checked and not plr:GetAttribute("HoldingItems") then
					local carryCapacity = DataController.Data.Upgrades.Carry + 1 + (GamepassController:OwnsGamepass(117107046) and 8 or 0)
					for k, line in pairs(Lines:GetChildren()) do
						local lineData = DataController.Data.Tycoon[line.Name]
						if lineData then
							local maxCapacity = 3-- + lineData.Upgrades.Storage
							for matId, matQt in pairs(lineData.Materials) do
								if matQt <= 0 then
									while matQt < maxCapacity do
										local addAmount = math.min(carryCapacity, maxCapacity - matQt)
										for i = 1, addAmount do
											game:GetService("ReplicatedStorage").Packages.Knit.Services.MaterialService.RF.Collect:InvokeServer(
												matId
											)
										end
										game:GetService("ReplicatedStorage").Packages.Knit.Services.MaterialService.RF.Drop:InvokeServer(
											line
										)
										matQt += addAmount
									end
								end
							end
						end
					end
				end
				if autoBid.Checked then
					for k, bids in pairs(GetBids()) do
						if bids then
							local bestBidPrice, bestBidId
							for i = 1, #bids do
								if bids[i].Chance <= (chance_threshold.Value/100) then
									if not bestBidId or bestBidPrice < bids[i].Price then
										bestBidId = i
										bestBidPrice = bids[i].Price
									end
								end
							end
							if bestBidId then
								game:GetService("ReplicatedStorage").Packages.Knit.Services.TycoonService.RF.AcceptBid:InvokeServer(
									bids[bestBidId].BidderPrompt,
									bestBidId
								)
							else
								local bestChance = 0
								for i = 1, #bids do
									if not bestBidId or bestChance < bids[i].Chance then
										bestBidId = i
										bestChance=  bids[i].Chance
									end
								end
								game:GetService("ReplicatedStorage").Packages.Knit.Services.TycoonService.RF.AcceptBid:InvokeServer(
									bids[bestBidId].BidderPrompt,
									bestBidId
								)
							end
						end
					end
				end
				if autoBuild.Checked then
					for k, line in pairs(Lines:GetChildren()) do
						local workers = DataController.Data.Tycoon[line.Name].Upgrades.Workers
						if workers >= 1 and workers < 6 then
							game:GetService("ReplicatedStorage").Packages.Knit.Services.TycoonService.RF.SpawnCarSegment:InvokeServer(
								line.Name
							)
						end
					end
				end
				if autoUpgrade.Checked then
					for k, line in pairs(Lines:GetChildren()) do
						if line.Name ~= "Exclusive" and
							DataController.Data.Tycoon[line.Name].Car < 8 then
							local nextUpgrade = Info_Conveyors[line.Name].Vehicles[DataController.Data.Tycoon[line.Name].Car+1]
							if nextUpgrade and DataController.Data.Cash >= nextUpgrade.UnlockCost then
								game:GetService("ReplicatedStorage").Packages.Knit.Services.TycoonService.RF.BuyNextCar:InvokeServer(
									line.Name
								)
							end
						end
					end
				end
			end)
			if not f then
				warn(err)
			end
		end
	end)
end

function module.Shutdown()
	moduleOn = false
end

return module