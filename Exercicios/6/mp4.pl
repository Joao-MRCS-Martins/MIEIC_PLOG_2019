functor2(Term,F,Arity) :-
  Term =.. [F|Args],
  length(Args,Arity).

arg2(N,Term,Arg) :-
  Term =.. [_|Args],
  nth1(N,Args,Arg).