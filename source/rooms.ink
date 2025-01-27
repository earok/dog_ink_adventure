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
~ return PathFindRecursively(roomsToCheckNow,(),from)

//Inner recusrive function for pathfinding
=== function PathFindRecursively(roomsToCheckNow, roomsToCheckNext, startingPoint)
{ LIST_COUNT(roomsToCheckNow) == 0:
    //We're out of rooms in the current list to check, go to the next list
    ~ roomsToCheckNow = roomsToCheckNext
    ~ roomsToCheckNext = ()
}

//Pop the first room off the list
~ temp roomToCheck = LIST_MIN(roomsToCheckNow)
~ roomsToCheckNow -= roomToCheck

//Is this room adjacent to the starting point? If so, we have our path
{ AdjacentTo(roomToCheck) has startingPoint:
    ~ return roomToCheck
}

//Otherwise, populate rooms to check next with all adjacent rooms, and dig deeper
//(Could be made more efficient by excluding rooms we've already checked)
~ roomsToCheckNext += AdjacentTo(roomToCheck)
~ return PathFindRecursively(roomsToCheckNow,roomsToCheckNext,startingPoint)







