:- use_module(library(clpfd)).

turturkeykey(Price) :-
  Digits = [Highest,Lowest],
  domain(Digits,0,9),
  Price * 72 #= Total,
  Highest * 1000 + 670 + Lowest #= Total,
  labeling([], [Price]).
  