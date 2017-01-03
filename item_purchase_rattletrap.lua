

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
  
  if (npcBot:GetHealth() > 150 
      and npcBot:DistanceFromFountain() ~= 0
      and npcBot:GetActiveMode() ~= BOT_MODE_SIDE_SHOP 
      and npcBot:GetActiveMode() ~= BOT_MODE_SECRET_SHOP 
      and npcBot:GetActiveMode() ~= BOT_MODE_RETREAT) 
  then
    return
  end
  
	if (#tableItemsToBuy == 0)
	then
		npcBot:SetNextItemPurchaseValue(0);
		return;
	end

 -- TODO - Always buy when we don't have one "item_tpscroll"
 
  npcBot.NextItemName = tableItemsToBuy[1];
  local nextItemCost = GetItemCost(npcBot.NextItemName);
  npcBot:SetNextItemPurchaseValue(nextItemCost);
  canBuyAtSideShop = npcBot:DistanceFromSideShop() < 100 and IsItemPurchasedFromSideShop(npcBot.NextItemName);
  canBuyAtFountain = npcBot:DistanceFromFountain() == 0 and not IsItemPurchasedFromSecretShop(npcBot.NextItemName);
	if (npcBot:GetGold() >= nextItemCost and (canBuyAtSideShop or canBuyAtFountain))
	then
	  -- Sell a single branche if it exists.
	  for i = 0, 5 do
        local item = npcBot:GetItemInSlot(i);
        if (item and item:GetName() == "item_branches") then
          npcBot:Action_SellItem(item);
          break;
        end
    end
	
		npcBot:Action_PurchaseItem(npcBot.NextItemName);
		table.remove(tableItemsToBuy, 1);
		npcBot.NextItemName = null;
	end

end

----------------------------------------------------------------------------------------------------
