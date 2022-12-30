:- consult(general).
:- consult(board).
:- consult(userInput).
:- consult(helper).
:- consult(find_path).
:- consult(playerVSplayer).
:- consult(playerVSpc).
:- use_module(library(lists)).

:- dynamic board/1, player/1, visited/1.

% alphLetters(['A','B','C','D','E','F','G','H',
%             'I','J','K','L','M','N','O','P',
%             'Q','R','S','T','U','V','W','X',
%             'Y','Z']).

alphLetters(['a','b','c','d','e','f','g','h',
            'i','j','k','l','m','n','o','p',
            'q','r','s','t','u','v','w','x',
            'y','z']).


play :-
    abolish(player/1),
    initialMenuDisplay,
    initialMenu(OptionMenu),
    initial_state(BoardSize, Board),
    display_game(BoardSize, Board),

    (OptionMenu == 1 -> 
      game_cycle1(BoardSize, Board, 1, OptionMenu)
      ;
      (OptionMenu == 2 ->
        game_cycle2(BoardSize, Board, 1, OptionMenu) 
        ;
        nl
      )
    ),

    congrats.





initial_state(BoardSize, Board) :-
    boardSize(BoardSize),
    cls,
    initialMenuDisplay,
    createInitialBoard(BoardSize, BoardSize, Board),
    assert(board(Board)),
    assert(player(1)).


display_game(BoardSize, Board) :-
    printAllBoard(BoardSize, Board), nl.


% game_cycle(GameState) :-
%     game_over(GameState, Winner), !,
%     congralute(Winner).

