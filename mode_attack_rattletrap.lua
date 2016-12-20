

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
	local goodHeath = npcBot:GetHealth() > npcBot:GetMaxHealth() * .4;
  if (npcBot:GetAbilityByName("rattletrap_battery_assault"):IsInAbilityPhase() and goodHeath) then
    print("rattletrap_battery_assault is active fighting.");
		return BOT_MODE_DESIRE_ABSOLUTE;
	elseif (goodHealth) then
	  return BOT_MODE_DESIRE_MODERATE;
  else
    return BOT_MODE_DESIRE_VERYLOW;
	end
end

----------------------------------------------------------------------------------------------------

