:- use_module(library(clpfd)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. O programa cria uma lista ordenada a partir de uma lista dada. 
% No entanto, não é muito eficiente, pois o predicado de select executado em cada 
% elemento da lista torna-se pesado, além de que o teste da ordenacao é feito 
% separadamente do teste de igualdade, logo a lista é percorrida duas vezes, 
% prejudicando a sua eficiência.


% 2. Opcao a. (nth1/3, instancia as variaveis. element/3 deveria ter sido usado. 
%  o predicado test/1 restringe a ordem, deve ser colocado antes do labeling).

% 3.

p2(L1,L2) :-
  length(L1,N),
  length(L2,N),
  length(Is,N),
  all_distinct(Is),  
  pos(L1,L2,Is),
  test(L2),
  labeling([],Is).
  
pos([],_,[]).
pos([X|Xs],Y,[I|Is]) :-
  element(I,Y,X),
  pos(Xs,Y,Is).

test([_]).
test([_,_]) :- !.
test([X1,X2,X3|Xs]) :-
  X1 #=< X2, X2 #=< X3,
  test([X2,X3|Xs]).

test([X1,X2,X3|Xs]) :-
  X1 #>= X2, X2 #>= X3,
  test([X2,X3|Xs]).

% 4.

sweet_recipes(MaxT,NEggs,RecipesT,RecipesEggs,Cookings,Eggs) :-
  length(RecipesT,N),
  length(RecipesEggs,N),
  length(Cookings,3),
  domain(Cookings,1,N),
  all_distinct(Cookings),
  restrictTimesNEggs(Cookings,RecipesT,RecipesEggs,MaxT,NEggs,Eggs),
  labeling([maximize(Eggs)],Cookings).
  

restrictTimesNEggs(Cookings,RecipesT,RecipesEggs,MaxT,NEggs,Eggs) :-
  R1 #< R2, R2 #< R3,
  element(1,Cookings,R1), element(2,Cookings,R2), element(3,Cookings,R3),
  element(R1,RecipesT,T1), element(R2,RecipesT,T2), element(R3,RecipesT,T3),
  element(R1,RecipesEggs,E1), element(R2,RecipesEggs,E2), element(R3,RecipesEggs,E3),
  T1 + T2 + T3 #=< MaxT,
  E1 + E2 + E3 #= Eggs,
  Eggs #=< NEggs.
  
% 5. 

cut(Shelves,Boards,Selected) :-
  length(Shelves,N),
  length(Selected,N),
  length(Boards,N1),
  domain(Selected,1,N1),
  makeTasks(Shelves,Selected,Tasks),
  makeMachines(Boards,1,Machines),
  cumulatives(Tasks,Machines,[bound(upper)]),
  labeling([],Selected).

makeTasks([],[],[]).
makeTasks([Sh|Ss],[Se|Ls],[task(0,1,1,Sh,Se)|Tas]) :-
  makeTasks(Ss,Ls,Tas).

makeMachines([],_,[]).
makeMachines([B|Brds],N,[machine(N,B)|Ms]) :-
  N1 is N+1, makeMachines(Brds,N1,Ms).