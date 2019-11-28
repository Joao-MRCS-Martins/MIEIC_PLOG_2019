:- use_module(library(clpfd)).

lollygagin(Disposition) :-
  Disposition = [C1,U1,U2,C2,L1,L2,R1,R2,C3,D1,D2,C4],
  domain(Disposition,0,12),
  C1 + L1 + L2 + C3 #= 5,
  C1 + U1 + U2 + C2 #= 5,
  C2 + R1 + R2 + C4 #= 5,
  C3 + D1 + D2 + C4 #= 5,
  labeling([],Disposition).
  




















