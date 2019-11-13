num_pascal(N,N,1):-!.
num_pascal(N,K,X):- (N @< K;N @=<0; K @=<0),X is 0.
num_pascal(N,K,X):- N1 is N-1,K1 is K-1,!,num_pascal(N1,K1,X1),!,num_pascal(N1,K,X2), X is X1+X2.

pascal(N,L) :-
  pascal(1,N,L).

pascal(N,N,[1]):-!.
pascal(N1,N,[E|Rest]):-
  num_pascal(N,N1,E),
  N2 is N1+1,
  pascal(N2,N,Rest).