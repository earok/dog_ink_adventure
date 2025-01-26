LIST Items = FoodBowl, WaterBowl

VAR FoodBowl_Room = Kitchen
VAR WaterBowl_Room = Lawn

VAR FoodBowl_IsFull = false
VAR WaterBowl_IsFull = false

=== function ItemInInventory(item)
~ return Item_IsInRoom(Player,item) == true

=== function AllItems_InRoom(room)
~ temp ListResult = ()
{ FoodBowl_Room == room:
    ~ ListResult += FoodBowl
}
{ WaterBowl_Room == room:
    ~ ListResult += WaterBowl
}
~ return ListResult

=== function Item_IsInRoom(room,item)
~ return AllItems_InRoom(room) has item

=== function TransferItem(item,to)
{ item:
    - FoodBowl:
        ~ FoodBowl_Room = to
    - WaterBowl:
        ~ WaterBowl_Room = to
}
~ return
