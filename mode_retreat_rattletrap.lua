
----------------------------------------------------------------------------------------------------

function OnStart()
	print("Start Clock Mode Laning");
	-- TODO - Use a flask or tango if we have them.
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
	if (npcBot:GetHealth() < npcBot:GetMaxHealth() * .2) then
	 return BOT_ACTION_DESIRE_VERYHIGH;
  end

	return BOT_MODE_DESIRE_NONE;
end

----------------------------------------------------------------------------------------------------

