
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% BOARD %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





:- dynamic board/1.



boardSize(BoardSize) :-
  repeat,
    write("Size of the board: "),
    read(BoardSize),
    number(BoardSize),
    (BoardSize > 0), nl, !.

createLine(0, []).
createLine(N, ['-'|Rest]) :-
  Next is N-1,
  createLine(Next, Rest).

createBoard(0, []).
createBoard(N, [_|Rest]) :-
  Next is N-1,
  createBoard(Next, Rest).

printBoard(0,_,_).
printBoard(N, Board, [Line|Rest]) :-
  Space is Board-N,
  writeSpace(Space),
  printLine(Line),
  Next is N-1,
  printBoard(Next, Board, Rest).

writeSpace(Space) :-
  Space > 9,
  print_n(Space-1, ' ').

writeSpace(Space) :-
  print_n(Space, ' ').

printLine([]) :- nl.
printLine([Elem|Rest]) :-
  write(Elem),
  write(' '),
  printLine(Rest).





play :-
  boardSize(BoardSize),
  createBoard(BoardSize, Board),
  assert(board(Board)).







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

print_n(0, _C):- !.
print_n(N, C):-
  write(C),
  N1 is N-1,
  print_n(N1, C).





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
