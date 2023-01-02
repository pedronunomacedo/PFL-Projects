% If player chooses option 1 (Player vs Player)
% BoardSize : Size of the board
% Board : 2d list containing the current board
% N : Current play
% OptionMenu : menu option chossen by the player
% OptionDifficulty : Option difficulty choosen by the player (1 - Easy or 2 - Difficult)
% game_cycle3(+BoardSize, +Board, +N, +OptionMenu, +OptionDifficulty)
game_cycle1(BoardSize, Board, N, OptionMenu) :- % (Option = 1) : 1st playing method (Place a stone of their color AND a neutral stone on empty cells) and 2nd play
    (OptionMenu == 1),
    (N == 2),
    player(Player),
    getPlayerSymbol(Player, PlayerSymbol),

    write('Player '), write(PlayerSymbol), write(' : '), nl, nl,
    askToSwitch(Answer),
    (Answer = 'n'),
    
    askForOption(Option, Board, PlayerSymbol), 
    (Option = 1),

    Moves = [], 
    choose_move(Column, Row, Board, BoardSize, '-', Moves, NewMoves1), nl,  nl, % stone of their color

    retract(board(Board)),
    move(BoardSize, BoardSize, Column, Row, Board, BoardNew, PlayerSymbol), % Put the stone with our colour
    assert(board(BoardNew)),

    count_2d('-', BoardNew, Count),
    (Count == 0 ->
        display_game(BoardSize, BoardNew), nl, nl, nl, nl,
        draw, !
        ;
        nl    
    ),
    
    game_over(BoardNew, PlayerSymbol, BoardSize, GameOver), 
    (GameOver == 1 ->
        display_game(BoardSize, BoardNew),
        nl
        ;
        choose_move(ColumnNeutral, RowNeutral, BoardNew, BoardSize, '-', NewMoves1, NewMoves2), nl, nl, % neutral stone
        move(BoardSize, BoardSize, ColumnNeutral, RowNeutral, BoardNew, FinalBoard, 'n'), % Put the neutral stone
        assert(board(FinalBoard)),

        count_2d('-', FinalBoard, Count1),
        (Count1 == 0 ->
            display_game(BoardSize, FinalBoard), nl, nl, nl, nl,
            draw, !
            ;
            nl    
        ),

        

        cls,
        initialMenuDisplay,

        retract(player(Player)),
        NewPlayer is (mod(Player, 2) + 1),
        assert(player(NewPlayer)),

        display_game(BoardSize, FinalBoard), nl,

        Next is N+1,
        game_cycle1(BoardSize, FinalBoard, Next, OptionMenu)
    ).

game_cycle1(BoardSize, Board, N, OptionMenu) :-  % (N == 2) : 2nd play
    (OptionMenu == 1),
    player(Player),
    getPlayerSymbol(Player, PlayerSymbol),

    (N == 2),

    (Answer = 'y'),

    nl, nl, nl,
    write('Switched Players !'), nl,
    write('You are now Player X'), nl, nl,

    Next is N+1,
    game_cycle1(BoardSize, Board, Next, OptionMenu).

game_cycle1(BoardSize, Board, N, OptionMenu) :-  % (Option = 1) : 1st playing method (Place a stone of their color AND a neutral stone on empty cells)
    (OptionMenu == 1),
    player(Player),
    getPlayerSymbol(Player, PlayerSymbol),
    write('Player '), write(PlayerSymbol), write(' : '), nl, nl,

    askForOption(Option, Board, PlayerSymbol), 
    (Option = 1), 

    Moves = [], 
    choose_move(Column, Row, Board, BoardSize, '-', Moves, NewMoves1), nl,  nl, % stone of their color

    retract(board(Board)),
    move(BoardSize, BoardSize, Column, Row, Board, BoardNew, PlayerSymbol), % Put the stone with our colour
    assert(board(BoardNew)),

    count_2d('-', BoardNew, Count),
    (Count == 0 ->
        display_game(BoardSize, BoardNew), nl, nl, nl, nl,
        draw, !
        ;
        nl    
    ),

    
    game_over(BoardNew, PlayerSymbol, BoardSize, GameOver), 
    (GameOver == 1 ->
        display_game(BoardSize, BoardNew),
        nl
        ;
        choose_move(ColumnNeutral, RowNeutral, BoardNew, BoardSize, '-', NewMoves1, NewMoves2), nl, nl, % neutral stone
        move(BoardSize, BoardSize, ColumnNeutral, RowNeutral, BoardNew, FinalBoard, 'n'), % Put the neutral stone
        assert(board(FinalBoard)),

        count_2d('-', FinalBoard, Count1),
        (Count1 == 0 ->
            display_game(BoardSize, FinalBoard), nl, nl, nl, nl,
            draw, !
            ;
            nl    
        ),
        cls,
        initialMenuDisplay,


        retract(player(Player)),
        NewPlayer is (mod(Player, 2) + 1),
        assert(player(NewPlayer)), 

        display_game(BoardSize, FinalBoard), nl, 
        
        Next is N+1,

        game_cycle1(BoardSize, FinalBoard, Next, OptionMenu)
    ).

game_cycle1(BoardSize, Board, N, OptionMenu) :- % (Option = 2) : 1st playing method (Place a stone of their color AND a neutral stone on empty cells)
    (OptionMenu == 1),
    player(Player),
    getPlayerSymbol(Player, PlayerSymbol),
    (Option = 2), 

    Moves = [],
    choose_move(Column, Row, Board, BoardSize, 'n', Moves, NewMoves1),

    retract(board(Board)),
    move(BoardSize, BoardSize, Column, Row, Board, BoardNew, PlayerSymbol), % 1st neutral stone -> 1st player stone
    assert(board(BoardNew)), nl, 
    
    display_game(BoardSize, BoardNew), nl, % intermediate board

    

    choose_move(Column2, Row2, BoardNew, BoardSize, 'n', NewMoves1, NewMoves2),

    retract(board(BoardNew)),
    move(BoardSize, BoardSize, Column2, Row2, BoardNew, IntBoardNew, PlayerSymbol), % 2nd neutral stone -> 2nd player stone
    assert(board(IntBoardNew)),

    display_game(BoardSize, IntBoardNew), nl, % intermediate board

    
    choose_move(Column3, Row3, IntBoardNew, BoardSize, PlayerSymbol, NewMoves2, NewMoves3),
    retract(board(IntBoardNew)),
    move(BoardSize, BoardSize, Column3, Row3, IntBoardNew, FinalBoard, 'n'), % player stone -> neutral stone
    assert(board(FinalBoard)),
    cls, 
    initialMenuDisplay,

    display_game(BoardSize, FinalBoard), nl, % final board    

    game_over(FinalBoard, PlayerSymbol, BoardSize, GameOver),

    (GameOver == 1 ->
        nl
        ;
        Next is N+1,
        retract(player(Player)),
        NewPlayer is (mod(Player, 2) + 1),
        assert(player(NewPlayer)),
        game_cycle1(BoardSize, FinalBoard, Next, OptionMenu)
    ). 

game_cycle1(BoardSize, Board, N, OptionMenu) :- 
    false.
