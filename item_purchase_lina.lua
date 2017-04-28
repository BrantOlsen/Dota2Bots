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
  "item_void_stone",
  "item_staff_of_wizardry",
  "item_wind_lace",
  "item_recipe_cyclone",
  "item_force_staff",
};

function ItemPurchaseThink()
  item_purchase_generic.ItemPurchaseThink(items);
end

----------------------------------------------------------------------------------------------------
