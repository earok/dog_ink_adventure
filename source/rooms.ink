LIST Rooms = Bedroom, Bathroom, Hallway, Staircase, LivingRoom, Kitchen, Lawn, Pantry

VAR LawnTapIsOn = false


=== function AdjacentTo(room)
{ room:

    - Bedroom:
        ~ return (Hallway)
        
    - Bathroom:
        ~ return (Hallway)
        
    - Hallway:
        ~ return (Bedroom, Bathroom, Staircase)
        
    - Staircase:
        ~ return (Hallway, LivingRoom)
        
    - LivingRoom:
        ~ return (Kitchen, Lawn, Staircase)
        
    - Lawn:
        ~ return (LivingRoom)
        
    - Kitchen:
        ~ return (LivingRoom,Pantry)
        
    - Pantry:
        ~ return (Kitchen)
}

~ return () //Return list with no entries

=== function Goto(room)
~ PlayerRoom = room
~ return

//Finds the next step between any two rooms in the game
=== function PathFind(from,to)
//If we're trying to pathfind to the player, instead pathfind to the room the player is in
{ to == Player:
    ~ to = PlayerRoom
}
//Are we already in the right room?
{ to == from:
    ~ return to
}
~ temp roomsToCheckNow = ()
~ roomsToCheckNow += to
~ return PathFindRecursively(roomsToCheckNow,(),(),from)

=== GenerateRoomOptions(rooms)
//No more rooms need to be added to the list
{ LIST_COUNT(rooms) == 0:
    -> DONE
}
~ temp thisRoom = LIST_MIN(rooms)
<- GenerateRoomOptions(rooms - thisRoom)

+ [ Go to {thisRoom} ] 
    ~ Goto(thisRoom)
    -> tick

- -> DONE

//Inner recursive function for pathfinding
=== function PathFindRecursively(roomsToCheckNow, roomsToCheckNext, roomsToExclude, startingPoint)
{ LIST_COUNT(roomsToCheckNow) == 0:
    //We're out of rooms in the current list to check, go to the next list
    ~ roomsToCheckNow = roomsToCheckNext - roomsToExclude
    ~ roomsToCheckNext = ()
}

~ temp roomToCheck = LIST_MIN(roomsToCheckNow)
~ roomsToCheckNow -= roomToCheck

//Is this room adjacent to the starting point? If so, we have our path
{ AdjacentTo(roomToCheck) has startingPoint:
    ~ return roomToCheck
}

//We don't need to check this room again
~ roomsToExclude += roomToCheck

//Otherwise, populate rooms to check next with all adjacent rooms, and dig deeper
~ roomsToCheckNext += AdjacentTo(roomToCheck)
~ return PathFindRecursively(roomsToCheckNow,roomsToCheckNext,roomsToExclude,startingPoint)







