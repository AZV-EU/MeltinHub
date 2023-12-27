local emulator = {}

local UserInputService = game:GetService("UserInputService")

local overrides
function emulator:Reset()
	overrides = {
		KeyDown = {}
	}
end

emulator:Reset()

function emulator:SetKeyDown(keycode, isDown)
	overrides.KeyDown[keycode] = isDown
end

function emulator:ClearKeyDown(keycode)
	overrides.KeyDown[keycode] = nil
end

_G.MethodEmulator:SetMethodOverride(UserInputService, "IsKeyDown", function(self, originalFunc, keycode)
	if overrides.KeyDown[keycode] ~= nil then
		return overrides.KeyDown[keycode]
	end
	return originalFunc(self, keycode)
end)

return emulator