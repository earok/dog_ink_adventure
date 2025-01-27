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

+ [ Go to ]
    -> GotoMenu

+ [ Wait ]
    -> tick

=== GotoMenu
<- GenerateRoomOptions(AdjacentTo(PlayerRoom))
+ [ Never mind ] -> tick

=== PickupItemMenu
<- GeneratePickupOptions(AllItems_InRoom(PlayerRoom))
+ [ Never mind ] -> tick

=== DropItemMenu
<- GenerateDropOptions(AllItems_InRoom(Player))
+ [ Never mind ] -> tick

