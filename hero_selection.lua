function Think()
	if ( GetTeam() == TEAM_RADIANT )
	then
		--SelectHero( 0, "npc_dota_hero_antimage" );
		SelectHero( 1, "npc_dota_hero_rattletrap" );
		SelectHero( 2, "npc_dota_hero_bane" );
		SelectHero( 3, "npc_dota_hero_sniper" );
		SelectHero( 4, "npc_dota_hero_crystal_maiden" );
	elseif ( GetTeam() == TEAM_DIRE )
	then
		SelectHero( 5, "npc_dota_hero_chaos_knight" );
		SelectHero( 6, "npc_dota_hero_earthshaker" );
		SelectHero( 7, "npc_dota_hero_juggernaut" );
		SelectHero( 8, "npc_dota_hero_mirana" );
		SelectHero( 9, "npc_dota_hero_nevermore" );
	end
end

function UpdateLaneAssignments() 
    if (GetTeam() == TEAM_RADIANT)
    then
        return {
          [1] = LANE_BOT,
          [2] = LANE_TOP,
          [3] = LANE_TOP,
          [4] = LANE_MID,
          [5] = LANE_BOT,
        };
    elseif (GetTeam() == TEAM_DIRE)
    then
        return {
          [1] = LANE_TOP,
          [2] = LANE_TOP,
          [3] = LANE_BOT,
          [4] = LANE_BOT,
          [5] = LANE_MID,
        };
    end
end