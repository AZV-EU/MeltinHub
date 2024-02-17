local Hook
Hook = hookfunction(getrenv().require, newcclosure(function(...)
	local Args = {...}

	if not checkcaller() then
		if (game.GetFullName(getcallingscript()) == ".ClientMover" and Args[1].Name == "Client") or
			(getcallingscript().Name == "HDAdminStarterPlayer" and Args[1].Name == "MainFramework") then
			warn("Anti-cheat blocked.")
			--rconsolewarn("Anti-Cheat blocked from running, have fun exploiting with method { Require:Adonis|Client }");
			return wait(10e1)
		end
	end

	return Hook(unpack(Args))
end))