before(_,_,[]) :- fail.
before(A,B,[E|Rest]) :-
  (A == E, checkSecond(B,Rest));
  before(A,B,Rest).

checkSecond(_,[]) :- fail.
checkSecond(B,[E|_]) :-
  B == E; checkSecond(B,Rest).