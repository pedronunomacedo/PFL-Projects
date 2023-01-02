% Verifies if in the cell (X,Y) exists the PlayerSymbol
% X : row coordinate
% Y : column coordinate
% PlayerSymbol : Symbol of the current player
verifyElemPlayerSymbol(X, Y, Board, PlayerSymbol) :-
    getElementOnBoard(0, X, Y, Board, Elem), 
    (Elem == PlayerSymbol).

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






% Define the predicate to search for a path from the current position to the destination position, using a DFS.
% Board : Current board state
% X : row of the origin cell
% Y : column of the origin cell
% TargetX : row of the destination cell
% TargetY : column of the destination cell
% Visited : list of visited cells (used in order to not visit the cell again)
% BoardSize : Size of the board
% PlayerSymbol : Symbol of the current player
% find_path(+Board, +X, +Y, +TargetX, +TargetY, +Visited, +BoardSize, +PlayerSymbol)
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
                    find_path(Board, X5, Y5, TargetX, TargetY, NewVisited, BoardSize, PlayerSymbol) ;
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






% Check if player X won the game.
% ElemX : Row of the player
% ElemY : Column of the player
% [Line | BoardRest] : 2d list to be traverse in order to end the predicate
% Board : 2d list with the current board
% BoardSize : Size of the board
% check_elem_winX(+ElemX, +TargetX, +[Line | BoardRest], +Board, +BoardSize)
check_elem_winX(ElemX, TargetX, [_ | BoardRest], Board, BoardSize) :-
    TargetY is BoardSize-1, 
    (TargetX < BoardSize), 

    (find_path(Board, ElemX, 0, TargetX, TargetY, [], BoardSize, 'x') ->
        nl
        ;
        NextTargetX is TargetX+1, 
        check_elem_winX(ElemX, NextTargetX, BoardRest, Board, BoardSize)
    ).

check_elem_winX(_, _, _, _, _) :- false.

% Check if player O won the game.
% ElemX : Row of the player
% ElemY : Column of the player
% [Line | BoardRest] : 2d list to be traverse in order to end the predicate
% Board : 2d list with the current board
% BoardSize : Size of the board
% check_elem_winX(+ElemX, +TargetX, +[Line | BoardRest], +Board, +BoardSize)
check_elem_winO(ElemY, TargetY, [_ | BoardRest], Board, BoardSize) :-
    TargetX is BoardSize-1, 
    (TargetY < BoardSize), 
    
    (find_path(Board, 0, ElemY, TargetX, TargetY, [], BoardSize, 'o') ->
        nl
        ;
        NextTargetY is TargetY+1, 
        check_elem_winO(ElemY, NextTargetY, BoardRest, Board, BoardSize)
    ).

check_elem_winO(_, _, _, _, _) :- false.





% Check if the player 'x' has won.
% CurrentX : Number to be incremeted in order to end the predicate (initially, it's equal to 0)
% [Line | BoardRest] : 2d list to be traverse in order to end the predicate
% Board : 2d list with the current board
% BoardSize : Size of the board
% Gameover : Variable to store 1 if the player won, otherwise 0
% game_overX(+CurrentX, +[Line | BoardRest], +Board, +BoardSize, -GameOver)
game_overX(CurrentX, [_ | BoardRest], Board, BoardSize, GameOver) :-
    (CurrentX < BoardSize), 
    ((verifyElemPlayerSymbol(CurrentX, 0, Board, 'x'), check_elem_winX(CurrentX, 0, Board, Board, BoardSize)) ->
        GameOver is 1
        ;
        NextCurrentX is CurrentX+1, 
        game_overX(NextCurrentX, BoardRest, Board, BoardSize, GameOver)
    ).
game_overX(_, _, _, _, 0).


% Check if the player 'o' has won.
% CurrentX : Number to be incremeted in order to end the predicate (initially, it's equal to 0)
% [Line | BoardRest] : 2d list to be traverse in order to end the predicate
% Board : 2d list with the current board
% BoardSize : Size of the board
% Gameover : Variable to store 1 if the player won, or 0 otherwise
% game_overO(+CurrentX, +[Line | BoardRest], +Board, +BoardSize, -GameOver)
game_overO(CurrentY, [_ | LineRest], Board, BoardSize, GameOver) :-
    (CurrentY < BoardSize), 
    ((verifyElemPlayerSymbol(0, CurrentY, Board, 'o'), check_elem_winO(CurrentY, 0, Board, Board, BoardSize)) ->
        GameOver is 1
        ;
        NextCurrentY is CurrentY+1, 
        game_overO(NextCurrentY, LineRest, Board, BoardSize, GameOver)
    ).

game_overO(_, _, _, _, 0).


% Implement the game_over predicate to call the game_overX and game_overO predicates depending on the current player
% [Line | BoardRest] : 2d list with the current board
% PlayerSymbol : Symbol of the current player
% BoardSize : Size of the board
% Gameover : Variable to store 1 if the player won, or 0 otherwise
game_over([Line | BoardRest], PlayerSymbol, BoardSize, GameOver) :-
    (PlayerSymbol == 'x' ->
        game_overX(0, [Line | BoardRest], [Line | BoardRest], BoardSize, GameOver)
        ;
        game_overO(0, Line, [Line | BoardRest], BoardSize, GameOver)
    ).