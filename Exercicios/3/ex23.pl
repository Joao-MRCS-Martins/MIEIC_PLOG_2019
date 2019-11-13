rnd_selectN(_,0,[]):- !.
rnd_selectN(L,N,[E2|Rest]) :-
  length(L,S),
  random_between(1, S, N1),
  remove_elem(L,N1,E2,L1),
  Nx is N-1,
  rnd_selectN(L1,Nx,Rest).
  
remove_elem(L,N,E,X):-
  remove_elem(L,1,N,E,[],X).

remove_elem([E|Right],N,N,E,Left,X) :- append(Left,Right,X),!.
remove_elem([E|Rest],N1,N,E2,Aux,X) :- N2 is N1+1, append(Aux,[E],Aux2),!,remove_elem(Rest,N2,N,E2,Aux2,X).

rnd_selN(R,N,X) :-
  atomic(R),
  get_list(1,N,L),
  rnd_selectN(L,R,X).

get_list(N,N,[N]):-!.
get_list(N1,N,[X|Rest]) :-
  X is N1, N2 is N1+1,
  get_list(N2,N,Rest).