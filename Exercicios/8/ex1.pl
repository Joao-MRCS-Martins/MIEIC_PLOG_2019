:- use_module(library(clpfd)).

magic(Square) :-
  Square = [S1,S2,S3,S4,S5,S6,S7,S8,S9],
  domain(Square,1,9),
  all_distinct(Square),
  S1+S2+S3 #= Sum,
  S4+S5+S6 #= Sum,
  S7+S8+S9 #= Sum,
  S1+S4+S7 #= Sum,
  S2+S5+S8 #= Sum,
  S3+S6+S9 #= Sum,
  S1+S5+S9 #= Sum,
  S3+S5+S7 #= Sum,
  S1 #< S3,S1 #< S7, S1 #< S9,
  labeling([],Square).

display :-
  magic(Square),
  printListByRow(Square,3).

printListByRow([],_) :- nl.
printListByRow(L,0) :-
  nl, printListByRow(L,3).
printListByRow([E|Ls],N) :-
  write(E), write(' '),
  N1 is N-1,
  printListByRow(Ls,N1).
  