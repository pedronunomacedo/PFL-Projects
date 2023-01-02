% Define a 2D list
list([[1, 2, 3], [4, 5, 6], [7, 8, 9]]).

% Change the symbol of the cell (Row, Column) to NewValue
% Row : row of the cell to be modified
% Column : column of the cell to be modified
% NewValue : Symbol to be placed in the cell (Row, Column)
% List : Previous list to be traverse
% NewList : New list with the cell (Row, Column) modified
% changeElementOnAList(+Row, +Column, +NewValue, +List, -NewList)
changeElementOnAList(Row, Column, NewValue, List, NewList) :-
    change_element(0, 0, Row, Column, NewValue, List, NewList).

    change_element(_, _, _, _, _, [], []).

% change_element(+CurrentI, +CurrentJ, +I, +J, +NewValue, +[Row|Rest], -[Row|NewRest])
change_element(CurrentI, CurrentJ, I, J, NewValue, [Row|Rest], [Row|NewRest]) :-
    (CurrentI =\= I), 
    NextCurrentI is CurrentI+1,
    change_element(NextCurrentI, CurrentJ, I, J, NewValue, Rest, NewRest).

change_element(CurrentI, CurrentJ, I, J, NewValue, [Row|Rest], [NewRow|Rest]) :-
    change_element_row(0, J, NewValue, Row, NewRow).

% change_element_row(+CurrentJ, +J, +NewValue, +[Elem | RestRow], -[Elem | RestNewRow])
change_element_row(_, _, _, [], []).
change_element_row(CurrentJ, J, NewValue, [Elem | RestRow], [Elem | RestNewRow]) :-
    (CurrentJ =\= J), 
    NextCurrentJ is CurrentJ+1,
    change_element_row(NextCurrentJ, J, NewValue, RestRow, RestNewRow).

change_element_row(CurrentJ, J, NewValue, [Elem | RestRow], [NewValue | RestNewRow]) :-
    NextCurrentJ is CurrentJ+1, 
    change_element_row(NextCurrentJ, J, NewValue, RestRow, RestNewRow).





% Check if a specific cell was already visited when executing a DFS
% X : row coordinate
% Y : column coordinate
% CheckValue : Current "state" of the cell (0 - not visited or 1 - visited)
% Visited : 2d list containg the visited boolean of all the cells of the board
% ElemVisited : Variable to store of the cell was visited or not (ElemVisited = 0 if cell was visited, or ElemVisited = 1 otherwise)
% isVisited(+X, +Y, +CheckValue, +Visited, -ElemVisited)
isVisited(X, Y, CheckValue, Visited, ElemVisited) :-
    nth0(X, Visited, Line),
    nth0(Y, Line, Elem), 
    (CheckValue = Elem), 
    ElemVisited is 1, nl.

isVisited(X, Y, CheckValue, Visited, ElemVisited) :-
    ElemVisited is 0.





% In the begginig, all elements weren't visited, so ElemVisited = 0
% [Line | BoardRest] : board list
% [LineVisited | VisitedRest] : 2d list contiang the visited boolean of all the cells of the board
% createVisitedList(-[Line | BoardRest], +[LineVisited | VisitedRest])
createVisitedList([], []).
createVisitedList([Line | BoardRest], [LineVisited | VisitedRest]) :-
    createVisitedList_Row(Line, LineVisited), 
    createVisitedList(BoardRest, VisitedRest).

% createVisitedList_Row(+[Elem | LineRest], -[0 | LineVisitedRest])
createVisitedList_Row([], []).
createVisitedList_Row([Elem | LineRest], [0 | LineVisitedRest]) :-
    createVisitedList_Row(LineRest, LineVisitedRest).
