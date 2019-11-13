%%% alinea a

% lista_ate(0,[]) :- !.
% lista_ate(N,[E|Rest]):-
%   E is N,
%   N1 is N-1,
%   lista_ate(N1,Rest).

%OR

lista_ate(N,L) :-
  lista_ate_aux(N,[],L).

lista_ate_aux(0,L,L) :- !.
lista_ate_aux(N,Aux,L) :-
  N1 is N-1,
  append([N],Aux,L1),
  lista_ate_aux(N1,L1,L).

%%% alinea b

lista_entre(N1,N2,L) :-
  (N1 @> N2,!, lista_entre_decr(N1,N2,L));
  (lista_entre_cres(N1,N2,L)).

lista_entre_decr(N2,N2,[N2]) :- !.
lista_entre_decr(N1,N2,[E|Rest]) :-
  Aux is N1-1,
  E is N1,
  lista_entre_decr(Aux,N2,Rest).

lista_entre_cres(N2,N2,[N2]) :- !.
lista_entre_cres(N1,N2,[E|Rest]) :-
  Aux is N1+1,
  E is N1,
  lista_entre_cres(Aux,N2,Rest).

%%% alinea c

soma_lista(L,Soma) :-
  soma_lista(L,0,Soma).

soma_lista([],Soma,Soma).
soma_lista([N|Rest],Temp,Soma) :-
    Temp2 is Temp + N,
    soma_lista(Rest,Temp2,Soma).

%%% alinea d

par(N) :-
  0 is N mod 2.

%%% alinea e

lista_pares(1,[]) :- !.
lista_pares(N,[E|Rest]) :-
  N1 is N-1,((par(N), E is N,!, lista_pares(N1,Rest));lista_pares(N1,[E|Rest])).

%%% alinea f

lista_impares(1,[1]) :- !.
lista_impares(N,[E|Rest]) :-
  N1 is N-1,((\+par(N), E is N,!, lista_impares(N1,Rest));lista_impares(N1,[E|Rest])).