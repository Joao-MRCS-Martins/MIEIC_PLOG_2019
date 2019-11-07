ordenada([_]).
ordenada([E1,E2]) :- E1 =< E2.
ordenada([E1,E2|Rest]) :-
  E1 =< E2,
  ordenada([E2|Rest]).

ordena([],[]).
ordena(L1,[E2|Rest2]) :-
  findMin(L1,E2,Rest),
  ordena(Rest,Rest2).

findMin(List,Elem,Rest) :-
  findMinIndex(List,Elem,Num),
  elim(List,Num,Rest).

findMinIndex([N1|Rest],Elem,Num) :-
  findMinAux(Rest,N1,Elem,0,0,Num).

findMinAux([],Min,Min,_,Num,Num):- !.
findMinAux([N1|Ns],Min,Min2,Curr,NumA,Num) :-
  (N1 < Min, Min1 is N1, CurrN is Curr+1, findMinAux(Ns,Min1,Min2,CurrN,CurrN,Num));
  CurrN is Curr + 1, findMinAux(Ns,Min,Min2,CurrN,NumA,Num).

elim([_|H],0,H):- !.
elim([G|H],N,[G|L]):- 
  N > 0, 
  Nn is N - 1,!,
  elim(H,Nn,L).

