aoe = "lina_dragon_slave";
stun = "lina_light_strike_array";
ult = "lina_laguna_blade";
passive = "lina_fiery_soul";
last_tango_eaten = 0;
ability_order = {
	stun,
	aoe,
	aoe,
	passive,
	aoe,
	ult,
	aoe,
	stun,
	stun,
	stun,
	passive,
	ult,
	passive,
	passive,
	passive,
	ult
};

item_usage_generic = dofile( GetScriptDirectory().."/item_usage_generic" );

function AbilityUsageThink()
  local npcBot = GetBot();
  
  -- Check if we're already using an ability
  if ( npcBot:IsUsingAbility() ) then return end;

  aoeAbility = npcBot:GetAbilityByName(aoe);
  stunAbility = npcBot:GetAbilityByName(stun);
  ultAbility = npcBot:GetAbilityByName(ult);
  
  local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( 1000, true, BOT_MODE_NONE );  
  local tableNearbyFriendlyHeros = npcBot:GetNearbyHeroes( 600, false, BOT_MODE_NONE );
  local enoughManaHealth = false;
  local chosenFriend = nil;
  
  
  for _,npcFriendly in pairs( tableNearbyFriendlyHeros )
  do
      if (npcFriendly:GetMana() > 50 and npcFriendly:GetHealth() > 50) then
        for _,npcEnemy in pairs( tableNearbyEnemyHeroes )
          do
              if (stunAbility:IsFullyCastable()) then
                npcBot:Action_UseAbilityOnLocation(aoeAbility, npcEnemy:GetLocation());
              end
          end
        break;
      end
  end

  
end


BotsInit = require( "game/botsinit" );
local ability_usage_generic = BotsInit.CreateGeneric();
ability_usage_generic.AbilityUsageThink = AbilityUsageThink;
return ability_usage_generic;