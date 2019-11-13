dropN(L,N,X) :- dropN(L,N,N,X).

dropN([],_,_,[]):- !.
dropN([_|Rest],1,N2,L2) :- !,dropN(Rest,N2,N2,L2).
dropN([E1|Rest],N1,N2,[E2|Rest2]):- (Nx is N1-1, E2 is E1, dropN(Rest,Nx,N2,Rest2)).