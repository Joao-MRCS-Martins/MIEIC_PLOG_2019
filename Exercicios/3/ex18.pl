duplica([],[]) :- !.
duplica([E1|Rest],[E2,E3|Rest2]) :-
  E2 = E1,E3 = E1,
  duplica(Rest,Rest2).


duplicaN(L1,N,L2) :-
  duplicaN(L1,N,[],L2).

duplicaN([],_,L2,L2) :- !.
duplicaN([E1|Rest],N,Aux,L2) :-
  dups(E1,N,Tmp),
  append(Aux,Tmp,Aux2),
  duplicaN(Rest,N,Aux2,L2).

dups(_,0,[]):- !.
dups(E,N,[E2|Rest]) :-
  N1 is N-1,
  E2 = E,
  dups(E,N1,Rest).