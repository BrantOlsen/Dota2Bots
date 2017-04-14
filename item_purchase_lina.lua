item_purchase_generic = dofile( GetScriptDirectory().."/item_purchase_generic" );
items = {
  "item_flask",
  "item_tango",
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

function ItemPurchaseThink()
  item_purchase_generic.ItemPurchaseThink(items);
end

----------------------------------------------------------------------------------------------------
