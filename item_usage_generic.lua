last_tango_eaten = 0;

function ItemUsageThink()
  local npcBot = GetBot();

  -- Use a flask when low life.
  if (npcBot:GetHealth() < npcBot:GetMaxHealth() - 350) then
      for i = 0, 5 do
        local item = npcBot:GetItemInSlot(i);
        if (item and item:GetName() == "item_flask") then
          -- Make sure no one can cancel it.
          local nearbyEnemys = npcBot:GetNearbyHeroes(600, true, BOT_MODE_NONE);
          if (#nearbyEnemys == 0)  then
            npcBot:Action_UseAbilityOnEntity(item, npcBot);
          end
        end
    end
  end

  -- Use a tango when medium life. Make sure we do not stack eating tangos.
  if (npcBot:GetHealth() < npcBot:GetMaxHealth() - 200 and last_tango_eaten < DotaTime() - 15) then
    for i = 0, 5 do
        local item = npcBot:GetItemInSlot(i);
        if (item and item:GetName() == "item_tango") then
          trees = npcBot:GetNearbyTrees(300);
          if (#trees > 0) then
            last_tango_eaten = DotaTime();
            npcBot:Action_UseAbilityOnTree(item, trees[1]);
          end
        end
    end
  end
end


BotsInit = require( "game/botsinit" );
local item_usage_generic = BotsInit.CreateGeneric();
item_usage_generic.ItemUsageThink = ItemUsageThink;
return item_usage_generic;