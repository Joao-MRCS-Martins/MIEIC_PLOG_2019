:- use_module(library(clpfd)).
:- use_module(library(lists)).

% 12.

ups_and_downs(Min,Max,N,L) :-
  N #>= 1,
  length(L, N),
  domain(L,Min,Max),
  constrain(L),
  labeling([],L).
  
constrain([N1,N2]) :- N1 #< N2.
constrain([N1,N2]) :- N1 #> N2.
constrain([N1,N2,N3|Ns]) :-
  N2 #< N1, N2 #< N3,
  constrain([N2,N3|Ns]).
constrain([N1,N2,N3|Ns]) :-
  N2 #> N1, N2 #> N3,
  constrain([N2,N3|Ns]).
  
% 13.

concelho(x,120,410).
concelho(y,10,800).
concelho(z,543,2387).
concelho(w,3,38).
concelho(k,234,376).

concelhos(NDias,MaxDist,VisCon,Dist,TotalEleit) :-
  findall(Nome-Dist-Elei,concelho(Nome,Dist,Elei),Concelhos),
  separateData(Concelhos,Dists,Eleits),
  visitConcelhos(Dists,Eleits,VisInd,0,NDias,Dist,TotalEleit),
  all_distinct(VisInd),  
  Dist #=< MaxDist,
  labeling([maximize(TotalEleit)],VisInd),
  fillVisCon(Concelhos,VisInd,VisCon).

separateData([],[],[]).
separateData([_-D-E|Cs],[D|Ds],[E|Es]) :-
  separateData(Cs,Ds,Es).

visitConcelhos(_,_,[],NDias,NDias,0,0).
visitConcelhos(Dists,Eleits,[I|Is],Curr,NDias,Dist,Eleit) :-
  Curr #=< NDias,
  element(I,Dists,D),
  element(I,Eleits,E),
  NewC is Curr + 1,
  visitConcelhos(Dists,Eleits,Is,NewC,NDias,SubDist,SubEleit),
  Dist #= D + SubDist,
  Eleit #= E + SubEleit.
visitConcelhos(_,_,[],Curr,NDias,0,0) :-
  NDias #>= Curr.

getTotalValue([],[],0).
getTotalValue([V|Vs],[B|Bs],Tot) :-
  Tot = V * B + SubTot,
  getTotalValue(Vs,Bs,SubTot).

fillVisCon(_,[],[]).
fillVisCon(Concelhos,[I|Is],[C|Cs]) :-
  nth1(I,Concelhos,C-_-_),
  fillVisCon(Concelhos,Is,Cs).
  