% Take the user input for the board size
% boardSize(-BoardSize)
boardSize(BoardSize) :-
    repeat,
      write('Size of the board (1-26): '),
      read(BoardSize),
      number(BoardSize),
      (BoardSize > 0),
      (BoardSize < 27), nl, !.
  

% Creates the initial board depending on the user input
% N : Number to be decremeneted until it reaches 0 (initially it's equal to Boardsize)
% BoardSize : Size of the board inputed by the user
% [Line | Rest] : List to store the board
% createInitialBoard(+N, +BoardSize, -[Line | Rest])
createInitialBoard(0, _,_).
createInitialBoard(N, BoardSize, [Line | Rest]) :-
    createInitialLine(BoardSize, Line),
    Next is N-1,
    createInitialBoard(Next, BoardSize, Rest). 

% createLine(+N, +[OldChar | OldRest], -[OldChar | Rest])
createLine(0, _, []).
createLine(N, [OldChar | OldRest], [OldChar | Rest]) :-
    Next is N-1,
    createLine(Next, OldRest, Rest).

% createBoard(+N, +BoardSize, -[Line | Rest])
createBoard(0, _,_).
createBoard(N, BoardSize, [Line|Rest]) :-
    createLine(BoardSize, Line),
    Next is N-1,
    createBoard(Next, BoardSize, Rest).

% createInitialLine(+N, -['-' | Rest])
createInitialLine(0, []).
createInitialLine(N, ['-' | Rest]) :-
    Next is N-1,
    createInitialLine(Next, Rest).

 


% Transverse the board line received and place the Stone given as paramter in the Line given, on the Column specified
% N : Variable to decrease (initial value = BoardSize)
% BoardSize : board size
% Column : new column position
% [OldChar | OldRest] : old board to be analyzed
% [Line | Rest] : new board to be created
% CreaLineNew_Row(+N, +BoardSize, +[OldChar | OldRest] , -[OldChar | Rest], -Stone)
createLineNew_Row(0, _, _, _, [], _).
createLineNew_Row(N, BoardSize, Column, [OldChar | OldRest], [OldChar | Rest], Stone) :- 
    ((BoardSize - N) =\= Column),
    Next is N-1, 
    createLineNew_Row(Next, BoardSize, Column, OldRest, Rest, Stone).

createLineNew_Row(N, BoardSize, Column, [_ | OldRest], [Stone | Rest], Stone) :-
    Next is N - 1,
    createLineNew_Row(Next, BoardSize, Column, OldRest, Rest, Stone).



% Find the row that has index = Row
% N = Variable to decrease (initial value = BoardSize)
% BoardSize = board size
% Column = new column position
% Row = new row position
% [OldLine | OldRest] = old board
% [Line | Rest] = new board to be created
% Stone : Symbol to be placed on the cell (Column, Row)
% move(+N, +BoardSize, +Column, +Row, +[OldLine | OldRest], -[Line | Rest], +Stone)
move(0, _, _, _, _, _, _).
move(N, BoardSize, Column, Row, [OldLine | OldRest], [Line | Rest], Stone) :-
    ((BoardSize - N) =\= Row),
    createLine(BoardSize, OldLine, Line),
    Next is N-1,
    move(Next, BoardSize, Column, Row, OldRest, Rest, Stone).

move(N, BoardSize, Column, Row, [OldLine | OldRest], [Line | Rest], Stone) :-
    createLineNew_Row(BoardSize, BoardSize, Column, OldLine, Line, Stone), % create new line
    Next is N-1,
    move(Next, BoardSize, Column, Row, OldRest, Rest, Stone).


% Prints a Line of the board
% [Elem | Rest] : A line of the Board
% printLine(+[Elem | Rest])
printLine([]).
printLine([Elem | Rest]) :-
    write(Elem),
    write(' '),
    printLine(Rest).


% Prints the letters refering to the columns of the board
% N : variable to be decreased
% BoardSize : size of the board
% [Letter | Rest] : list with the letters of the alphabet
% printLetters(+N, +BoardSize, +[Line | Rest])
printLetters(0, _, _).
printLetters(N, BoardSize, [Letter | Rest]) :-
    write(' '),
    write(Letter),
    Next is N - 1,
    printLetters(Next, BoardSize, Rest).


% Prints the spaces before each line, in order ot create the diagonal board
% Space : Number of spaces
% writeSpace(+Space)
writeSpace(Space) :-
    Space > 8,
    print_n(Space-1, ' ').
    
writeSpace(Space) :-
    print_n(Space, ' ').


% Prints the lines of the board
% printBoadLines(+N, +BoardSize, +[Line | Rest])
printBoardLines(0,_,_).
printBoardLines(N, BoardSize, [Line | Rest]) :-
    Space is BoardSize-N,
    writeSpace(Space),
    Number is Space+1,
    write(Number),
    write(' '),
    printLine(Line),
    write(Number), nl,
    Next is N-1,
    printBoardLines(Next, BoardSize, Rest).


% Display the current state of the board
% BoardSize : Size of the board
% Board : Varible where the current board is stored
% display_game(+BoardSize, +Board)
display_game(BoardSize, Board) :-
    alphLetters(Letters),
    printLetters(BoardSize, BoardSize, Letters), nl,
    printBoardLines(BoardSize, BoardSize, Board),
    print_n(BoardSize+1, ' '),
    printLetters(BoardSize, BoardSize, Letters), nl.
