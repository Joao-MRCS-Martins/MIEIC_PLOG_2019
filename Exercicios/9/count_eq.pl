:- use_module(library(clpfd)).

count_equals(_,[],0).

count_equals(Val,[H|T],Count) :-
  (Val #= H) #<=> B,
  count_equals(Val,T,C1), 
  Count #= C1 + B.
  