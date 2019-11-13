%palindroma(L) :- reverse(L,L).

%OR

palindroma(L) :-
  length(L,N),
  ((0 is N mod 2,!,palindroma_par(L,N));
  palindroma_impar(L,N)).

palindroma_par(L,N) :-
  Stop is N/2,
  invert_half(L,0,Stop,[],L1,L2),
  check_rest(L1,L2).

palindroma_impar(L,N) :-
  Stop is N//2,
  invert_half(L,0,Stop,[],L1,[_|L2]),
  check_rest(L1,L2),!.

invert_half(Rest,Stop,Stop,L1,L1,Rest).
invert_half([E|Rest],Curr,Stop,L,L1,Left) :-
  Curr1 is Curr+1,
  append([E],L,L2),
  invert_half(Rest,Curr1,Stop,L2,L1,Left).

check_rest([],[]) :-!.
check_rest([E1|Rest],[E2|Rest2]) :-
  E1 == E2,
  check_rest(Rest,Rest2).


