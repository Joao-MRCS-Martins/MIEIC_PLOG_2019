substitui(_,_,[],[]) :- !.
substitui(X,Y,[E1|Rest],[E2|Rest2]) :-
  (X == E1, E2 is Y; E2 is E1),
  substitui(X,Y,Rest,Rest2).

%a lista fica construida com os elementos que aparecem em ultimo lugar
elimina_duplicados([],[]).
elimina_duplicados([E|Rest],[E2|Rest2]) :-
  \+member2(E,Rest),!,E2 is E,
  elimina_duplicados(Rest,Rest2).

elimina_duplicados([_|Rest],L2) :-
  elimina_duplicados(Rest,L2).

member2(_,[]) :- fail.
member2(E,[X|Rest]) :-
  E == X ; member2(E,Rest).