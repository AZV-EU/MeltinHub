local emulator = {}

local plr = game.Players.LocalPlayer
local ETable = {} -- emulator table

function emulator:SetKeyValue(object, key, value)
	if not ETable[object] then
		ETable[object] = {
			Keys = {},
			Values = {},
			Indexer = nil
		}
	end
	ETable[object].Keys[key] = true
	ETable[object].Values[key] = value
end

function emulator:DeleteKey(object, key)
	if ETable[object] then
		ETable[object].Keys[key] = nil
		ETable[object].Values[key] = nil
	end
end

function emulator:SetIndexer(object, indexFunction)
	if not ETable[object] then
		ETable[object] = {
			Keys = {},
			Values = {},
			Indexer = nil
		}
	end
	ETable[object].Indexer = indexFunction
end

function emulator:DeleteIndexer(object)
	if ETable[object] then
		ETable[object].Indexer = nil
	end
end

function emulator:DeleteObject(object)
	if ETable[object] then
		ETable[object] = nil
	end
end

function emulator:Reset()
	ETable = {}
end

local Hook
Hook = hookmetamethod(game, "__index", function(Self, Key)
    if not checkcaller() then
		if ETable[Self] then
			if ETable[Self].Keys[Key] then
				return ETable[Self].Values[Key]
			elseif ETable[Self].Indexer then
				local result = {pcall(ETable[Self].Indexer, Self, Hook, Key)}
				if result[1] then
					return table.unpack(result, 2)
				end
				warn("Indexer for", Self, Key, "failed:", table.unpack(result, 2))
			end
		end
    end

    return Hook(Self, Key)
end)

return emulator