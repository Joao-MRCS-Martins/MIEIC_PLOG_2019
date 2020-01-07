:- use_module(library(clpfd)).

% 1. O programa gera duas listas, em que a primeira contem valores entre 1 e M,
%  e a segunda contem valores que correspondem a soma dos pares consecutivos dos elementos da primeira lista.

% 2. Sendo que a primeira lista podera ter elementos de 1 a M, para os N elementos havendo M^N possibilidades.
% Para a segunda lista, tal como podera ter elementos de 1 a M também, e tendo N-1 elementos, há M^(N-1) possibilidades.
% O total de possibilidades para o problema é entao : M^N * M^(N-1) = M^(2*N-1).

% 3. 

prog2(N,M,L1,L2) :-
  length(L1,N),
  N1 is N-1, length(L2,N1),
  domain(L1,1,M),
  domain(L2,1,M),
  all_distinct(L1),
  check(L1,L2),
  append(L1,L2,L),
  labeling([],L).

check([_],[]).
check([A,B|R],[X|Xs]) :-
  A+B #= X,
  check([B|R],Xs).
  
% 4.
mixed_pairs([],_,[],_).
mixed_pairs([M|Ms],WomenHeights,[I2|I2s],Delta):-
  element(I2,WomenHeights,W),
  M #> W,
  M-W #< Delta, 
  mixed_pairs(Ms,WomenHeights,I2s,Delta).

gym_pairs(MenHeights, WomenHeights,Delta,Pairs):-
  length(MenHeights,N),
  length(Pairs,N),
  length(IndexW,N),
  domain(IndexW,1,N),
  all_distinct(IndexW),
  mixed_pairs(MenHeights,WomenHeights,IndexW,Delta),
  labeling([],IndexW),
  makePairs(1,IndexW,Pairs).

makePairs(_,[],[]).
makePairs(Im,[Iw|Is],[Im-Iw|Ps]) :-
  Im1 is Im +1,
  makePairs(Im1,Is,Ps).

% 5.

minimum(N1,N2,N1) :-
  N1 #=< N2.

minimum(N1,N2,N2) :-
  N2 #=< N1.

optimal_skating_pairs(MenHeights,WomenHeights,Delta,Pairs) :-
  length(MenHeights,N1),
  length(WomenHeights,N2),
  minimum(N1,N2,Length),
  restrictPairs(MenHeights, WomenHeights, Delta, IndexMen,IndexWomen,Length,0,N),
  all_distinct(IndexMen),
  all_distinct(IndexWomen),
  append(IndexMen,IndexWomen,Vars),
  labeling([maximize(N)],Vars),!,
  makePairs2(IndexMen,IndexWomen,Pairs).

makePairs2([],[],[]).
makePairs2([M|Ms],[W|Ws],[M-W|Ps]) :-
  makePairs2(Ms,Ws,Ps).

restrictPairs(_,_,_,[],[],N,N,N).
restrictPairs(MenHeights,WomenHeights,Delta,[I1|I1s],[I2|I2s],N,CurrN,NMax) :-
  N #>= CurrN,
  element(I1,MenHeights,HeightM),
  element(I2,WomenHeights,HeightW),
  HeightM #>= HeightW,
  HeightM - HeightW #< Delta,
  NewN #= CurrN +1,
  restrictPairs(MenHeights,WomenHeights,Delta,I1s,I2s,N,NewN,NMax).

restrictPairs(_,_,_,[],[],N,Curr,Curr) :-
  N #>= Curr.
