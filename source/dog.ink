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

~ MoveDog(PathFind(DogRoom,PlayerRoom))

->->


=== tunnel_dog_thirsty
~ temp nextRoom = PathFind(DogRoom,WaterBowl_Room)
{ DogRoom != nextRoom:
    ~ MoveDog(nextRoom)
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
~ temp nextRoom = PathFind(DogRoom,WaterBowl_Room)
{ DogRoom != nextRoom:
    ~ MoveDog(nextRoom)
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


=== function MoveDog(NextDogRoom)
{ DogRoom != NextDogRoom:
    
    { PlayerRoom == NextDogRoom:
        The dog has entered the {NextDogRoom} from the {DogRoom}
    }
    
    { PlayerRoom == DogRoom:
        The dog has left in the direction of the {NextDogRoom}
    }    
    
    ~ DogRoom = NextDogRoom
}
~ return
