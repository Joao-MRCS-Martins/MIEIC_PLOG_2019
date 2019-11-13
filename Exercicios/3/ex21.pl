slice(L,N1,N2,L2) :-
  slice(L,1,N1,N2,L2).

slice([],_,_,_,[]):-!.
slice([_|Rest],N,N1,N2,L2) :- N @< N1, Nx is N+1, !,slice(Rest,Nx,N1,N2,L2).
slice(_,N,_,N2,L2) :- N @> N2, !,slice([],N,N,N,L2).
slice([E|Rest],N,N1,N2,[E2|Rest2]) :- E2 = E, Nx is N+1, !,slice(Rest,Nx,N1,N2,Rest2).