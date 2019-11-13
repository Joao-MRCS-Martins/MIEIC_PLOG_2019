primo(2).
primo(3).
primo(N):- N>3,\+verifica_div(N,2).

verifica_div(N,P):- P =< sqrt(N),divisivel_por(N,P).
verifica_div(N,P):- P1 is P+1, P1 =< sqrt(N),verifica_div(N,P1).
divisivel_por(N,P) :- N mod P =:= 0.

lista_primos(2,[]) :- !.
lista_primos(N,[E|Rest]) :-
  N1 is N-1,((primo(N), E is N,!, lista_primos(N1,Rest));lista_primos(N1,[E|Rest])).
