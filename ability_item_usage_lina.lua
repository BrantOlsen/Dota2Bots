distanceToInitiate = 600;
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
  local bot = GetBot();

  -- Check if we're already using an ability
  if ( bot:IsUsingAbility() ) then return end;

  aoeAbility = bot:GetAbilityByName(aoe);
  stunAbility = bot:GetAbilityByName(stun);
  ultAbility = bot:GetAbilityByName(ult);

  -- Stun
  --   1. If stun + aoe kills a hero in range.
  --   2. If enemy is in tower range then stun them.
  --   3. If 1 extra friendly with mana is nearby then stun closest hero and signal to attack it.
  --   4. If retreating and nearby hero stun them.

  local tableNearbyEnemyHeroes = bot:GetNearbyHeroes( 1000, true, BOT_MODE_NONE );
  for _,enemy in pairs(tableNearbyEnemyHeroes)
  do
	-- ULT
	--   1. Hero is at max range and will die from ult.
	--   2. Enemy hero can be killed and is with only max 1 other.
	--   3. You are about to die.
	--   4. At least 3 of them and 3 of you then use it kill first change.
	local useUlt = false;
	-- Only check for casting ult if enemy is not BKBed and we can cast our ult.
	if (ultAbility:IsFullyCastable() and not enemy:IsMagicImmune()) then
		if (bot:GetHealth() < 200) then
			useUlt = true;
		end

		local enemyDistance = GetUnitToUnitDistance(bot, enemy);
		-- Only use ult if it will kill the enemey and they are in ult cast range.
		if (enemy:GetHealth() < ultAbility:GetAbilityDamage() * (1 - enemy:GetMagicResist()) and enemyDistance < ultAbility:GetCastRange()) then
			-- Do not let them get away on 1 health.
			if (enemyDistance > ultAbility:GetCastRange() - 100) then
				useUlt = true;
			-- Use the ult as early as possible to get a kill in a teamfight.
			elseif (#tableNearbyEnemyHeroes >= 2) then
				useUlt = true;
			end
		end

		if (useUlt) then
			box:Action_UseAbilityOnEntity(ultAbility, enemy);
		end
	end
		
	-- AOE / Flame / First Abliity
	--   1. If low life enemey in range and can kill them use it.
    if (aoeAbility:IsFullyCastable() and not enemy:IsMagicImmune()) then
		if (enemy:GetHealth() < aoeAbility:GetAbilityDamage() * (1 - enemy:GetMagicResist()) and enemyDistance < aoeAbility:GetCastRange()) then
			box:Action_UseAbilityOnEntity(aoeAbility, enemey);
		end
	end
  end

  -- AOE / Flame / First Abliity
  --   2. If you have > 66% mana use it on the closest hero and another hero/creep
  --   3. If you are retreating and have mana for it just use it on closest hero/creep.
  --   4. If you have > 20% mana and mana regen above 5 then use it on any creeps/hero.
  if (aoeAbility:IsFullyCastable() and (bot:GetMana() > (bot:GetMaxMana() * .66) or (bot:GetMana() > (bot:GetMaxMana() * .2) and bot:GetManaRegen() > 5))) then
	local useAoe = false;
	local aoeTarget = nil;
	  -- Find all nearby enemy creeps.
	  local tableNearbyEnemyCreeps = bot:GetNearbyCreeps(600, true);
	  if (#tableNearbyEnemyCreeps >= 2) then
		for _,creep in pairs(tableNearbyEnemyCreeps)
		  do
			print("Found creep nearby...");
			if (creep:GetHealth() < aoeAbility:GetAbilityDamage()) then
			  useAoe = true;
			  aoeTarget = creep:GetLocation();
			  for _,enemy in pairs(tableNearbyEnemyHeroes)
			  do
				local enemyPos = enemy:GetLocation();
				print("Found an enemey nearby too...");
				aoeTarget = Vector((enemyPos.x + aoeTarget.x) / 2, (enemyPos.y + aoeTarget.y) / 2, 0);
				break;
			  end
			  break;
			end
		  end
	  end
	  
	if (useAoe) then
		print("Using ability...");
		bot:ActionPush_UseAbilityOnLocation(aoeAbility, aoeTarget);
	end
  end
end

function ItemUsageThink()
  item_usage_generic.ItemUsageThink();

  local npcBot = GetBot();

  for i = 0, 5 do
    local item = npcBot:GetItemInSlot(i);
    if (item and item:GetName() == "item_cyclone") then --and item:IsCooldownReady()
        local nearbyEnemys = npcBot:GetNearbyHeroes( 570, true, BOT_MODE_NONE );
        for _,npcEnemy in pairs( nearbyEnemys ) do
            local useAbility = false;
            aoeAbility = npcBot:GetAbilityByName(aoe);
            ultAbility = npcBot:GetAbilityByName(ult);

            if (npcBot:GetActiveMode() == BOT_MODE_RETREAT and not npcEnemy:IsStunned()) then
                useAbility = true;
            elseif ((aoeAbility:GetAbilityDamage() + ultAbility:GetAbilityDamage()) >= npcEnemy:GetHealth()) then
                useAbility = true;
            else
                local nearbyFriendlies = npcBot:GetNearbyHeroes( distanceToInitiate, true, BOT_MODE_NONE );
                if (#nearbyFriendlies > 0) then
                    useAbility = true;
                end
            end
            if (useAbility) then
                npcBot:Action_UseAbilityOnEntity(item, npcEnemy);
                break;
            end
        end
        break;
    end
  end

  -- Buy a Eul's Scepter of Divinity (item_cyclone)
  -- Eul's Scepter
  --   1. If retreating and nearby hero is not stunned use it.
  --   2. If you can kill a hero with stun -> aoe -> ult use it.
  --   3. If 1 extra friendly is nearby and you can stun then use it.
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