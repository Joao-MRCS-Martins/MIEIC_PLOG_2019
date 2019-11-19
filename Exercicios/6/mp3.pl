idade(maria,30).
idade(pedro,25).
idade(jose,25).
idade(rita,18).


mais_proximos(I,[N1|Prox]) :-
  setof(Diff-Nome,prox(I,Nome,Diff),[D1-N1|L]),
  buscaProx(L,D1,Prox).

prox(I,Nome,Diff) :-
  idade(Nome,I2),
  dif(I,I2,Diff).

dif(X,Y,Z) :- X > Y, !, Z is X - Y.
dif(X,Y,Z) :- Z is Y - X.

buscaProx(_,[],[]).
buscaProx([D1-_|_],D,[]) :- D1 > D, !.
buscaProx([_-N|Ls],D,[N|Ns]) :- buscaProx(Ls,D,Ns).