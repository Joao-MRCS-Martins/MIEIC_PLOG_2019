:- use_module(library(clpfd)).

lazy_man(Seq,N,Total) :-
  length(Seq,N),
  domain(Seq,1,N),
  all_distinct(Seq),
  element(N, Seq, 6),
  trip_time(Seq,Total),
  labeling([maximize(Total)],Seq).

trip_time([_],0).
trip_time([S1,S2|Ss],T) :-
  T #= T2 + abs(S2-S1),
  trip_time([S2|Ss],T2).

  
  
  