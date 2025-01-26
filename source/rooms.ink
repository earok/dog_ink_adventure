LIST Rooms = Bedroom, Bathroom, Hallway, Staircase, LivingRoom, Kitchen, Lawn, Pantry

VAR LawnTapIsOn = false
VAR Pathfinding_Next_Room = 0

VAR Pathfinding_From = 0

VAR Pathfinding_CheckNow = ()
VAR Pathfinding_CheckNext = ()

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


=== Tunnel_Pathfind(from,to)
//If we're trying to pathfind to the player, instead pathfind to the room the player is in
{ to == Player:
    ~ to = PlayerRoom
}

{ from == to:
    ~ Pathfinding_Next_Room = to
    ->->
}

{ AdjacentTo(from) has to:
    ~ Pathfinding_Next_Room = to
    ->->
}

~ Pathfinding_From = from
~ Pathfinding_CheckNow = ()
~ Pathfinding_CheckNow += to
~ Pathfinding_CheckNext = ()

-> pathfinding_loop
=== pathfinding_loop
{ LIST_COUNT(Pathfinding_CheckNow) == 0:
        ~ Pathfinding_CheckNow = Pathfinding_CheckNext
}

~ temp ThisRoomToCheck = LIST_MIN(Pathfinding_CheckNow)
~ Pathfinding_CheckNow -= ThisRoomToCheck

{ AdjacentTo(ThisRoomToCheck) has Pathfinding_From:
    //This room we're checking is adjacent to our standing position
    ~ Pathfinding_Next_Room = ThisRoomToCheck
    ->->
}

~ Pathfinding_CheckNext += AdjacentTo(ThisRoomToCheck)
-> pathfinding_loop









