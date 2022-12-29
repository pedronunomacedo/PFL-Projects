% Define a 2D list
list([[1, 2, 3], [4, 5, 6], [7, 8, 9]]).

% Define the helper predicate
change_element_row(_, _, _, [], []).
change_element_row(CurrentJ, J, NewValue, [Elem | RestRow], [Elem | RestNewRow]) :-
    (CurrentJ =\= J), 
    NextCurrentJ is CurrentJ+1,
    change_element_row(NextCurrentJ, J, NewValue, RestRow, RestNewRow).

change_element_row(CurrentJ, J, NewValue, [Elem | RestRow], [NewValue | RestNewRow]) :-
    NextCurrentJ is CurrentJ+1, 
    change_element_row(NextCurrentJ, J, NewValue, RestRow, RestNewRow).


change_element(_, _, _, _, _, [], []).
change_element(CurrentI, CurrentJ, I, J, NewValue, [Row|Rest], [Row|NewRest]) :-
    (CurrentI =\= I), 
    NextCurrentI is CurrentI+1,
    change_element(NextCurrentI, CurrentJ, I, J, NewValue, Rest, NewRest).

change_element(CurrentI, CurrentJ, I, J, NewValue, [Row|Rest], [NewRow|Rest]) :-
    change_element_row(0, J, NewValue, Row, NewRow).

% Use the helper predicate to change the element at position (1, 2) (i.e., the second element of the first sublist) to 10
changeElementOnAList(Row, Column, NewValue, Lista, NewList) :-
    change_element(0, 0, Row, Column, NewValue, Lista, NewList).


isVisited(X, Y, CheckValue, Visited, ElemVisited) :-
    nth0(X, Visited, Line),
    nth0(Y, Line, Elem), 
    (CheckValue = Elem), 
    ElemVisited is 1, nl.

isVisited(X, Y, CheckValue, Visited, ElemVisited) :-
    ElemVisited is 0.
