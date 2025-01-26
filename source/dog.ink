VAR DogRoom = Bedroom
VAR DogHungry = 20
VAR DogThirsty = 10

=== tunnel_dog_tick

~ DogHungry += 1
~ DogThirsty += 1

{ DogThirsty > 10:
    -> tunnel_dog_thirsty ->->
}
{ DogHungry > 20:
    -> tunnel_dog_hungry ->->
}

-> Tunnel_Pathfind(DogRoom,PlayerRoom) ->
~ MoveDog()

->->


=== tunnel_dog_thirsty
-> Tunnel_Pathfind(DogRoom,WaterBowl_Room) ->
{ DogRoom != Pathfinding_Next_Room:
    ~ MoveDog()
    ->->
}
{ WaterBowl_IsFull && ItemInInventory(WaterBowl) == false:
    Dog is drinking from the water bowl.
    ~ DogThirsty = 0
    ~ WaterBowl_IsFull = false
    ->->
}
Dog is barking at the water bowl.
->->

=== tunnel_dog_hungry
-> Tunnel_Pathfind(DogRoom,FoodBowl_Room) ->
{ DogRoom != Pathfinding_Next_Room:
    ~ MoveDog()
    ->->
}
{ FoodBowl_IsFull && ItemInInventory(FoodBowl) == false:
    Dog has eaten all of the food.
    ~ DogHungry = 0
    ~ FoodBowl_IsFull = false
    ->->
}
Dog is barking at the food bowl.
->->


=== function MoveDog()
{ DogRoom != Pathfinding_Next_Room:
    
    { PlayerRoom == Pathfinding_Next_Room:
        The dog has entered the {Pathfinding_Next_Room} from the {DogRoom}
    }
    
    { PlayerRoom == DogRoom:
        The dog has left in the direction of the {Pathfinding_Next_Room}
    }    
    
    ~ DogRoom = Pathfinding_Next_Room
}
~ return
