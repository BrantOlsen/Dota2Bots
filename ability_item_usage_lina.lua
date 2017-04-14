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

generic_ability = dofile( GetScriptDirectory().."/ability_level_up" );

item_usage_generic = dofile( GetScriptDirectory().."/item_usage_generic" );

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
      if (aoeAbility:IsFullyCastable()) then
        npcBot:Action_UseAbilityOnLocation(aoeAbility, npcEnemy:GetLocation());
      end
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

function AbilityLevelUpThink()
  generic_ability.AbilityLevelUpThink(ability_order);
end