initialMenuDisplay :-
    cls,
    write('----------------------------------------'), nl,
    write('|  ----------------------------------  |'), nl,
    write('|  |    _   _   ______  __   __     |  |'), nl,
    write('|  |   | \\ | | |  ____| \\ \\ / /     |  |'), nl,
    write('|  |   |  \\| | | |__     \\ V /      |  |'), nl,
    write('|  |   | . ` | |  __|     > <       |  |'), nl,
    write('|  |   | |\\  | | |____   / . \\      |  |'), nl,
    write('|  |   |_| \\_| |______| /_/ \\_\\     |  |'), nl,  
    write('|  |                                |  |'), nl,     
    write('|  ----------------------------------  |'), nl,
    write('----------------------------------------'), nl, nl, nl, nl.




















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



concat_element(List, Element, NewList) :-
    append(List, [Element], NewList).


    
takeInput2(Column, Row, Board, BoardSize, SymbolToVerify, Moves, NewMoves) :-
    write('Next move:'), nl,
    write('Column: '),
    read(Letter),
    alphLetters(Letters),
    nth0(Column, Letters, Letter),
    write('Row: '),
    read(ReadRow),
    Row is ReadRow-1, 
    \+ member((Row, Column), Moves), 
    verifyInput2(Board, Row, Column, SymbolToVerify, Exists, BoardSize), 
    (Exists = 1),
    append(Moves, [(Row, Column)], NewMoves), 
    concat_element(Moves, (Row, Column), NewMoves).


takeInput2(Column, Row, Board, BoardSize, SymbolToVerify, Moves, NewMoves) :-
    write('Move not valid! '), nl,
    takeInput2(Column, Row, Board, BoardSize, SymbolToVerify, Moves, NewMoves). 







getPlayerSymbol(Player, PlayerSymbol) :-
    (Player = 1),
    PlayerSymbol = 'x'.   % '\x25d8\'

getPlayerSymbol(Player, PlayerSymbol) :-
    (Player = 2),
    PlayerSymbol = 'o'.





optionTwoBotPlay(Column, Row, Board, BoardSize, SymbolToVerify) :-
    repeat,
        random(0, BoardSize, NewColumn),
        Column is NewColumn,
        random(0, BoardSize, NewRow),
        Row is NewRow,
        verifyInput1(Board, Row, Column, SymbolToVerify, Exists, BoardSize),
        (Exists = 1), nl, !.
