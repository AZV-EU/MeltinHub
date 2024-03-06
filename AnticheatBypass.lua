if _G.AntiCheats_Enabled then return end

-- BAC (bladeball anticheat) bypass
for k,v in pairs(getnilinstances()) do
	if v:IsA("LocalScript") then
		for _,func in pairs(getgc()) do
			if type(func) == "function" then
				local sc = getfenv(func).script
				if sc and sc == v then
					for idx,const in pairs(getconstants(func)) do
						if const == "Kick" or const == "FireServer" then
							setconstant(func, idx, "")
						end
					end
					for idx,uv in pairs(getupvalues(func)) do
						if typeof(uv) == "Instance" and (uv.ClassName == "RemoteEvent" or uv.ClassName == "Humanoid") then
							setupvalue(func, idx, nil)
						end
					end
				end
			end
		end
	end
end

local orig_hook1
orig_hook1 = hookfunction(getrenv().require, newcclosure(function(self, ...)
	if not checkcaller() then
		local args = {...}
		local calling_script = getcallingscript()
		
		if game.GetFullName(calling_script) == ".ClientMover" and self.Name == "Client" then
			warn("Adonis anti-cheat loading blocked")
			return task.wait(10e1)
		elseif calling_script.Name == "HDAdminStarterPlayer" and self.Name == "MainFramework" then
			warn("HDAdmin anti-cheat loading blocked")
			return task.wait(10e1)
		end
	end

	return orig_hook1(self, ...)
end))

-- YBA bypass by IceMinisterq, cleaned and added here for convenience
-- src: https://github.com/IceMinisterq/Misc-Script/blob/main/yba%20ac%20bypass.lua
local orig_hook2
orig_hook2 = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
	if not checkcaller() and typeof(self, "Instance") then
		local method = getnamecallmethod()
		local args = {...}

		if rawequal(self.ClassName, "RemoteFunction") then
			if rawequal(args[1], "Reset") or
				(rawequal(self.Name, "Returner") and
				rawequal(args[1], "idklolbrah2de") and
				rawequal(typeof(args[2]), "Vector3")) then
				return "  ___XP DE KEY"
			end
		elseif rawequal(self.ClassName, "RemoteEvent") and rawequal(args[1], "UpdateState") and
				(rawequal(args[2], Enum.HumanoidStateType.PlatformStanding) or
				rawequal(args[2], Enum.HumanoidStateType.Running) or
				rawequal(args[2], Enum.HumanoidStateType.Dead)) then
			return
		end
	end
	return orig_hook2(self, ...)
end))

task.spawn(function()
	-- Adonis bypass by IceMinisterq, cleaned and added here for convenience
	-- src: https://github.com/IceMinisterq/Misc-Script/blob/main/adonis%20ac%20bypass.lua
	repeat task.wait() until game:IsLoaded()

	local function isAdonisAC(tbl) return rawget(tbl, "Detected") and typeof(rawget(tbl, "Detected")) == "function" and rawget(tbl, "RLocked") end

	for _,tbl in next, getgc(true) do
		if typeof(tbl) == "table" and isAdonisAC(tbl) then
			for k,v in next, tbl do
				if rawequal(k, "Detected") then
					local old
					old = hookfunction(v, function(action, info, nocrash)
						if rawequal(action, "_") and rawequal(info, "_") and rawequal(nocrash, true) then
							return old(action, info, nocrash)
						end
						return task.wait(10e1)
					end)
					warn("Adonis anti-cheat bypass setup successful.")
					break
				end
			end
		end
	end
end)

_G.AntiCheats_Enabled = true