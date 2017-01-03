function Think() 
  --local npcBot = GetBot();
  --npcBot:Action_MoveToLocation()
end


function GetDesire()
  local npcBot = GetBot();
  local npcDistFromSS = npcBot:DistanceFromSideShop();
  if (npcDistFromSS < 2000 and npcBot.NextItemName ~= nil) then
    print(npcBot:GetLocation());
  
    local nearbyEnemyHeroes = npcBot:GetNearbyHeroes(1000, true, BOT_MODE_NONE);
    for _,npcEnemy in pairs(nearbyEnemyHeroes)
    do
       -- Do not die by going to the side shop when someone else is there.
       if (npcDistFromSS > npcEnemy:DistanceFromSideShop()) then
          print("an enemy is closer " .. npcEnemy:GetUnitName());
          return BOT_MODE_DESIRE_NONE;
       end
    end
  
    if (GetItemCost(npcBot.NextItemName) < npcBot:GetGold() and IsItemPurchasedFromSideShop(npcBot.NextItemName)) then
      print("going to side shop " .. npcBot:GetUnitName())
      return BOT_MODE_DESIRE_VERYHIGH;
    else 
      print("Item " .. npcBot.NextItemName .. " is not at side shop or my gold " .. npcBot:GetGold() .. " is not enough.");
    end
  else
    return BOT_MODE_DESIRE_NONE;
  end
end