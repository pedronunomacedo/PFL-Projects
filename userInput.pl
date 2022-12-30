initialMenu(OptionMenu) :-
    repeat,
        write('-------------------------------'), nl,
        write('|   M E N U   I N I C I A L   |'), nl,
        write('-------------------------------'), nl,
        write('  1. Player vs Player'), nl,
        write('  2. Player vs PC'), nl,
        write('  3. PC vs Player'), nl,
        write('  4. PC vs PC'), nl, nl,
        write('Option: '),
        read(OptionMenu),
        (OptionMenu = 1; OptionMenu = 2; OptionMenu = 3; OptionMenu = 4), nl, !.








askForOption(Option) :-
    repeat,
        write('Choose an option (1 or 2): '), nl,
        print_n(4, ' '), 
        write('1. Place a stone of their color AND a neutral stone on empty cells'), nl, 
        print_n(4, ' '), 
        write('2. Replace two neutral stones with stones of their color, AND replace a different stone of their color on the board to neutral stone'), nl, 
        print_n(4, ' '), 
        write('Option: '), 
        read(Option),
        (Option = 1; Option = 2), nl, !.




verifyInput1(Board, Row, Column, SymbolToVerify, Exists, BoardSize) :-
    (Row >= 0), (Row < BoardSize), (Column >= 0), (Column < BoardSize), 
    nth0(Row, Board, X),
    nth0(Column, X, '-'), 
    Exists is 1, nl.

verifyInput1(Board, Row, Column, SymbolToVerify, Exists, BoardSize) :-
    Exists is 0, nl.



verifyInput2(Board, Row, Column, SymbolToVerify, Exists, BoardSize) :-
    (Row >= 0), (Row < BoardSize), (Column >= 0), (Column < BoardSize), 
    nth0(Row, Board, X),
    nth0(Column, X, SymbolToVerify), 
    Exists is 1, nl.

verifyInput2(Board, Row, Column, SymbolToVerify, 0, BoardSize) :-
    Exists is 0, nl.









askToSwitch(Answer) :-
    repeat,
        write('Do you want to switch symbols with the other player? (y/n)'),
        read(Answer),
        (Answer = 'y'; Answer = 'n'), nl, !.