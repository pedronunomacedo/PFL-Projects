:- use_module(library(lists)).

getElementOnBoard_Row(CurrentY, Y, [LineElem | LineRest], Elem) :-
    ((CurrentY == Y) -> 
        Elem = LineElem
        ;
        NextCurrentY is CurrentY+1,
        getElementOnBoard_Row(NextCurrentY, Y, LineRest, Elem)
    ).

getElementOnBoard(CurrentX, X, Y, [Line | BoardRest], Elem) :-
    ((CurrentX == X) ->
        getElementOnBoard_Row(0, Y, Line, Elem)
        ;
        NextCurrentX is CurrentX+1, 
        getElementOnBoard(NextCurrentX, X, Y, BoardRest, Elem)
    ).

verifyElemPlayerSymbol(X, Y, Board, PlayerSymbol) :-
    getElementOnBoard(0, X, Y, Board, Elem), 
    (Elem == PlayerSymbol).




% Define the predicate to search for a path from the current position to the destination position
find_path(Board, X, Y, TargetX, TargetY, Visited, BoardSize, PlayerSymbol) :-
    X1 is X, Y1 is Y-1, 
    X2 is X, Y2 is Y+1, 
    X3 is X-1, Y3 is Y, 
    X4 is X+1, Y4 is Y,
    X5 is X+1, Y5 is Y-1,
    X6 is X-1, Y6 is Y+1,

    % Check if the destination position has been reached
    ((X =:= TargetX, Y =:= TargetY) -> 
        (verifyElemPlayerSymbol(X, Y, Board, PlayerSymbol) ->
            true
            ;
            false
        )
        ;
        % Check if the current position is within the bounds of the board
        ((X >= 0, X < BoardSize, Y >= 0, Y < BoardSize) ->
            % Check if the current position has not been visited before
            ((\+ member((X,Y), Visited) , verifyElemPlayerSymbol(X, Y, Board, PlayerSymbol)) -> 
                % Add the current position to the list of visited positions
                NewVisited = [(X,Y)|Visited],
                (
                    % Search for a path in the up direction
                    find_path(Board, X1, Y1, TargetX, TargetY, NewVisited, BoardSize, PlayerSymbol) ;
                    % Search for a path in the down direction
                    find_path(Board, X2, Y2, TargetX, TargetY, NewVisited, BoardSize, PlayerSymbol) ;
                    % Search for a path in the left direction
                    find_path(Board, X3, Y3, TargetX, TargetY, NewVisited, BoardSize, PlayerSymbol) ;
                    % Search for a path in the right direction
                    find_path(Board, X4, Y4, TargetX, TargetY, NewVisited, BoardSize, PlayerSymbol) ;
                    % Search for a path in the left-down direction
                    find_path(Board, X5, X5, TargetX, TargetY, NewVisited, BoardSize, PlayerSymbol) ;
                    % Search for a path in the right-up direction
                    find_path(Board, X6, Y6, TargetX, TargetY, NewVisited, BoardSize, PlayerSymbol)
                )
            )
            ;
            false 
        )
        ;
        false
    ).







check_elem_winX(ElemX, TargetX, [Line | BoardRest], Board, BoardSize) :-
    TargetY is BoardSize-1, 
    (TargetX < BoardSize), 

    (find_path(Board, ElemX, 0, TargetX, TargetY, [], BoardSize, 'x') ->
        nl
        ;
        NextTargetX is TargetX+1, 
        check_elem_winX(ElemX, NextTargetX, BoardRest, Board, BoardSize)
    ).
check_elem_winX(_, _, _, _, _) :- false.

check_elem_winO(ElemY, TargetY, [Line | BoardRest], Board, BoardSize) :-
    TargetX is BoardSize-1, 
    (TargetY < BoardSize), 
    
    (find_path(Board, 0, ElemY, TargetX, TargetY, [], BoardSize, 'o') ->
        nl
        ;
        NextTargetY is TargetY+1, 
        check_elem_winO(ElemY, NextTargetY, BoardRest, Board, BoardSize)
    ).
check_elem_winO(_, _, _, _, _) :- false.





% Check if the player 'x' has won!
game_overX(CurrentX, [Line | BoardRest], Board, BoardSize, GameOver) :-
    (CurrentX < BoardSize), 
    ((verifyElemPlayerSymbol(CurrentX, 0, Board, 'x'), check_elem_winX(CurrentX, 0, Board, Board, BoardSize)) ->
        GameOver is 1
        ;
        NextCurrentX is CurrentX+1, 
        game_overX(NextCurrentX, BoardRest, Board, BoardSize, GameOver)
    ).
game_overX(_, _, _, _, Gameover) :- 
    GameOver is 0.


% Check if the player 'o' has won!
game_overO(CurrentY, [Elem | LineRest], Board, BoardSize, GameOver) :-
    (CurrentY < BoardSize), 
    ((verifyElemPlayerSymbol(0, CurrentY, Board, 'o'), check_elem_winO(CurrentY, 0, Board, Board, BoardSize)) ->
        GameOver is 1
        ;
        NextCurrentY is CurrentY+1, 
        game_overO(NextCurrentY, LineRest, Board, BoardSize, GameOver)
    ).

game_overO(_, _, _, _, Gameover) :- 
    GameOver is 0.


% Implement the game_over predicate
game_over([Line | BoardRest], PlayerSymbol, BoardSize, GameOver) :-
    (PlayerSymbol == 'x' ->
        game_overX(0, [Line | BoardRest], [Line | BoardRest], BoardSize, GameOver)
        ;
        game_overO(0, Line, [Line | BoardRest], BoardSize, GameOver)
    ).