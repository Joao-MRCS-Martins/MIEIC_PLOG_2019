other_line :-
  length(Cars,12), 
  domain(Cars,1,4),%1 - amarelo, 2 - verde, 3 - vermelho, 4 - azul
  global_cardinality(Cars, [1-4,2-2,3-3,4-3]),
  element(1, Cars, C1), element(12,Cars,C1),
  element(2,Cars,C2),element(11,Cars,C2),
  element(5,Cars,4),
  three_seq(Cars),
  four_seq(Cars,1),
  labeling([],Cars),write(Cars).

three_seq([_,_]).
three_seq([A,B,C|T]) :-
  all_distinct([A,B,C]),
  three_seq([B,C|T]).
  
four_seq([_,_,_],0).
four_seq([A,B,C,D|T],N) :-
  four_seq([B,C,D|T],N2),
  N #= N2 + V,
  (A #= 1 #/\ B#=2 #/\ C #=3 #/\ D#=4) #<=> V.
  