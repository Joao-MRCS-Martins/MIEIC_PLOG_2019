ligado(a,b).
ligado(f,i).
ligado(a,c).
ligado(f,j).
ligado(b,d).
ligado(f,k).
ligado(b,e).
ligado(g,l).
ligado(b,f).
ligado(g,m).
ligado(c,g).
ligado(k,n).
ligado(d,h).
ligado(l,o).
ligado(d,i).
ligado(i,f).

dfs(Src,End,Path):- dfs(Src,End,Path,[Src]).
dfs(End,End,P,P).
dfs(Src,Dest,Path,T):-
  ligado(Src,Next),
  \+member(Next,T),
  append(T,[Next],Tn),
  dfs(Next,Dest,Path,Tn).

bfs(Src,End,Path):- bfs(End,Path,[],[Src]).
bfs(_,_,_,[]) :- fail.
bfs(End,Path,T,[Next|Rest]):-
\+member(Next,T),
append(T,[Next],Tn), !,
ligado(Next,End)->append(T,[Next],Path),
bfs(End,Path,Tn,Rest).