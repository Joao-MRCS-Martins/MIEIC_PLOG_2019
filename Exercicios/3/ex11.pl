achata_lista([],[]):- !.
achata_lista(E,[E]) :- atomic(E).
achata_lista([E|Rest],L) :-
  achata_lista(E,L1),
  achata_lista(Rest,L2),
  append(L1,L2,L).