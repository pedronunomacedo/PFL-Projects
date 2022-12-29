cls:-
    write('\33\[2J').

print_n(0, _C):- !.
print_n(N, C):-
    write(C),
    N1 is N-1,
    print_n(N1, C).

ask_symbol :-
    repeat,
        write('Choose your symbol (X or O): '),
        read(Symbol),
        (Symbol = [88]; Symbol = [79]; Symbol = [120]; Symbol = [111]), nl, !.







takeInput1(Column, Row, Board, BoardSize, SymbolToVerify) :-
    write('Next move:'), nl,
    write('Column: '),
    read(Letter),
    alphLetters(Letters),
    nth0(Column, Letters, Letter),
    nl, write('Row: '),
    read(ReadRow),
    Row is ReadRow-1, 
    verifyInput1(Board, Row, Column, SymbolToVerify, Exists, BoardSize), 
    (Exists = 1), nl.

takeInput1(Column, Row, Board, BoardSize, SymbolToVerify) :-
    write('Move not valid! '), nl,
    takeInput1(Column, Row, Board, BoardSize, SymbolToVerify). 


    
takeInput2(Column, Row, Board, BoardSize, SymbolToVerify) :-
    write('Next move:'), nl,
    write('Column: '),
    read(Letter),
    alphLetters(Letters),
    nth0(Column, Letters, Letter),
    write('Row: '),
    read(ReadRow),
    Row is ReadRow-1, 
    verifyInput2(Board, Row, Column, SymbolToVerify, Exists, BoardSize), nl.

takeInput2(Column, Row, Board, BoardSize, SymbolToVerify) :-
    write('Move not valid! '), nl,
    takeInput2(Column, Row, Board, BoardSize, SymbolToVerify). 







getPlayerSymbol(Player, PlayerSymbol) :-
    (Player = 1),
    PlayerSymbol = 'x'.   % '\x25d8\'

getPlayerSymbol(Player, PlayerSymbol) :-
    (Player = 2),
    PlayerSymbol = 'o'.