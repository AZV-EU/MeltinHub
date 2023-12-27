local module = {
	On = false
}

local plr = game.Players.LocalPlayer

function module.PreInit()
	
end

function module.Init(category, connections)
	local ReplicatedStorage = _G.SafeGetService("ReplicatedStorage")
	
	local plrConfig = plr:WaitForChild("configurations")
	local currentFlight = plrConfig:WaitForChild("flight")
	
	local flights = game.Workspace:WaitForChild("flights")
	local flightsStatus = ReplicatedStorage:WaitForChild("flights")
	
	local function GetFlight()
		return flights:FindFirstChild(currentFlight.Value)
	end
	
	local function GetClientRE()
		if plr and plr.Character and plr.Character:FindFirstChild("Client") and plr.Character.Client:FindFirstChild("Client") then
			return plr.Character.Client.Client:FindFirstChild("RemoteEvent")
		end
	end
	
	local function GetClientRF()
		if plr and plr.Character and plr.Character:FindFirstChild("Client") and plr.Character.Client:FindFirstChild("Client") then
			return plr.Character.Client.Client:FindFirstChild("RemoteFunction")
		end
	end
	
	local function GetFlightPlane()
		local flight = GetFlight()
		if not flight or not flight:FindFirstChild("clientFolder") then return end
		for _,plane in pairs(flight.clientFolder:GetChildren()) do
			if plane:IsA("Model") and plane:FindFirstChild("flight") then
				return flight, plane, plane.flight
			end
		end
	end
	
	local autoCrew = category:AddCheckbox("Auto-crew")
	autoCrew:SetChecked(true)
	
	task.spawn(function()
		local flight, plane, flightModel
		local re, rf
		
		local function CheckPassengers()
			local npcs = plane:FindFirstChild("npcs")
			if not npcs then return end
			
			for _,npc in pairs(npcs:GetChildren()) do
				local config = npc:FindFirstChild("configurations")
			end
		end
		
		local function CheckPassengersNeeds()
			
		end
		
		local function PrepareGalley()
			local cabinets, counters =
				flightModel:FindFirstChild("galley_cabinets"),
				flightModel:FindFirstChild("galley_counters")
			
			if not cabinets or not counters then warn("no galleys") return end
			
			for _,counter in pairs(counters:GetChildren()) do
				for _,equipment in pairs(counter:GetChildren()) do
					if equipment:IsA("Model") and equipment:FindFirstChild("itemHandle") then
						local equipId = equipment:GetAttribute("id")
						if not equipId then warn("no equipment id -", equipment:GetFullName()) return end
						
						local prompt = equipment:FindFirstChildWhichIsA("ProximityPrompt", true)
						if not prompt then warn("no proximity prompt for -", equipment:GetFullName()) return end
						
						local targetCabinet
						for _,cabinetGroup in pairs(cabinets:GetChildren()) do
							for _,cabinet in pairs(cabinetGroup:GetChildren()) do
								local allowedIds = cabinet:GetAttribute("allowedIds")
								if cabinet:IsA("Model") and allowedIds ~= nil then
									for allowedId in allowedIds:gmatch('"(.-)"') do
										if allowedId == equipId then
											targetCabinet = cabinet
											break
										end
									end
								end
							end
						end
						
						if targetCabinet then
							rf:InvokeServer("GalleyEquip", equipment.itemHandle)
							task.wait(.3)
							
							re:FireServer("GalleyPlace", equipment.Name, targetCabinet)
							task.wait(.3)
							
							equipment:Destroy()
						end
					end
				end
			end
		end
		
		local function PlaneDoorInteract()
			
		end
		
		local function ToggleOverheadBins(state)
			local bins = plane:FindFirstChild("overhead_bins")
			if not bins then return end
			
			for _,bin in ipairs(bins:GetChildren()) do
				if bin:IsA("BasePart") and bin.Name:find("overhead_bin") and ((state and bin:GetAttribute("state") == "opened") or (not state and bin:GetAttribute("state") == "closed")) then
					local prompt = bin:FindFirstChildWhichIsA("ProximityPrompt")
					if prompt then
						fireproximityprompt(prompt)
					end
				end
			end
		end
	
		while task.wait(2) and module.On do
			if not autoCrew.Checked then task.wait(3) continue end
			
			flight, plane, flightModel = GetFlightPlane()
			if not flight or not plane then continue end
			
			local statusFolder = flightsStatus:FindFirstChild(flight.Name)
			if not statusFolder then continue end
			
			local flight_status = statusFolder:WaitForChild("flight_status").Value
			local status = {}
			if statusFolder:FindFirstChild(flight_status) then
				for _,sObj in pairs(sCat:GetChildren()) do
					if sObj:IsA("BoolValue") then
						status[sObj.Name] = sObj.Value
					end
				end
			end
			
			re, rf = GetClientRE(), GetClientRF()
			if not re or not rf then continue end
			
			if flight_status == "departure" then
				if not status.passengers_seated then -- let passengsers in
					
				end
				
				if not status.passengers_checked then
					CheckPassengers()
				end
				
				if not status.first_class_beverages then
					CheckPassengersNeeds()
				end
				
				if not status.galley_prepared then
					PrepareGalley()
				end
				
				if not status.door_closed then
					PlaneDoorInteract()
				end
				
				if not status.overhead_bins_closed then
					ToggleOverheadBins(true)
				end
			end
			
		end
	end)
end

function module.Shutdown()
	
end

return module