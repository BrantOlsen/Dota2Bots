BotsInit = require( "game/botsinit" );
local item_purchase_generic = BotsInit.CreateGeneric();

function item_purchase_generic.ItemPurchaseThink(items_table)
  local npcBot = GetBot();

  if (npcBot:GetHealth() > 150
      and npcBot:DistanceFromFountain() ~= 0
      and npcBot:GetActiveMode() ~= BOT_MODE_SIDE_SHOP
      and npcBot:GetActiveMode() ~= BOT_MODE_SECRET_SHOP
      and npcBot:GetActiveMode() ~= BOT_MODE_RETREAT)
  then
    return;
  end

	if (items_table[1] == nil)
	then
		npcBot:SetNextItemPurchaseValue(0);
		return;
	end

 -- TODO - Always buy when we don't have one "item_tpscroll"

  npcBot.NextItemName = items_table[1];
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
          npcBot:ActionImmediate_SellItem(item);
          break;
        end
    end

		npcBot:ActionImmediate_PurchaseItem(npcBot.NextItemName);
		table.remove(items_table, 1);
		npcBot.NextItemName = null;
	end
end

return item_purchase_generic;
----------------------------------------------------------------------------------------------------
