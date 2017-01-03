function Think() 
  local npcBot = GetBot();
  -- TODO - Use a constant for the side shop location.
  npcBot:Action_MoveToLocation(Vector(-7500, 4500, 384.000000));
end


function GetDesire()
  local npcBot = GetBot();
  local npcDistFromSS = npcBot:DistanceFromSideShop();
  -- Are we close to the side shop and have an item to buy.
  if (npcDistFromSS < 2000 and npcBot.NextItemName ~= nil) then
    local nearbyEnemyHeroes = npcBot:GetNearbyHeroes(1000, true, BOT_MODE_NONE);
    for _,npcEnemy in pairs(nearbyEnemyHeroes)
    do
       -- Do not die by going to the side shop when someone else is there.
       if (npcDistFromSS > npcEnemy:DistanceFromSideShop()) then
          return BOT_MODE_DESIRE_NONE;
       end
    end
  
    -- Go buy the item.
    if (GetItemCost(npcBot.NextItemName) < npcBot:GetGold() and IsItemPurchasedFromSideShop(npcBot.NextItemName)) then
      return BOT_MODE_DESIRE_VERYHIGH;
    end
  else
    return BOT_MODE_DESIRE_NONE;
  end
end