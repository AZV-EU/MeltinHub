local module = {
	GameName = "Scam Tycoon",
	ModuleVersion = "1.0"
}

local plr = game.Players.LocalPlayer

local Events = game.ReplicatedStorage:WaitForChild("Events")
local GenerateNumber = Events:WaitForChild("GenerateNumber")
local CheckNumber = Events:WaitForChild("CheckNumber")

local moduleOn = true

function module.PreInit()
	
end

function module.Init(category, connections)
	local GeneratedNumber = plr:WaitForChild("GeneratedNumber")
	local GeneratedSignal = GeneratedNumber:GetPropertyChangedSignal("Value")
	
	local autoScam = category:AddCheckbox("Auto-scam")
	pcall(function()
		while moduleOn and wait(.5) do
			if autoScam.Checked then
				print("Firing", GeneratedNumber.Value)
				CheckNumber:FireServer(GeneratedNumber.Value)
				wait(.5)
				print("Generating number", GeneratedNumber.Value)
				GenerateNumber:FireServer()
				print("Waiting 1")
				GeneratedSignal:Wait()
				print("Waiting 2")
				GeneratedSignal:Wait()
			end
		end
	end)
end

function module.Shutdown()
	moduleOn = false
end

return module