

% If player chooses option 4 (PC vs PC)
% BoardSize : Size of the board
% Board : 2d list containing the current board
% N : Current play
% OptionMenu : menu option chossen by the player
% OptionDifficulty : Option difficulty choosen by the player (1 - Easy or 2 - Difficult)
% game_cycle4(+BoardSize, +Board, +N, +OptionMenu, +OptionDifficulty)
game_cycle4(BoardSize, Board, N, OptionMenu, OptionDifficulty) :-
    (OptionDifficulty == 1),
    (OptionMenu == 4),
    player(Player),
    getPlayerSymbol(Player, PlayerSymbol),
    


    optionBotPlay(Column, Row, Board, BoardSize), nl, nl,    
    
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
 
        optionBotPlay(ColumnNeutral, RowNeutral, BoardNew, BoardSize), nl, nl,
        
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