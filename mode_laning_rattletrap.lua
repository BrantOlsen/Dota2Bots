
----------------------------------------------------------------------------------------------------

function OnStart()
	print("Start Clock Mode Laning");
end

----------------------------------------------------------------------------------------------------

function OnEnd()
	-- Do the standard OnEnd
	print("End Clock Mode Laning");
end

----------------------------------------------------------------------------------------------------

--function Think()
--	local npcBot = GetBot();-
--	local myLoc = npcBot:GetLocation();
--	myLoc.x = myLoc.x + 250;
--	myLoc.y = myLoc.y + 250;
--	npcBot:Action_MoveToLocation(myLoc);
--end

----------------------------------------------------------------------------------------------------

function GetDesire()
	local npcBot = GetBot();
	-- "rattletrap_battery_assault"
	-- "rattletrap_power_cogs"
	-- "rattletrap_rocket_flare"
	
  if (npcBot:GetAbilityByName("rattletrap_hookshot"):IsFullyCastable()) then
    print("Hookshot off cooldown, trying to use it for a kill.");
		return BOT_MODE_DESIRE_VERYLOW;
	end

	return BOT_MODE_DESIRE_ABSOLUTE;
end

----------------------------------------------------------------------------------------------------

