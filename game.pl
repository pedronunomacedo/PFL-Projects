
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% BOARD %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





:- dynamic board/1, player/1.

alphLetters(['A','B','C','D','E','F','G','H',
            'I','J','K','L','M','N','O','P',
            'Q','R','S','T','U','V','W','X',
            'Y','Z']).


cls:-
  write('\33\[2J').


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




createLineNew(0, []).
createLineNew(N, ['X'|Rest]) :-
  Next is N-1,
  createLine(Next, Rest).

createBoardNew(0, _,_).
createBoardNew(N, BoardSize, [Line|Rest]) :-
  createLineNew(BoardSize, Line),
  Next is N-1,
  createBoard(Next, BoardSize, Rest).




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

print_n(0, _C):- !.
print_n(N, C):-
  write(C),
  N1 is N-1,
  print_n(N1, C).


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







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% MAIN %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





play :-
  cls,
  boardSize(BoardSize),
  cls,
  createBoard(BoardSize, BoardSize, Board),
  assert(board(Board)),
  assert(player(1)),
  printAllBoard(BoardSize, Board), nl,
  ask_symbol,
  game(Board, BoardSize).






game(Board, BoardSize) :-
  player(Player),
  write(Player), nl,
  takeInput,
  cls,

  retract(player(Player)),
  NewPlayer is (mod(Player, 2) + 1),
  assert(player(NewPlayer)),

  retract(board(Board)),
  createBoardNew(BoardSize, BoardSize, BoardNew),
  assert(board(BoardNew)),

  printAllBoard(BoardSize, BoardNew), nl,
  game(BoardNew, BoardSize).







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Initial State %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



/*

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


*/
ask_symbol :-
  repeat,
    write('Choose your symbol (X or O): '),
    read(Symbol),
    (Symbol = 'X'; Symbol = 'O'; Symbol = 'x'; Symbol = 'o'), nl, !.



takeInput :-
  write('Next move: '),
  read(Move), nl.






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
