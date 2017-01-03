
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
	 
	-- Get the starting rune.
	if (DotaTime() < 0 ) then
	 return BOT_MODE_DESIRE_VERYLOW;
  end
	  
	-- If we have hookshot get kills.
  if (npcBot:GetAbilityByName("rattletrap_hookshot"):IsTrained()) then
		return BOT_MODE_DESIRE_VERYLOW;
	end

  -- Low on life then go out of here.
  local hasEnoughHealth = npcBot:GetHealth() > npcBot:GetMaxHealth() * .3;
  if (hasEnoughHealth) then
    return BOT_ACTION_DESIRE_HIGH;
	end
	
	return BOT_MODE_DESIRE_VERYLOW;
end

----------------------------------------------------------------------------------------------------

