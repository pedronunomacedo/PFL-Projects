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





concat_element(List, Element, NewList) :-
    append(List, [Element], NewList).
    



getPlayerSymbol(Player, PlayerSymbol) :-
    (Player = 1),
    PlayerSymbol = 'x'.   % '\x25d8\'

getPlayerSymbol(Player, PlayerSymbol) :-
    (Player = 2),
    PlayerSymbol = 'o'.


% count(+Element, +List, -Count)
% Counts the number of times Element appears in List.
count(_, [], 0).
count(X, [X|Tail], N) :- count(X, Tail, N1), N is N1 + 1.
count(X, [Y|Tail], N) :- X \= Y, count(X, Tail, N).

% count_2d(+Element, +List2D, -Count)
% Counts the number of times Element appears in List2D, which is a list of lists.
count_2d(_, [], 0).
count_2d(X, [L|Ls], N) :- count(X, L, N1), count_2d(X, Ls, N2), N is N1 + N2.






optionTwoBotPlay(Column, Row, Board, BoardSize, SymbolToVerify) :-
    repeat,
        random(0, BoardSize, NewColumn),
        Column is NewColumn,
        random(0, BoardSize, NewRow),
        Row is NewRow,
        valid_move(Board, Row, Column, '-', Exists, BoardSize),
        (Exists = 1), nl, !.







