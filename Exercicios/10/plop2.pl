:- use_module(library(clpfd)).

lazy_man(Seq,N,Total) :-
  length(Seq,N),
  domain(Seq,1,N),
  all_distinct(Seq),
  element(N, Seq, 6),
  NTrips is N-1,
  length(Ts,NTrips),
  trip_time(Ts,Seq),
  sum(Ts, #=, Total),
  labeling([maximize(Total)],Seq).

trip_time([],[_]).
trip_time([T|Ts],[S1,S2|Ss]) :-
  T #= abs(S2-S1),
  trip_time(Ts,[S2|Ss]).

  
  
  