:- op(200,xfx,existe_em).
X existe_em [X|_].
X existe_em [_|Rest] :-
  X existe_em Rest.

:- op(200,fx,concatena).
:- op(150,xfx, da).
:- op(100,xfx,e).

concatena [] e L da L.
concatena [X|L1] e L2 da [X|L3] :-
  concatena L1 e L2 da L3.