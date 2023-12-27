local module = {
	GameName = "Find The Markers!",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer

local allMarkers = game.Workspace:FindFirstChild("AllTheMarkers") or Instance.new("Model", game.Workspace)
allMarkers.Name = "AllTheMarkers"

local highlight = allMarkers:FindFirstChild("Highlight") or Instance.new("Highlight", allMarkers)
highlight.FillColor = Color3.new(0, 1, 1)
highlight.FillTransparency = 0.25
highlight.OutlineColor = Color3.new(0, 1, 1)
highlight.OutlineTransparency = 0
highlight.Adornee = allMarkers
highlight.Enabled = false

local moduleOn = true

function module.PreInit()
	
end

function module.Init(category, connections)
	local markersUI = plr:WaitForChild("PlayerGui"):WaitForChild("PackagedGui"):WaitForChild("Menu"):WaitForChild("AllMarkers"):WaitForChild("Markers")
	local function ownsMarker(name)
		return markersUI:FindFirstChild(name) ~= nil and markersUI:FindFirstChild(name):GetAttribute("Got")
	end
	local loading = category:AddLabel("Loading...")
	local markersDb = game.ReplicatedStorage:WaitForChild("Markers"):GetChildren()
	for k,v in pairs(markersDb) do
		if v:IsA("ObjectValue") and v.Value ~= nil and not ownsMarker(v.Name) then
			loading:SetText("Loading Marker (".. tostring(k) .. " / " .. tostring(#markersDb) ..")")
			v.Value.Parent = nil
			task.wait(.05)
			if not moduleOn then break end
			v.Value.Parent = allMarkers
		end
	end
	loading:Remove()
	category:AddCheckbox("Show Markers", function(state)
		highlight.Enabled = state
	end)
	task.spawn(function()
		while moduleOn and task.wait(1) do
			for k,v in pairs(markersDb) do
				if v:IsA("ObjectValue") and v.Value ~= nil and ownsMarker(v.Name) then
					v.Value.Parent = nil
					task.wait(.05)
					v.Value.Parent = game.Workspace
				end
			end
		end
	end)
end

function module.Shutdown()
	moduleOn = false
	print("shutting down!")
	for k,v in pairs(allMarkers:GetChildren()) do
		if v ~= highlight then
			v.Parent = game.Workspace
		end
	end
end

return module