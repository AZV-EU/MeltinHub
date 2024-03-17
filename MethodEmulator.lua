local emulator = {}

local plr = game.Players.LocalPlayer
local ETable = {} -- emulator table

function emulator:SetMethodOverride(object, methodName, methodOverride)
	if not ETable[object] then
		ETable[object] = {
			Methods = {},
			Overrides = {}
		}
	end
	ETable[object].Methods[methodName] = true
	ETable[object].Overrides[methodName] = methodOverride
end

function emulator:DeleteMethodOverride(object, methodName)
	if object and ETable[object] and methodName then
		ETable[object].Methods[methodName] = nil
		ETable[object].Overrides[methodName] = nil
	end
end

function emulator:DeleteObject(object)
	if object and ETable[object] then
		ETable[object] = nil
	end
end

function emulator:Reset()
	ETable = {}
end

local OriginalFunc
-- newcclosure()
OriginalFunc = hookmetamethod(game, "__namecall", newcclosure(function(Self, ...)
    if not checkcaller() then
		local NamecallMethod = getnamecallmethod()
		
		local eTable = ETable[Self] or ETable[Self.Name]
		if eTable and eTable.Methods[NamecallMethod] then
			local results = {pcall(eTable.Overrides[NamecallMethod], Self, OriginalFunc, ...)}
			if results[1] then
				return table.unpack(results, 2)
			end
			warn("Override function for", Self, NamecallMethod, "failed:", table.unpack(results, 2))
		end
    end

    return OriginalFunc(Self, ...)
end))

return emulator