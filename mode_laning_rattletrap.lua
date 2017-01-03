
----------------------------------------------------------------------------------------------------

--function Think()
--	local npcBot = GetBot();-
--	local myLoc = npcBot:GetLocation();
--	myLoc.x = myLoc.x + 250;
--	myLoc.y = myLoc.y + 250;
--	npcBot:Action_MoveToLocation(myLoc);

 --slocal npcBot = GetBot();
  --npcBot:Action_MoveToLocation(Vector(-6360.558105, 3148.155273, 384.000000));
  --npcBot:Action_MoveToLocation(Vector(-5000, 2500, 384.000000));
  --npcBot:Action_MoveToLocation(Vector(-7500, 4500, 384.000000));
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

