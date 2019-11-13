rodar(L,N,X) :- N @<0,length(L,S), N1 is S+N, !,switch_list(L,0,N1,[],X).
rodar(L,N,X) :- !,switch_list(L,0,N,[],X).

switch_list(Part1,N,N,Part2,X) :- !,append(Part1,Part2,X).
switch_list([E|Rest],Curr,N,PartAux,X) :- Curr1 is Curr+1, append(PartAux,[E],Part2),switch_list(Rest,Curr1,N,Part2,X).