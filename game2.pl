:- consult(general).
:- consult(board).
:- consult(userInput).
:- consult(helper).
:- consult(find_path).
:- use_module(library(lists)).

:- dynamic board/1, player/1, visited/1.

% alphLetters(['A','B','C','D','E','F','G','H',
%             'I','J','K','L','M','N','O','P',
%             'Q','R','S','T','U','V','W','X',
%             'Y','Z']).

alphLetters(['a','b','c','d','e','f','g','h',
            'i','j','k','l','m','n','o','p',
            'q','r','s','t','u','v','w','x',
            'y','z']).


play :-
    abolish(player/1),
    initial_state(BoardSize, Board),
    display_game(BoardSize, Board),
    game_cycle(BoardSize, Board, 1), 
    congrats.


initial_state(BoardSize, Board) :-
    cls,
    boardSize(BoardSize),
    cls,
    createInitialBoard(BoardSize, BoardSize, Board),
    assert(board(Board)),
    assert(player(1)).


display_game(BoardSize, Board) :-
    printAllBoard(BoardSize, Board), nl.


% game_cycle(GameState) :-
%     game_over(GameState, Winner), !,
%     congralute(Winner).











% If player chooses option 1 (Place a stone of their color 
%                         AND a neutral stone on empty cells)
game_cycle(BoardSize, Board, N) :-
    (N == 2),
    player(Player),
    getPlayerSymbol(Player, PlayerSymbol),

    write('Player '), write(PlayerSymbol), write(' : '), nl, nl,
    askToSwitch(Answer),
    (Answer = 'n'),

    askForOption(Option), 
    (Option = 1), 

    takeInput1(Column, Row, Board, BoardSize, PlayerSymbol), nl,  nl, % stone of their color

    retract(board(Board)),
    createBoardNew(BoardSize, BoardSize, Column, Row, Board, BoardNew, PlayerSymbol), % Put the stone with our colour
    assert(board(BoardNew)),
    
    game_over(BoardNew, PlayerSymbol, BoardSize, GameOver), 
    (GameOver == 1 ->
        nl
        ;
        takeInput1(ColumnNeutral, RowNeutral, BoardNew, BoardSize, 'n'), nl, nl, % neutral stone
        createBoardNew(BoardSize, BoardSize, ColumnNeutral, RowNeutral, BoardNew, FinalBoard, 'n'), % Put the neutral stone
        assert(board(FinalBoard)),
        cls,

        retract(player(Player)),
        NewPlayer is (mod(Player, 2) + 1),
        assert(player(NewPlayer)),

        printAllBoard(BoardSize, FinalBoard), nl,

        Next is N+1,
        game_cycle(BoardSize, FinalBoard, Next)
    ).


game_cycle(BoardSize, Board, N) :-
    player(Player),
    getPlayerSymbol(Player, PlayerSymbol),

    (N == 2),

    (Answer = 'y'),

    nl, nl, nl,
    write('Switched Players !'), nl,
    write('You are now Player X'), nl, nl,

    Next is N+1,
    game_cycle(BoardSize, Board, Next).









% If player chooses option 1 (Place a stone of their color 
%                         AND a neutral stone on empty cells)
game_cycle(BoardSize, Board, N) :-
    player(Player),
    getPlayerSymbol(Player, PlayerSymbol),
    write('Player '), write(PlayerSymbol), write(' : '), nl, nl,

    askForOption(Option), 
    (Option = 1), 
    
    
    takeInput1(Column, Row, Board, BoardSize, PlayerSymbol), nl,  nl, % stone of their color

    retract(board(Board)),
    createBoardNew(BoardSize, BoardSize, Column, Row, Board, BoardNew, PlayerSymbol), % Put the stone with our colour
    assert(board(BoardNew)),

    
    game_over(BoardNew, PlayerSymbol, BoardSize, GameOver), 
    (GameOver == 1 ->
        nl
        ;
        takeInput1(ColumnNeutral, RowNeutral, BoardNew, BoardSize, 'n'), nl, nl, % neutral stone
        createBoardNew(BoardSize, BoardSize, ColumnNeutral, RowNeutral, BoardNew, FinalBoard, 'n'), % Put the neutral stone
        assert(board(FinalBoard)),
        cls,


        retract(player(Player)),
        NewPlayer is (mod(Player, 2) + 1),
        assert(player(NewPlayer)), 

        printAllBoard(BoardSize, FinalBoard), nl, 
        
        Next is N+1,

        game_cycle(BoardSize, FinalBoard, Next)
    ).


% If player choose option 2 (Replace two neutral stones with stones of their color, 
%                         AND replace a different stone of their color on the board to neutral stone)
game_cycle(BoardSize, Board, N) :- 
    player(Player),
    getPlayerSymbol(Player, PlayerSymbol),
    (Option = 2), 

    takeInput2(Column, Row, Board, BoardSize, 'n'),
    retract(board(Board)),
    createBoardNew(BoardSize, BoardSize, Column, Row, Board, BoardNew, PlayerSymbol), % 1st neutral stone -> 1st player stone
    assert(board(BoardNew)), nl, 
    printAllBoard(BoardSize, BoardNew), nl, % intermediate board

    

        takeInput2(Column2, Row2, BoardNew, BoardSize, 'n'),
        retract(board(BoardNew)),
        createBoardNew(BoardSize, BoardSize, Column2, Row2, BoardNew, IntBoardNew, PlayerSymbol), % 2nd neutral stone -> 2nd player stone
        assert(board(IntBoardNew)),
        printAllBoard(BoardSize, IntBoardNew), nl, % intermediate board

        
        takeInput2(Column3, Row3, IntBoardNew, BoardSize, PlayerSymbol),
        retract(board(IntBoardNew)),
        createBoardNew(BoardSize, BoardSize, Column3, Row3, IntBoardNew, FinalBoard, 'n'), % player stone -> neutral stone
        assert(board(FinalBoard)),
        cls, 
        printAllBoard(BoardSize, FinalBoard), nl, % final board    

        game_over(FinalBoard, PlayerSymbol, BoardSize, GameOver),

        (GameOver == 1 ->
            nl
            ;
            Next is N+1,
            retract(player(Player)),
            NewPlayer is (mod(Player, 2) + 1),
            assert(player(NewPlayer)),
            game_cycle(BoardSize, FinalBoard, Next)
        ).
        
        

game_cycle(BoardSize, Board, N) :- false.


congrats :- 
    player(Player),
    getPlayerSymbol(Player, PlayerSymbol),
    write('Player '), write(PlayerSymbol), write(' won!'), halt.



























% In the begginig, all elements weren't visited, so ElemVisited = 0
createVisitedList([], []).
createVisitedList([Line | BoardRest], [LineVisited | VisitedRest]) :-
    createVisitedList_Row(Line, LineVisited), 
    createVisitedList(BoardRest, VisitedRest).


createVisitedList_Row([], []).
createVisitedList_Row([Elem | LineRest], [0 | LineVisitedRest]) :-
    createVisitedList_Row(LineRest, LineVisitedRest).

printVisitedList_Row([]).
printVisitedList_Row([Elem | LineRest]) :-
    write(Elem), write(' '), 
    printVisitedList_Row(LineRest).

printVisitedList([]).
printVisitedList([LineVisited | VisitedRest]) :-
    printVisitedList_Row(LineVisited), nl, 
    printVisitedList(VisitedRest).
