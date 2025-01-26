=== tick
You are in the {PlayerRoom}.

-> tunnel_dog_tick ->

{ LawnTapIsOn:
    
    { PlayerRoom == Lawn:
        The tap is currently running.
    }
    
    { Item_IsInRoom(Lawn,WaterBowl) && WaterBowl_IsFull == false:
        ~ WaterBowl_IsFull = true
        { PlayerRoom == Lawn:
            The waterbowl is now full.
        }
    }
    
}

{ Item_IsInRoom(PlayerRoom,FoodBowl): The dog's food bowl is here, and it is {FoodBowl_IsFull:full of food|empty}.} 
{ Item_IsInRoom(PlayerRoom,WaterBowl): The dog's water bowl is here, and it is {WaterBowl_IsFull:full of water|empty}.} 

+ { Item_IsInRoom(Player,FoodBowl) && PlayerRoom == Pantry && FoodBowl_IsFull == false } [ Put food in dog's food bowl ]
    You've filled the dog's bowl with food
    ~ FoodBowl_IsFull = true
    -> tick

+ { LIST_COUNT(AllItems_InRoom(PlayerRoom)) > 0 } [ Pick up item ] -> PickupItemMenu

+ { LIST_COUNT(AllItems_InRoom(Player)) > 0 } [ Drop item ] -> DropItemMenu

+ { PlayerRoom == Lawn && LawnTapIsOn == false } [ Turn on tap ]
    ~ LawnTapIsOn = true
    -> tick

+ { PlayerRoom == Lawn && LawnTapIsOn == true } [ Turn off tap ]
    ~ LawnTapIsOn = false
    -> tick

+ {AdjacentTo(PlayerRoom) has Bedroom } [ Go into bedroom ]
    ~ Goto(Bedroom)
    -> tick

+ {AdjacentTo(PlayerRoom) has Hallway } [ Go into hallway ]
    ~ Goto(Hallway)
    -> tick

+ {AdjacentTo(PlayerRoom) has Bathroom } [ Go into bathroom ]
    ~ Goto(Bathroom)
    -> tick

+ {AdjacentTo(PlayerRoom) has Staircase } [ Go to staircase ]
    ~ Goto(Staircase)
    -> tick

+ {AdjacentTo(PlayerRoom) has LivingRoom } [ Go to the living room ]
    ~ Goto(LivingRoom)
    -> tick

+ {AdjacentTo(PlayerRoom) has Kitchen } [ Go to the kitchen ]
    ~ Goto(Kitchen)
    -> tick

+ {AdjacentTo(PlayerRoom) has Lawn } [ Go outside ]
    ~ Goto(Lawn)
    -> tick
    
+ {AdjacentTo(PlayerRoom) has Pantry } [ Go to the pantry ]
    ~ Goto(Pantry)
    -> tick    
    
+ [ Wait ]
    -> tick

=== PickupItemMenu
+ { Item_IsInRoom(PlayerRoom,FoodBowl) } [ Pick up dog's food bowl ]
    ~ TransferItem(FoodBowl,Player)

+ { Item_IsInRoom(PlayerRoom,WaterBowl) } [ Pick up dog's water bowl ]
    ~ TransferItem(WaterBowl,Player)

+ [ Never mind ]

-
-> tick

=== DropItemMenu

+ { Item_IsInRoom(Player,FoodBowl) } [ Drop dog's food bowl ]
    ~ TransferItem(FoodBowl,PlayerRoom)

+ { Item_IsInRoom(Player,WaterBowl) } [ Drop dog's water bowl ]
    ~ TransferItem(WaterBowl,PlayerRoom)

+ [ Never mind ]

-
-> tick



