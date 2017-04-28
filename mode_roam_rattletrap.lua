

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
	local hasEnoughMana = npcBot:GetMana() > npcBot:GetMaxMana() * .9;
	local hasEnoughHealth = npcBot:GetHealth() > npcBot:GetMaxHealth() * .9;
  if (npcBot:GetAbilityByName("rattletrap_hookshot"):IsTrained() and hasEnoughMana and hasEnoughHealth) then
    -- TODO - Need a Think here since the computer has no idea what roaming is.
		return BOT_ACTION_DESIRE_VERYLOW;
	end

	return BOT_ACTION_DESIRE_VERYLOW;
end

----------------------------------------------------------------------------------------------------

