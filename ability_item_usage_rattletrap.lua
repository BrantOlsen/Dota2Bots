ba_name = "rattletrap_battery_assault";
cogs_name = "rattletrap_power_cogs";
flare_name = "rattletrap_rocket_flare";
hookshot_name = "rattletrap_hookshot";
last_tango_eaten = 0;

item_usage_generic = dofile( GetScriptDirectory().."/item_usage_generic" );

function AbilityUsageThink()
  local npcBot = GetBot();

  -- Check if we're already using an ability
  if ( npcBot:IsUsingAbility() ) then return end;

  batteryAssualt = npcBot:GetAbilityByName(ba_name);
  cogs = npcBot:GetAbilityByName(cogs_name);
  flare = npcBot:GetAbilityByName(flare_name);
  hookshot = npcBot:GetAbilityByName(hookshot_name);

  local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( 330, true, BOT_MODE_NONE );
  for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
  do
      -- Start with cogs to push or trap.
      if (cogs:IsFullyCastable()) then
        -- TODO - Find cog closest when out numbered and destroy it.
        npcBot:Action_UseAbility(cogs);
      end

      -- Use battery assualt then to kill.
      if (batteryAssualt:IsFullyCastable() and GetUnitToUnitDistance(npcBot, npcEnemy) < 160) then
        npcBot:Action_UseAbility(batteryAssualt);
      end
  end

  -- Finish off heros with flare.
  if (flare:IsFullyCastable()) then
    local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( 1000, true, BOT_MODE_NONE );
    for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
    do
      if (npcEnemy:GetHealth() < flare:GetAbilityDamage() * .8) then
        npcBot:Action_UseAbilityOnLocation(flare, npcEnemy:GetLocation());
        break;
      end
    end
  end

  -- Finish off creeps with flare.
  if (flare:IsFullyCastable() and npcBot:GetMana() > flare:GetManaCost() + cogs:GetManaCost() + hookshot:GetManaCost()) then
    local tableNearbyEnemyCreeps = npcBot:GetNearbyCreeps(1000, true);
    for _,creep in pairs(tableNearbyEnemyCreeps)
    do
      if (creep:GetHealth() < flare:GetAbilityDamage() * .8) then
        npcBot:Action_UseAbilityOnLocation(flare, creep:GetLocation());
        break;
      end
    end
  end

  -- If in fountain, shoot anywhere
  if (flare:IsFullyCastable() and npcBot:DistanceFromFountain() == 0) then
    local tableNearbyEnemyCreeps = npcBot:GetNearbyCreeps(10000, true);
    for _,creep in pairs(tableNearbyEnemyCreeps)
    do
      if (creep:GetHealth() < creep:GetMaxHealth() * .8) then
        npcBot:Action_UseAbilityOnLocation(flare, creep:GetLocation());
        break;
      end
    end
  end

  if (hookshot:CanAbilityBeUpgraded()) then
    npcBot:ActionImmediate_LevelAbility(hookshot_name);
  elseif (batteryAssualt:CanAbilityBeUpgraded() and cogs:GetLevel() > 0 and (flare:GetLevel() > 0 or batteryAssualt:GetLevel() == 0)) then
    npcBot:ActionImmediate_LevelAbility(ba_name);
  elseif (cogs:CanAbilityBeUpgraded() and (flare:GetLevel() > 0 or cogs:GetLevel() == 0)) then
    npcBot:ActionImmediate_LevelAbility(cogs_name);
  elseif (flare:CanAbilityBeUpgraded()) then
    npcBot:ActionImmediate_LevelAbility(flare_name);
  end
end

function ItemUsageThink()
  local npcBot = GetBot();
  item_usage_generic.ItemUsageThink();
end

function CourierUsageThink()
  -- Never use courier please
end

function BuybackUsageThink()
  -- No Buyback Please
end