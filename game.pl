
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% BOARD %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



initial(board([['-','-','-','-','-','-','-','-','-','-','-'],
               ['-','-','-','-','-','-','-','-','-','-','-'],
               ['-','-','-','-','-','-','-','-','-','-','-'],
               ['-','-','-','-','-','-','-','-','-','-','-'],
               ['-','-','-','-','-','-','-','-','-','-','-'],
               ['-','-','-','-','-','-','-','-','-','-','-'],
               ['-','-','-','-','-','-','-','-','-','-','-'],
               ['-','-','-','-','-','-','-','-','-','-','-'],
               ['-','-','-','-','-','-','-','-','-','-','-'],
               ['-','-','-','-','-','-','-','-','-','-','-'],
               ['-','-','-','-','-','-','-','-','-','-','-']])).

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
  ask_color,
  takeInput.



initial_state :-
  initial(X),
  show(X).

display_game('Initial') :-
  initial_state.

/*display_game(GameState) :-*/



ask_color :-
  repeat,
    write('Choose a color (Blue or Red)? '),
    read(Color),
    (Color = 'Blue'; Color = 'Red'), nl, !.



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
