
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% BOARD %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





:- dynamic(board/1).

alphLetters(['A','B','C','D','E','F','G','H',
                'I','J','K','L','M','N','O','P',
                'Q','R','S','T','U','V','W','X',
                'Y','Z']).



boardSize(BoardSize) :-
  repeat,
    write('Size of the board (1-26): '),
    read(BoardSize),
    number(BoardSize),
    (BoardSize > 0),
    (BoardSize < 27), nl, !.

createLine(0, []).
createLine(N, ['-'|Rest]) :-
  Next is N-1,
  createLine(Next, Rest).

createBoard(0, _,_).
createBoard(N, BoardSize, [Line|Rest]) :-
  createLine(BoardSize, Line),
  Next is N-1,
  createBoard(Next, BoardSize, Rest).

printLine([]).
printLine([Elem|Rest]) :-
  write(Elem),
  write(' '),
  printLine(Rest).

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

writeSpace(Space) :-
  Space > 8,
  print_n(Space-1, ' ').

writeSpace(Space) :-
  print_n(Space, ' ').

printLetters(0, _, _).
printLetters(N, BoardSize, [Letter|Rest]) :-
  write(' '),
  write(Letter),
  Next is N - 1,
  printLetters(Next, BoardSize, Rest).



play :-
  boardSize(BoardSize),
  createBoard(BoardSize, BoardSize, Board),
  % printLine(Board).
  % assert(board(Board)),
  printAllBoard(BoardSize, Board).






/*
show(board(X)) :-
  print_n(2, ' '),
  write('A B C D E F G H I J K'), nl,
  iShow(X, 1),
  print_n(14, ' '),
  write('A B C D E F G H I J K'), nl, nl.

iShow(_,12).
iShow(X,N):-
  showLine(X,N,X2),
  Ns is N+1,
  iShow(X2,Ns).

showLine(X,N,X2):-
  N > 9,
  print_n(N-1, ' '),
  write(N), write(' '),
  iShowLine(X,X2),
  write(N), nl.

showLine(X,N,X2):-
  print_n(N, ' '),
  write(N), write(' '),
  iShowLine(X,X2),
  write(N), nl.

iShowLine([],_).
iShowLine([[X|X2]|XS],[X2|XS2]):-
  write(X), write(' '),
  iShowLine(XS,XS2).
*/
print_n(0, _C):- !.
print_n(N, C):-
  write(C),
  N1 is N-1,
  print_n(N1, C).

/*



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Initial State %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



play :-
  display_game('Initial'),
  ask_symbol,
  takeInput.



initial_state :-
  initial(X),
  show(X).

display_game('Initial') :-
  initial_state.

display_game(GameState) :-



ask_symbol :-
  repeat,
    write('Choose your symbol (X or O): '),
    read(Symbol),
    (Symbol = 'X'; Symbol = 'O'; Symbol = 'x'; Symbol = 'o'), nl, !.



takeInput :-
  write('Next move: '),
  read(Move), nl.
*/





/*
play :-
  initial_state(GameState),
  display_game(GameState),
  game_cycle(GameState).

game_cycle(GameState) :-
  game_over(GameState, Winner), !,
  congralute(Winner).

game_cycle(GameState) :-
  choose_move(GameState, Player, Move),
  move(GameState, Move, NewGameState),
  next_player(Player, NextPlayer),
  display_game(GameState-NextPlayer), !,
  game_cycle(NewGameState-NextPlayer).





choose_move(GameState, human, Move) :-
  % Rebeubeu, pardais ao ninho

choose_move(GameState, computer-Level, Move) :-
  valid_moves(GameState, Moves),
  choose_move(Level, GameState, Moves, Move).

valid_moves(GameState, Moves) :-
  findall(Move, move(GameState, Move, NewState), Moves).

choose_move(1, _GameState, Moves, Move) :-
  random_select(Move, Moves, _Rest).

choose_move(2, GameState, Moves, Move) :-
  setof(Value-Mv, NewState^(member(Mv, Moves),
        move(GameState, Mv, NewState),
        evaluate_board(NewState, value) ), [_V-Move|_] ).
*/
