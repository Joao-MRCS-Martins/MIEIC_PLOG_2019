conta(Lista,N) :-
  contaN(Lista,0,N).

contaN([],N,N).
contaN([_|Rest],N,N2) :-
  N3 is N+1,
  contaN(Rest,N3,N2).

conta_elem(X,Lista,N) :-
  conta_elem2(X,Lista,0,N).

conta_elem2(_,[],N,N).
conta_elem2(X,[E|Rest],N,N2) :-
  (X==E,N3 is N+1,!,conta_elem2(X,Rest,N3,N2));
  !,conta_elem2(X,Rest,N,N2).