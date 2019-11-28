:- use_module(library(clpfd)).

puzzle_a(Letters) :-
  Letters = [S,E,N,D,M,O,R,Y],
  domain(Letters,0,9),
  all_distinct(Letters),
  domain([D1,D2,D3,D4],0,1),
  S #\= 0, M #\= 0,
  D + E #= Y + D1 * 10,
  N + R + D1 #= E + D2 * 10,
  E + O + D2 #= N + D3 * 10,
  S + M + D3 #= O + D4 * 10,
  D4 #= M,
  labeling([],Letters).
  
puzzle_b(Letters) :-
  Letters = [D,O,N,A,L,G,E,R,B,T],
  domain(Letters,0,9),
  all_distinct(Letters),
  domain([D1,D2,D3,D4,D5],0,1),
  D #\= 0, G #\= 0, R #\= 0,
  D + D #= T + D1 *10,
  L + L + D1 #= R + D2 * 10,
  A + A + D2 #= E + D3 * 10,
  N + R + D3 #= B + D4 * 10,
  O + E + D4 #= O + D5 * 10,
  D + G + D5 #< 10,
  labeling([],Letters).

