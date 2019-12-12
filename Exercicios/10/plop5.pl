:- use_module(library(clpfd)).

chores(Tarefas,Custo) :-
  %1 - Maria, 2 - Joao,
  Tarefas = [T1,T2,T3,T4],
  global_cardinality(Tarefas, [1-2,2-2]),
  Compras = [45,49],
  Cozinha = [78,72],
  Lavagem = [36,43],
  Limpeza = [29,31],
  Custo #= C1 + C2 + C3 + C4,
  element(T1, Compras, C1),
  element(T2, Cozinha, C2),
  element(T3, Lavagem, C3),
  element(T4, Limpeza, C4),
  labeling([minimize(Custo)],Tarefas).

  
  

  