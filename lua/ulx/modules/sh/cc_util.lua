function ulx.maprestart(calling_ply)
	timer.Simple(1, function ()
		game.ConsoleCommand("changelevel " .. tostring(game.GetMap()) .. "\n")
	end)
	ulx.fancyLogAdmin(calling_ply, "#A forced a mapchange")
end
local maprestart = ulx.command("Utility", "ulx maprestart", ulx.maprestart, "!maprestart")
maprestart:defaultAccess(ULib.ACCESS_SUPERADMIN)
maprestart:help("Forces a mapchange to the current map.")

function ulx.cleardecals(calling_ply)
	for _, v in ipairs(player.GetAll()) do
		if (IsValid(v) && v:IsPlayer()) then
			for i = 1, 3 do // Run a few times to ensure that all decals get removed.
				v:ConCommand("r_cleardecals")
			end
		end
	end
	ulx.fancyLogAdmin(calling_ply, "#A cleared decals")
end
local cleardecals = ulx.command("Utility", "ulx cleardecals", ulx.cleardecals, "!cleardecals")
cleardecals:defaultAccess(ULib.ACCESS_ADMIN)
cleardecals:help("Clear decals for all players.")

function ulx.resetmap(calling_ply)
	game.CleanUpMap()
	ulx.fancyLogAdmin(calling_ply, "#A reset the map to its original state")
end
local resetmap = ulx.command("Utility", "ulx resetmap", ulx.resetmap, "!resetmap")
resetmap:defaultAccess(ULib.ACCESS_SUPERADMIN)
resetmap:help("Resets the map to its original state.")

function ulx.forcerespawn(calling_ply, target_plys)
	for _, v in pairs(target_plys) do
		if (v:Alive()) then
			v:Kill()
		end
		if (GetConVar("gamemode"):GetString() == "terrortown") then
			v:SpawnForRound(true)
		else
			v:Spawn()
		end
	end
	ulx.fancyLogAdmin(calling_ply, "#A respawned #T", target_plys)
end
local forcerespawn = ulx.command("Utility", "ulx forcerespawn", ulx.forcerespawn, {"!forcerespawn", "!frespawn"})
forcerespawn:addParam{type = ULib.cmds.PlayersArg}
forcerespawn:defaultAccess(ULib.ACCESS_ADMIN)
forcerespawn:help("Force-respawn a player.")

function ulx.removeragdolls(calling_ply)
	for _, v in ipairs(player.GetAll()) do
		if (IsValid(v) && !v:IsBot()) then
			v:SendLua([[game.RemoveRagdolls()]])
		end
	end
	ulx.fancyLogAdmin(calling_ply, "#A removed ragdolls")
end
local removeragdolls = ulx.command("Utility", "ulx removeragdolls", ulx.removeragdolls, "!removeragdolls")
removeragdolls:defaultAccess(ULib.ACCESS_ADMIN)
removeragdolls:help("Remove all ragdolls.")
