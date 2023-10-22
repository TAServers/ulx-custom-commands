local savedPos = {}
function ulx.setwarp(calling_ply, name)
	if not name[1] then
		return
	end
	savedPos[tostring(name[1])] = calling_ply:GetPos()
	for _, v in ipairs(player.GetAll()) do
		if v:IsUserGroup("operator") or v:IsAdmin() then
			ULib.tsayColor(
				v,
				false,
				Color(255, 255, 255),
				"A new warp location has been created: ",
				Color(255, 0, 0),
				name
			)
		end
	end
	ulx.fancyLogAdmin(calling_ply, true, "#A set warp position #s", name)
end
local setwarp = ulx.command("Teleport", "ulx setwarp", ulx.setwarp, "!setwarp")
setwarp:addParam({ type = ULib.cmds.StringArg, hint = "name" })
setwarp:addParam({ type = ULib.cmds.BoolArg, invisible = true })
setwarp:defaultAccess(ULib.ACCESS_ADMIN)
setwarp:help("Sets a warp position.")

function ulx.warp(calling_ply, name)
	if not name[1] then
		return
	end
	for k, v in pairs(savedPos) do
		if k == tostring(name[1]) then
			calling_ply:SetPos(v)
		end
	end
	ulx.fancyLogAdmin(calling_ply, "#A warped to #s", name)
end
local warp = ulx.command("Teleport", "ulx warp", ulx.warp, "!warp")
warp:addParam({ type = ULib.cmds.StringArg, hint = "name" })
warp:defaultAccess(ULib.ACCESS_ADMIN)
warp:help("Warps to a set position")
