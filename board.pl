boardSize(BoardSize) :-
    repeat,
      write('Size of the board (1-26): '),
      read(BoardSize),
      number(BoardSize),
      (BoardSize > 0),
      (BoardSize < 27), nl, !.
  
  
createLine(0, _, []).
createLine(N, [OldChar | OldRest], [OldChar | Rest]) :-
    Next is N-1,
    createLine(Next, OldRest, Rest).

createInitialLine(0, []).
createInitialLine(N, ['-' | Rest]) :-
    Next is N-1,
    createInitialLine(Next, Rest).
  
createInitialBoard(0, _,_).
createInitialBoard(N, BoardSize, [Line | Rest]) :-
    createInitialLine(BoardSize, Line),
    Next is N-1,
    createInitialBoard(Next, BoardSize, Rest).  

createBoard(0, _,_).
createBoard(N, BoardSize, [Line|Rest]) :-
    createLine(BoardSize, Line),
    Next is N-1,
    createBoard(Next, BoardSize, Rest).

createLineNew_Row(0, _, _, _, [], _).
createLineNew_Row(N, BoardSize, Column, [OldChar | OldRest], [OldChar | Rest], Stone) :- 
    ((BoardSize - N) =\= Column),
    Next is N-1, 
    createLineNew_Row(Next, BoardSize, Column, OldRest, Rest, Stone).

createLineNew_Row(N, BoardSize, Column, [OldChar | OldRest], [Stone | Rest], Stone) :-
    Next is N - 1,
    createLineNew_Row(Next, BoardSize, Column, OldRest, Rest, Stone).


% Find the row that has as index Row
% N = Variable to decrease (initial value = BoardSize)
% BoardSize = board size
% Column = new column position
% Row = new row position
% [Line | Rest] = new board to be created
createBoardNew(0, _, _, _, _, _, _).
createBoardNew(N, BoardSize, Column, Row, [OldLine | OldRest], [Line | Rest], Stone) :-
    ((BoardSize - N) =\= Row),
    createLine(BoardSize, OldLine, Line),
    Next is N-1,
    createBoardNew(Next, BoardSize, Column, Row, OldRest, Rest, Stone).

% Find the row that has as index Row
createBoardNew(N, BoardSize, Column, Row, [OldLine | OldRest], [Line | Rest], Stone) :-
    createLineNew_Row(BoardSize, BoardSize, Column, OldLine, Line, Stone), % create new line
    Next is N-1,
    createBoardNew(Next, BoardSize, Column, Row, OldRest, Rest, Stone).



printLine([]).
printLine([Elem|Rest]) :-
    write(Elem),
    write(' '),
    printLine(Rest).


printLetters(0, _, _).
printLetters(N, BoardSize, [Letter|Rest]) :-
    write(' '),
    write(Letter),
    Next is N - 1,
    printLetters(Next, BoardSize, Rest).

writeSpace(Space) :-
    Space > 8,
    print_n(Space-1, ' ').
    
writeSpace(Space) :-
    print_n(Space, ' ').

printBoardLines(0,_,_).
printBoardLines(N, BoardSize, [Line|Rest]) :-
    Space is BoardSize-N,
    writeSpace(Space),
    Number is Space+1,
    write(Number),
    write(' '),
    printLine(Line),
    write(Number), nl,
    Next is N-1,
    printBoardLines(Next, BoardSize, Rest).


printAllBoard(BoardSize, Board) :-
    alphLetters(Letters),
    printLetters(BoardSize, BoardSize, Letters), nl,
    printBoardLines(BoardSize, BoardSize, Board),
    print_n(BoardSize+1, ' '),
    printLetters(BoardSize, BoardSize, Letters), nl.

% getBoardSymbol(BoardSize, Row, Column, BoardSymbol, Board) :-