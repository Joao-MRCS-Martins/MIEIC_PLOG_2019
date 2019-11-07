delete_one(X,L1,L2):-
    append(L3,[X|L4],L1),
    append(L3,L4,L2).

delete_all(_,[],[]).
delete_all(X,[E|Rest],[E2|Rest2]) :-
    \+(X == E),!,
    E2 is E,
    delete_all(X,Rest,Rest2).

delete_all(X,[_|Rest],[E2|Rest2]) :-
    delete_all(X,Rest,[E2|Rest2]).

delete_all_lists([],L2,L2).
delete_all_lists([X|Rest],L1,L2) :-
    delete_all(X,L1,Aux),
    delete_all_lists(Rest,Aux,L2).