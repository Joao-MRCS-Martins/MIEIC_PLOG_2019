:- use_module(library(clpfd)).
:- use_module(library(lists)).
% 1. Para cada presente dos N disponíveis, 
% este pode ou não ser atribuído a cada uma das K pessoas.
% Assim sendo, numa tabela N*K, temos 2 hipóteses para cada entrada
% (Ter ou não o presente), portanto temos 2^(N*K).

% 2. Neste caso, temos que os N presentes serão distribuidos pelas
% K pessoas. Sendo que cada pessoa pode ter até N pessoas, existem
% N possibilidades para cada pessoa, logo, K^N no total das K pessoas.

% 3. O programa obtém soluções onde o índice do presente (na lista Vars) 
% difere do índice da pessoa a quem lhe é atribuído, na sua paridade.
% Por exemplo, o 1º presente da lista será atribuido à 2ª pessoa ou 4ª, 6ª,etc.

% 4. Sendo que a restrição obriga a que uma variável possua valores pares OU impares,
% implica que os limites do domínio sejam alterados, pois consoante a paridade que é 
% necessário o valor terá o limite inferior ou superior alterado

% 5. 

constroi_binarias(I,K,Vars,[LBin|LBins]) :-
  I =< K, !,
  constroi_bins(I,Vars,LBin),
  I1 is I+1,
  constroi_binarias(I1,K,Vars,LBins).
constroi_binarias(_,_,_,[]).

constroi_bins(_,[],[]).
constroi_bins(I,[Var|Vars],[Bin|LBin]) :-
  I #= Var #<=> Bin,
  constroi_bins(I,Vars,LBin).

% 6. A variavel de decisão será a lista de índices que correspondem ao compartimento 
% atribuído a cada objeto. O seu domínio sera de 1 até N, sendo este o numero de compartimentos.
% Em termos de restrições é preciso restringir a soma dos volumes dos objetos de cada compartimento,
% de forma a que esta não seja superior a capacidade volúmica do próprio compartimento onde se inserem.
% Depois é necessário restringir a soma dos pesos em cada compartimento, de forma a ser inferior ao peso
% da soma dos pesos dos objetos do compartimento diretamente abaixo.

% 7.
% prat([[30,6],[75,15]],[176-40,396-24,474-35,250-8,149-5,479-5],Vars).

armario([[20,30,6,50],[50,75,15,125],[60,90,18,150],[30,45,9,75],[40,60,12,100]]).
objetos([114-54,305-30,295-53,376-39,468-84,114-48,337-11,259-80,473-28,386-55,
  258-39,391-37,365-76,251-18,144-42,399-94,463-48,473-9,132-56,367-8]).

prat([Head|Tail],Objs,Vars) :-
  length(Head,NCols),
  append([Head|Tail],All),
  length(All,Size),
  length(Objs,MaxS),
  length(Vars,MaxS),
  domain(Vars,1,Size),

  makeTasks(Objs,Vars,Tasks),
  makeMachines(1,All,Machines),
  getWeights(Objs,Wgts),
  getCompWeights(Size,Wgts,Vars,Weights),!,
  cumulatives(Tasks,Machines,[bound(upper)]),
  Length is Size - NCols + 1,
  constrainWgts(1,Length,Weights,NCols),
  labeling([], Vars).

makeTasks([],[],[]).
makeTasks([_-Vol|Os],[Var|Vs],[task(0,1,1,Vol,Var)|Ts]) :-
  makeTasks(Os,Vs,Ts).

makeMachines(_,[],[]).
makeMachines(Curr,[Vol|Vs],[machine(Curr,Vol)|Ms]) :-
  N1 is Curr+1, makeMachines(N1,Vs,Ms).

getWeights([],[]).
getWeights([W-_|Os],[W|Ws]) :-
  getWeights(Os,Ws).

getCompWeights(0,_,_,[]).
getCompWeights(N,Wgts,Vars,[Wgt|Ws]) :-
  getAllComp(N,Wgts,Vars,Wgt),
  N1 is N - 1,
  getCompWeights(N1,Wgts,Vars,Ws).

getAllComp(_,[],[],0).
getAllComp(N,[W|Ws],[I|Is],Sum) :-
  N #= I #<=> R,
  Sum #= W*R + SumRest,!,
  getAllComp(N,Ws,Is,SumRest).

constrainWgts(Size,Size,_,_).
constrainWgts(Curr,Size,Wgts,NCols) :-
  element(Curr,Wgts,Wgt1),
  AboveComp is Curr + NCols,
  element(AboveComp,Wgts,Wgt2),
  Wgt2 #=< Wgt1,
  NCurr is Curr + 1,
  constrainWgts(NCurr,Size,Wgts,NCols).

% 8. Para resolver este problema, pode-se analisar como um problema de atribuição de tarefas.
% Assim sendo, as variaveis de decisão serão os tempos de início e fim de cada tarefa,
% cujos dominios se encontram entre 1 e o tempo máximo permitido.

% 9. 

objeto(piano,3,30).
objeto(cadeira,1,10).
objeto(cama,3,15).
objeto(mesa,2,15).
homens(4).
tempo_max(60).

furniture :-
  homens(MaxRes),
  tempo_max(MaxTime),
  findall(Obj-Res-Dur,objeto(Obj,Res,Dur),Objs),
  length(Objs,N),
  length(Ss,N),
  length(Es,N),
  domain(Ss,0,MaxTime),
  domain(Es,0,MaxTime),
  makeTasks(Objs,Tasks,Ss,Es),
  maximum(End,Es),
  End #=< MaxTime,
  cumulative(Tasks,[limit(MaxRes)]),
  labeling([minimize(End)],Ss),
  displayResults(End,Tasks).

makeTasks([],[],[],[]).
makeTasks([Obj-Res-Dur|Objs],[task(S,Dur,E,Res,Obj)|Ts],[S|Ss],[E|Es]) :-
  makeTasks(Objs,Ts,Ss,Es).

displayResults(End,Tasks) :-
  write('Total Time: '), write(End),nl,
  displayTasks(Tasks).

displayTasks([]).
displayTasks([task(S,_,E,_,Obj)|Ts]) :-
  write(Obj),write(': '),write(S),write('-'),write(E),nl,
  displayTasks(Ts).
