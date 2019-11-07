separa(List,Pred,ListOut) :-
  separaA(List,Pred,[],[],ListOut).

separaA([],_,Yes,Not,Out) :-
  append(Yes,Not,Out).
separaA([E|Rest],P,Yes,Not,Out) :-
  calc(P,E),!,
  append(Yes,[E],YesN),
  separaA(Rest,P,YesN,Not,Out).

separaA([E|Rest],P,Yes,Not,Out) :-
  append([E],Not,NotN),
  separaA(Rest,P,Yes,NotN,Out).

calc(Func,Elem) :-
  F =.. [Func,Elem],
  F.

isEven(E) :-
 0 is mod(E,2).