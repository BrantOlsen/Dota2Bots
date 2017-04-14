BotsInit = require( "game/botsinit" );
local AbilityModule = BotsInit.CreateGeneric();

function AbilityModule.AbilityLevelUpThink(ability_table)
  if GetGameState() ~= GAME_STATE_GAME_IN_PROGRESS and GetGameState() ~= GAME_STATE_PRE_GAME 
  then
    return
  end

  if (ability_table[1] == nil)
  then
	return false;
  end
  
  ability = GetBot():GetAbilityByName(ability_table[1]);
  if (GetBot():GetAbilityPoints() > 0 and ability:CanAbilityBeUpgraded() and ability:GetLevel() < ability:GetMaxLevel()) 
  then
    GetBot():ActionImmediate_LevelAbility(ability_table[1]);
	table.remove(ability_table, 1);
	return true;
  end
  
  return false;
end

return AbilityModule;