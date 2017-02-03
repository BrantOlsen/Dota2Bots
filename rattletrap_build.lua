X = {};

X["items"] = {
  "item_flask",
  "item_tango",
  "item_stout_shield",
  "item_branches",
  "item_branches",
  "item_boots",
  "item_ring_of_regen",
  "item_ring_of_protection",
  "item_infused_raindrop",
  "item_force_staff",
  "item_point_booster",
  "item_ogre_axe",
  "item_staff_of_wizardry",
  "item_blade_of_alacrity",
  "item_recipe_ultimate_scepter",
  "item_lotus_orb",
};

-- Set up Skill build
local SKILL_Q = "crystal_maiden_crystal_nova";
local SKILL_W = "crystal_maiden_frostbite";
local SKILL_E = "crystal_maiden_brilliance_aura";
local SKILL_R = "crystal_maiden_freezing_field";    

local ABILITY1  = "special_bonus_magic_resistance_15"
local ABILITY2  = "special_bonus_attack_damage_50"
local ABILITY3  = "special_bonus_cast_range_125"
local ABILITY4  = "special_bonus_hp_200"
local ABILITY5  = "special_bonus_gold_income_20"
local ABILITY6  = "special_bonus_respawn_reduction_35"
local ABILITY7  = "special_bonus_unique_crystal_maiden_1"
local ABILITY8  = "special_bonus_unique_crystal_maiden_2"

--use -1 for levels that shouldn't level a skill
X["skills"] = {
    SKILL_W,    SKILL_Q,    SKILL_E,    SKILL_Q,    SKILL_Q,
    SKILL_R,    SKILL_Q,    SKILL_W,    SKILL_W,    ABILITY1,
    SKILL_W,    SKILL_R,    SKILL_E,    SKILL_E,    ABILITY3,
    SKILL_E,    "-1",     SKILL_R,    "-1",     ABILITY5,
    "-1",       "-1",       "-1",       "-1",       ABILITY7
};

return X