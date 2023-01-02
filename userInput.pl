% Display the initial menu and ask for a game mode option
% OptionMenu : Variable to store the menu option choosen by the user
% initialMenu(-OptionMenu)
initialMenu(OptionMenu) :-
    repeat,
        write('-------------------------------'), nl,
        write('|   M E N U   I N I C I A L   |'), nl,
        write('-------------------------------'), nl,
        write('  1. Player vs Player'), nl,
        write('  2. Player vs PC'    ), nl,
        write('  3. PC vs Player'    ), nl,
        write('  4. PC vs PC'        ), nl,
        write('  5. Rules           '), nl, nl,
        write('Option: '),
        read(OptionMenu),
        (OptionMenu = 1; OptionMenu = 2; OptionMenu = 3; OptionMenu = 4; OptionMenu = 5), nl, !.



% Display the difficulty menu and ask the user for an option
% OptionDifficulty : Variable to store the difficulty option choosen by the user
% difficultyMenu(-OptionDifficulty)
difficultyMenu(OptionDifficulty) :-
    repeat,
        write('-------------------------------'), nl,
        write('|     D I F F I C U L T Y     |'), nl,
        write('-------------------------------'), nl,
        write('  1. Easy'), nl,
        write('  2. Difficult [Not working]'), nl, nl,
        write('Option: '),
        read(OptionDifficulty),
        (OptionDifficulty = 1), nl, !.




% Display the possible playing modes and ask the user to choose one of them
% Option : Variable to store the option choosen by the user
% Board : Current board state
% Playersymbol : Symbol of the current player
% askForOption(-Option, +Board, +PlayerSymbol)
askForOption(Option, Board, PlayerSymbol) :-
    count_2d(PlayerSymbol, Board, CountPlayer), 
    count_2d('n', Board, CountNeutrals),
    
    ((CountPlayer >= 1 , CountNeutrals >= 2) ->
        repeat,
            write('Choose an option (1 or 2): '), nl,
            print_n(4, ' '), 
            write('1. Place a stone of their color AND a neutral stone on empty cells'), nl, 
            print_n(4, ' '), 
            write('2. Replace two neutral stones with stones of their color, AND replace a different stone of their color on the board to neutral stone'), nl, 
            print_n(4, ' '), 
            write('Option: '), 
            read(Option),
            (Option = 1; Option = 2), nl, !
        ;
        repeat,
            write('Choose an option (1 or 2): '), nl,
            print_n(4, ' '), 
            write('1. Place a stone of their color AND a neutral stone on empty cells'), nl, 
            print_n(4, ' '), 
            write('Option: '), 
            read(Option),
            (Option = 1), nl, !
    ).


% Check if a move is valid
% Board : Current board state
% Row : Row coordinates
% Column : Column coordinates
% SymbolToVerify : Symbol to verify if exists in the cell (Row, Column)
% Exists : Variable to store if the SymbolToVerify is in the cell (Row, Column) (1 if exists, 0 otherwise)
valid_move(Board, Row, Column, SymbolToVerify, Exists, BoardSize) :-
    (Row >= 0), (Row < BoardSize), (Column >= 0), (Column < BoardSize),
    nth0(Row, Board, X),
    nth0(Column, X, Elem), 
    nth0(Column, X, SymbolToVerify), 
    Exists is 1, !.

valid_move(Board, Row, Column, SymbolToVerify, Exists, BoardSize) :-
    Exists is 0, nl.


% Ask the 2nd player if he wants to switch player
% Answer : Answer of the player
% askToSwitch(-Answer)
askToSwitch(Answer) :-
    repeat,
        write('Do you want to switch symbols with the other player? (y/n)'),
        read(Answer),
        (Answer = 'y'; Answer = 'n'), nl, !.


ask_symbol :-
    repeat,
        write('Choose your symbol (X or O): '),
        read(Symbol),
        (Symbol = [88]; Symbol = [79]; Symbol = [120]; Symbol = [111]), nl, !.





% ask the player for a move and validate the move
% Column : Column coordinate
% Row : Row coordinate
% Board : Current board state
% BoardSize : Size of the Board
% SymbolToVerify : Symbol to verify if exists in the cell (Row, Column)
% Moves : Moves previously done by the player in that iteration
% NewMoves : Moves after a valid move
% choose_move(+Column, +Row, +Board, +BoardSize, +SymbolToVerify, +Moves, -NewMoves)
choose_move(Column, Row, Board, BoardSize, SymbolToVerify, Moves, NewMoves) :-
    write('Next move:'), nl,
    write('Column: '),
    read(Letter),
    alphLetters(Letters),
    nth0(Column, Letters, Letter),
    write('Row: '),
    read(ReadRow),
    Row is ReadRow-1, 
    \+ member((Row, Column), Moves), 
    valid_move(Board, Row, Column, SymbolToVerify, Exists, BoardSize), 
    (Exists = 1),
    append(Moves, [(Row, Column)], NewMoves), 
    concat_element(Moves, (Row, Column), NewMoves).

choose_move(Column, Row, Board, BoardSize, SymbolToVerify, Moves, NewMoves) :-
    write('Move not valid! '), nl,
    choose_move(Column, Row, Board, BoardSize, SymbolToVerify, Moves, NewMoves). 