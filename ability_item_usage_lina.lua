aoe = "lina_dragon_slave";
stun = "lina_light_strike_array";
ult = "lina_laguna_blade";
last_tango_eaten = 0;

function AbilityUsageThink()
  local npcBot = GetBot();
  
  -- Check if we're already using an ability
  if ( npcBot:IsUsingAbility() ) then return end;
  
  aoeAbility = npcBot:GetAbilityByName(aoe);
  stunAbility = npcBot:GetAbilityByName(stun);
  ultAbility = npcBot:GetAbilityByName(ult);
  
  local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( 1000, true, BOT_MODE_NONE );
  for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
  do
    print("AnilityUsageThink");
      if (aoeAbility:IsFullyCastable()) then
        npcBot:Action_UseAbilityOnLocation(aoeAbility, npcEnemy:GetLocation());
      end
  end

end

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

function CourierUsageThink() 
  -- Never use courier please
end

function BuybackUsageThink()
  -- No Buyback Please
end

function AbilityLevelUpThink()
  if GetGameState() ~= GAME_STATE_GAME_IN_PROGRESS and GetGameState() ~= GAME_STATE_PRE_GAME
  then
    return
  end

  local npcBot = GetBot();
  aoeAbility = npcBot:GetAbilityByName(aoe);
  if (aoeAbility:CanAbilityBeUpgraded()) then
    npcBot:ActionImmediate_LevelAbility(aoe);
  end
end