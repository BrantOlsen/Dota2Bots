

local tableItemsToBuy = { 
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
	"item_lotus_orb"
};


----------------------------------------------------------------------------------------------------

function ItemPurchaseThink()
  local npcBot = GetBot();
  
	if ( #tableItemsToBuy == 0 )
	then
		npcBot:SetNextItemPurchaseValue( 0 );
		return;
	end

 -- TODO - Always buy when we don't have one "item_tpscroll"

	local sNextItem = tableItemsToBuy[1];
  local nextItemCost = GetItemCost(sNextItem);
	npcBot:SetNextItemPurchaseValue(nextItemCost);
	if (npcBot:GetGold() >= nextItemCost)
	then
		npcBot:Action_PurchaseItem( sNextItem );
		table.remove( tableItemsToBuy, 1 );
	end

end

----------------------------------------------------------------------------------------------------
