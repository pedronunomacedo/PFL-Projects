

% If player chooses option 1 (Place a stone of their color 
%                         AND a neutral stone on empty cells)
game_cycle4(BoardSize, Board, N, OptionMenu, OptionDifficulty) :-
    (OptionDifficulty == 1),
    (OptionMenu == 4),
    player(Player),
    getPlayerSymbol(Player, PlayerSymbol),
    


    optionTwoBotPlay(Column, Row, Board, BoardSize, PlayerSymbol), nl, nl,    
    
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
 
        optionTwoBotPlay(ColumnNeutral, RowNeutral, BoardNew, BoardSize, 'n'), nl, nl,
        
        move(BoardSize, BoardSize, ColumnNeutral, RowNeutral, BoardNew, FinalBoard, 'n'), % Put the neutral stone
        assert(board(FinalBoard)),

        count_2d('-', FinalBoard, Count1),
        (Count1 == 0 ->
            display_game(BoardSize, FinalBoard), nl, nl, nl, nl,
            draw, !
            ;
            nl    
        ),

        
        % press_enter_to_continue
        % Pauses execution and waits for the user to press the Enter key.
        repeat,
            write('Press Enter to continue...'), nl, nl, nl,
            get_code(Code),
            (Code = 10), !,

        
        % write('Press 1 to continue: '),
        % read(Ola),
        % (Ola = 1), nl, nl, nl,

        cls,
        initialMenuDisplay,


        retract(player(Player)),
        NewPlayer is (mod(Player, 2) + 1),
        assert(player(NewPlayer)), 

        display_game(BoardSize, FinalBoard), nl, 
        
        Next is N+1,

        game_cycle4(BoardSize, FinalBoard, Next, OptionMenu, OptionDifficulty)
    ).




game_cycle4(BoardSize, Board, N, OptionMenu, OptionDifficulty) :- 
    false.