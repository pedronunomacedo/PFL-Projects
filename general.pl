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

display_rules :-
    cls,
    write('The game begins with an empty board.'), nl,

    write('Each player has an allocated color, usually Red and Blue.'), nl, 

    write('Players take turns making one of the following: '), nl, 

    write('Place a stone of their color AND a neutral stone on empty cells; '), nl, 
    write('OR'), nl, 
    write('Replace two neutral stones with stones of their color, AND replace a different stone of their color on the board to neutral stone.'), nl, 

    write('Since the first player has a distinct advantage, the pie rule is generally used to make the game fair.  This rule allows the second player to switch colors as his first move.'), nl, nl, nl, nl, 

    repeat,
        write('Press 0 to go back ...'), nl, nl, nl,
        read(Code2),
        (Code2 = 0), !,
    play.





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







