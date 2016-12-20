function Think()
	if ( GetTeam() == TEAM_RADIANT )
	then
		print( "selecting radiant" );
		SelectHero( 0, "npc_dota_hero_antimage" );
		SelectHero( 1, "npc_dota_hero_rattletrap" );
		SelectHero( 2, "npc_dota_hero_bane" );
		SelectHero( 3, "npc_dota_hero_sniper" );
		SelectHero( 4, "npc_dota_hero_crystal_maiden" );
	elseif ( GetTeam() == TEAM_DIRE )
	then
		print( "selecting dire" );
		SelectHero( 5, "npc_dota_hero_chaos_knight" );
		SelectHero( 6, "npc_dota_hero_earthshaker" );
		SelectHero( 7, "npc_dota_hero_juggernaut" );
		SelectHero( 8, "npc_dota_hero_mirana" );
		SelectHero( 9, "npc_dota_hero_nevermore" );
	end
end

function UpdateLaneAssignments() 
  lanes = {};
  lanes[0] = LANE_BOT;
  lanes[1] = LANE_TOP;
  lanes[2] = LANE_TOP;
  lanes[3] = LANE_MID;
  lanes[4] = LANE_BOT;
  lanes[5] = LANE_TOP;
  lanes[6] = LANE_TOP;
  lanes[7] = LANE_BOT;
  lanes[8] = LANE_BOT;
  lanes[9] = LANE_MID;
  return lanes;
end