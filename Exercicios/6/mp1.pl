map([],_,[]).
map([Elem|Rest],Func,[ElemOut|RestOut]) :-
  calc(Func,Elem,ElemOut),
  map(Rest,Func,RestOut).

calc(Func,Elem,ElemOut) :-
  F =.. [Func,Elem,ElemOut],
  F.

duplica(X,Y):- Y is 2*X.