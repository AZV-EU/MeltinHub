local emulator = {}

local UserInputService = game:GetService("UserInputService")

local controlRequested = false

local emulatedHit = CFrame.new()
local emulatedPart = nil

function emulator:TakeMouseControl()
	local taken = controlRequested == false
	controlRequested = true
	return taken
end

function emulator:FreeMouseControl()
	local released = controlRequested == true
	controlRequested = false
	return released
end

function emulator:SetHit(cframe)
	emulatedHit = cframe
end

function emulator:TargetPart(part)
	emulatedPart = part
	emulatedHit = CFrame.new(part.Position)
end

function emulator:GetTargetPart()
	return emulatedPart
end

local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

local Hook
Hook = hookmetamethod(mouse, "__index", newcclosure(function(Self, Key)
    if not checkcaller() and Self == mouse and controlRequested then
        if Key == "Target" then
			return emulatedPart
		elseif Key == "Hit" then
			return emulatedHit
		else
			local simulatedPos, inBounds = game.Workspace.CurrentCamera:WorldToScreenPoint(emulatedHit.Position)
			if inBounds then
				if Key == "X" then
					return simulatedPos.X
				elseif Key == "Y" then
					return simulatedPos.Y
				end
			end
		end
    end

    return Hook(Self, Key)
end))

return emulator