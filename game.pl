:- consult(general).
:- consult(board).
:- consult(userInput).
:- consult(helper).
:- consult(find_path).
:- consult(playerVSplayer).
:- consult(playerVSpc).
:- consult(pcVSplayer).
:- consult(pcVSpc).
:- use_module(library(lists)).
:- use_module(library(random)).

% board : stores the current board state
% player : stores the user that it's playing in that moment
% visited : stores the cells already visited when executing the DFS
:- dynamic board/1, player/1, visited/1.

% Columns numbering
alphLetters(['a','b','c','d','e','f','g','h',
            'i','j','k','l','m','n','o','p',
            'q','r','s','t','u','v','w','x',
            'y','z']).


% Start the game by entering the predicate 'play' on the SICStus terminal
play :-
    abolish(player/1),
    initialMenuDisplay,
    initialMenu(OptionMenu),
    (OptionMenu == 1 ->
      nl
      ;
      difficultyMenu(OptionDifficulty)
    ),
    initial_state(BoardSize, Board),
    display_game(BoardSize, Board),
    (OptionMenu == 1 -> 
        game_cycle1(BoardSize, Board, 1, OptionMenu)
        ;
        (OptionMenu == 2 ->
            game_cycle2(BoardSize, Board, 1, OptionMenu, OptionDifficulty)
            ;
            (OptionMenu == 3 ->
                game_cycle3(BoardSize, Board, 1, OptionMenu, OptionDifficulty)
                ;
                (OptionMenu == 4 ->
                    game_cycle4(BoardSize, Board, 1, OptionMenu, OptionDifficulty)
                    ;
                    nl
                )
            )
        )
    ),

    congrats.




% Build the initial board depending on the inputed size
% BoardSize : user input that refers to the board size (width and height)
% Board : variable where to store the board of the game
% initial_state(+BoardSize, -Board)
initial_state(BoardSize, Board) :-
    boardSize(BoardSize),
    cls,
    initialMenuDisplay,
    createInitialBoard(BoardSize, BoardSize, Board),
    assert(board(Board)),
    assert(player(1)).

% Congratulates the winner that corresponds to the current Player, and exit the game.
congrats :- 
    player(Player),
    getPlayerSymbol(Player, PlayerSymbol),
    write('-------------------------------'), nl,
    write('|   P L A Y E R   '), write(PlayerSymbol), write(' W O N   |'), nl,
    write('-------------------------------'), nl, nl, nl, nl, nl, nl,
    halt.
  

% If the game results in a tie.
draw :-
    write('-------------------------------'), nl,
    write('|           D R A W           |'), nl,
    write('-------------------------------'), nl, nl, nl, nl, nl, nl,
    halt.
