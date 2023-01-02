% display the game logo
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

% Display the rules of the game
display_rules :-
    cls,

    write('-------------------------------'), nl,
    write('|           R U L E S         |'), nl,
    write('-------------------------------'), nl, nl, nl, nl,



    write('------------------------------------------------------------------------------------------------------'), nl,
    write('|'), nl,
    write('|   OBJECTIVE'), nl,
    write('|'), nl,
    write('|   The objective of Nex is to create a connected chain of a players stones linking the opposite edges of the board marked by the players color.'), nl,
    write('|'), nl,
    write('|'), nl,
    write('|'), nl,
    write('|   PLAY'), nl,
    write('|'), nl,
    write('|   The game begins with an empty board.'), nl,
    write('|   Each player has an allocated piece symbol, X and O.'), nl,
    write('|'), nl,
    write('|   Players take turns making one of the following: '), nl, 
    write('|      Place a stone of their color AND a neutral stone on empty cells; '), nl, 
    write('|      OR'), nl, 
    write('|      Replace two neutral stones with stones of their color, AND replace a different stone of their color on the board to neutral stone.'), nl,
    write('|'), nl,
    write('|   Since the first player has a distinct advantage, the pie rule is generally used to make the game fair.  This rule allows the second player to switch colors as his first move.'), nl, 
    write('|'), nl,
    write('------------------------------------------------------------------------------------------------------'), nl, nl, nl, nl,

    repeat,
        write('Press 0 to go back ...'), nl, nl, nl,
        read(Code2),
        (Code2 = 0), !,
    play.




% Predicate to clear the terminal screen
cls:-
    write('\33\[2J').

% Predicate to print a specific number of times a character
% N : Number of times to print character C
% C : Character to be printed
% print_n(+N, +C)
print_n(0, _C) :- !.
print_n(N, C) :-
    write(C),
    N1 is N-1,
    print_n(N1, C).




% Concatenate an element to a list
% List : Original list where to placed the new element
% Element : The new element
% Newlist : New list after the concatenation
concat_element(List, Element, NewList) :-
    append(List, [Element], NewList).
    


% Get the player symbol depending of the current player (0 - 'x' and 1 - 'o')
% Player : Player number
% PlayerSymbol : Variable to store the symbol of the current player
getPlayerSymbol(Player, PlayerSymbol) :-
    (Player = 1),
    PlayerSymbol = 'x'.

getPlayerSymbol(Player, PlayerSymbol) :-
    (Player = 2),
    PlayerSymbol = 'o'.





% Count the number of times X appears in a 2D list given.
% X : Element to be counted
% [L|Ls] : List to be traverse
% N : Variable to store the number of times the character X appears in the list given
% count(+X, +[X | Tail], -N)
count_2d(_, [], 0).
count_2d(X, [L|Ls], N) :- count(X, L, N1), count_2d(X, Ls, N2), N is N1 + N2.

count(_, [], 0).
count(X, [X | Tail], N) :- count(X, Tail, N1), N is N1 + 1.
count(X, [Y | Tail], N) :- X \= Y, count(X, Tail, N).



% Choose the cell coordinates when it's computer's turn
% Column : Random column coordinate
% Row : Random row coordinate
% BoardSize : Size of the board
% optionBotPlay(-Column, -Row, +Board, +BoardSize)
optionBotPlay(Column, Row, Board, BoardSize) :-
    repeat,
        random(0, BoardSize, NewColumn),
        Column is NewColumn,
        random(0, BoardSize, NewRow),
        Row is NewRow,
        valid_move(Board, Row, Column, '-', Exists, BoardSize),
        (Exists = 1), nl, !.







