produto_interno(L1,L2,N) :-
  length(L1,L),
  length(L2,L),  
  produto_interno(L1,L2,0,N).

produto_interno([],[],N,N).
produto_interno([N1|Rest],[N2|Rest2],Aux,N) :-
  Aux1 is N1*N2,
  Aux2 is Aux1+Aux,
  produto_interno(Rest,Rest2,Aux2,N).
