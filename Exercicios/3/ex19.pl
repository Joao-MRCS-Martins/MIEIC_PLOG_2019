runlength([],[]).
runlength([E1|Rest],[E2|Rest2]) :-
  runCode(E1,Rest,1,E2,RestAux),
  runlength(RestAux,Rest2).


runCode(E1,[],N,[N,E1],[]):-!.
runCode(E1,[E2|Rest],N,Out,RestO) :-
  (E1 == E2, N1 is N+1, !,runCode(E1,Rest,N1,Out,RestO));
  (Out = [N,E1],RestO = [E2|Rest]).

runlengthmodificado([],[]).
runlengthmodificado([E1|Rest],[E2|Rest2]) :-
  runCodemodificado(E1,Rest,1,E2,RestAux),
  runlengthmodificado(RestAux,Rest2).


runCodemodificado(E1,[],N,[N,E1],[]):-!.
runCodemodificado(E1,[E2|Rest],N,Out,RestO) :-
  (E1 == E2, N1 is N+1, !,runCodemodificado(E1,Rest,N1,Out,RestO));
  (((N == 1,!, Out = E1);Out = [N,E1]),RestO = [E2|Rest]).

rle_decode([],_) :- !.
rle_decode(L,X) :-
  decode_aux(L,[],X).

decode_aux([],X,X) :-!.
decode_aux([E|Rest],Aux,X) :-
  atomic(E),
  append(Aux,[E],Aux2),
  decode_aux(Rest,Aux2,X).

decode_aux([[N,C]|Rest],Aux,X) :-
  get_list(C,N,List),
  append(Aux,List,Aux2),
  decode_aux(Rest,Aux2,X).

get_list(_,0,[]) :-!.
get_list(C,N,[C1|Rest]) :-
  N1 is N-1,
  C1 = C,
  get_list(C,N1,Rest).
  