:- dynamic
    film/4.

film('Doctor Strange',[action,adventure,fantasy],115,7.6).
film('Hacksaw Ridge',[biography,drama,romance],131,8.7).
film('Inferno',[action,adventure,crime],121,6.4).
film('Arrival',[drama,mystery, scifi],116,8.5).
film('The Accountant',[action,crime,drama],127,7.6).
film('The Girl on the Train',[drama,mystery,thriller],112,6.7).

user(john,1992,'USA').
user(jack,1989,'UK').
user(peter,1983,'Portugal').
user(harry,1993,'USA').
user(richard,1982,'USA').

vote(john,['Inferno'-7,'Doctor Strange'-9,'The Accountant'-6]).
vote(jack,['Inferno'-8,'Doctor Strange'-8,'The Accountant'-7]).
vote(peter,['The Accountant'-4,'Hacksaw Ridge'-7,'The Girl on the Train'-3]).
vote(harry,['Inferno'-7,'The Accountant'-6]).
vote(richard,['Inferno'-10,'Hacksaw Ridge'-10,'Arrival'-9]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

curto(Movie) :-
  film(Movie,_,D,_),
  D < 125.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

diff(User1,User2,Diff,Film) :-
  vote(User1,Votes1),
  vote(User2,Votes2),
  getVote(Votes1,Film,V1), % or member(Film-Score1,Votes1),
  getVote(Votes2,Film,V2), % member(Film-Score2,Votes2)
  Diff is abs(V1-V2).

getVote([],_,_) :- fail.
getVote([Film-Vote|_],Film,Vote).
getVote([_|Films],Film,Vote) :- getVote(Films,Film,Vote).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

niceGuy(User) :-
  vote(User,Votes1),
  member(Film-Score1,Votes1),
  member(Film2-Score2,Votes1),
  Film \= Film2, Score1 >= 8,
  Score2 >= 8.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elemsComuns([],[],_).
elemsComuns([C|L1],[C|Cs],L2) :- member(C,L2),!,elemsComuns(L1,Cs,L2).
elemsComuns([_|L1],C,L2) :- !,elemsComuns(L1,C,L2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

printCategory(Cat) :-
  film(Film,Cats,Dur,Rate),
  member(Cat,Cats),
  write(Film),write(' ('),write(Dur),write('min, '),write(Rate),write('/10)'),nl,
  fail.

printCategory(_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

similarity(Film1,Film2,Sim) :-
  film(Film1,Cats1,Dur1,Rate1),
  film(Film2,Cats2,Dur2,Rate2),
  getPerCommon(Cats1,Cats2,Perc),
  DurDiff is abs(Dur1-Dur2),
  RateDiff is abs(Rate1-Rate2),
  Sim is Perc - (3* DurDiff) - (5* RateDiff).

getPerCommon(Cat1,Cat2,Perc) :-
  elemsComuns(Cat1,Com,Cat2),
  length(Cat1,C1),
  length(Cat2,C2),
  length(Com,C),
  TotDist is C1 + C2 - C,
  Perc is C/TotDist * 100.
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mostSimilar(Film,Sim,[F1|Films]) :-
  findall(S-F,(film(F,_,_,_),F\=Film,similarity(Film,F,S),S>10),Matches),
  sort(Matches,Sorted),!,
  reverse(Sorted,TopMatches),
  TopMatches = [Sim-F1|TopM],
  getTopMatch(TopM,Sim,Films).

mostSimilar(_,0,[]).

reverse(L1,L2) :- reverse(L1,[],L2).
reverse([L|Ls],Acc,L2) :- reverse(Ls,[L|Acc],L2).
reverse([],L2,L2).

getTopMatch([],_,[]):-!.
getTopMatch([S-F|Ts],S,[F|Fs]) :- !,getTopMatch(Ts,S,Fs).
getTopMatch(_,_,[]):-!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

distancia(User1,Dist,User2) :-
  getAvgVoteDiff(User1,User2,AvgDiff),
  getAgeCountryDiff(User1,User2,AgeDiff,CountryDiff),
  Dist is AvgDiff + AgeDiff/3 + CountryDiff.

getAvgVoteDiff(U1,U2,AvgDiff) :-
  findall(Dif,(film(Film,_,_,_),diff(U1,U2,Dif,Film)),Difs),
  sumList(Difs,Sum),
  length(Difs,Total),
  AvgDiff is Sum/Total.

sumList([],0).
sumList([D|Ds],S) :-
  sumList(Ds,S1),
  S is S1+D.

getAgeCountryDiff(U1,U2,AgeD,CntD) :-
  user(U1,Age1,C1),
  user(U2,Age2,C2),
  AgeD is abs(Age1-Age2),
  getCtryDiff(C1,C2,CntD).

getCtryDiff(C,C,0).
getCtryDiff(C,C1,2) :- C \= C1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX9 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

update(Film) :-
  retract(film(Film,Tags,Dur,_)),
  findall(V,(vote(_,Votes),getVote(Votes,Film,V)),Votes),
  length(Votes,All),
  sumList(Votes,Sum),
  VoteAvg is Sum/All,
  assert(film(Film,Tags,Dur,VoteAvg)).
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX10 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%O predicado calcula a média dos votos de um utilizador.
%U - User
%A - Avg
%VL - VoteList
%V - Vote
%Vs - Votes
%L - Total
%S - Sum
%
%O cut é verde, pois impede procura por solucoes inexistentes.
%Ou seja impede que o backtracking tente procurar outra lista de votos de um 
%utilizador, quando não existe mais nenhuma.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX11 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

move(L/C,Move) :-
  L >= 1, L=<8,C>=1,C=<8,
  List = [1,2,3,4,5,6,7,8],!,
  findall(Row/Col,(member(Row,List),member(Col,List),validMove(L,C,Row,Col)),Move).

validMove(L,C,Row,Col) :- Row is L+1, Col is C + 2.
validMove(L,C,Row,Col) :- Row is L+1, Col is C - 2.
validMove(L,C,Row,Col) :- Row is L-1, Col is C + 2.
validMove(L,C,Row,Col) :- Row is L-1, Col is C - 2.
validMove(L,C,Row,Col) :- Row is L+2, Col is C + 1.
validMove(L,C,Row,Col) :- Row is L+2, Col is C - 1.
validMove(L,C,Row,Col) :- Row is L-2, Col is C + 1.
validMove(L,C,Row,Col) :- Row is L-2, Col is C - 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX12 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

podeMoverEmN(_,0,[]).
podeMoverEmN(L/C,1,Celulas) :- !,move(L/C,Celulas).
podeMoverEmN(L/C,N,Celulas) :- 
  move(L/C,Moves),
  N1 is N-1,
  findall(M,(member(L1/C1,Moves),podeMoverEmN(L1/C1,N1,M)),Moves2),
  !,append_list(Moves2,[],Cels),
  append(Moves,Cels,Cels2),
  remove_dups(Cels2,Cels3),
  sort(Cels3,Celulas),!.

remove_dups([],[]):-!.
remove_dups([L|Ls],[C|Cs]) :-
  \+(member(L,Ls)),
  C = L,
  remove_dups(Ls,Cs).
remove_dups([_|Ls],C) :- !,remove_dups(Ls,C).

append_list([],L,L).
append_list([L|Ls],Aux,T) :- 
  append(Aux,L,Aux2),!,
  append_list(Ls,Aux2,T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX13 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

minJogadas(P1,P1,0).
minJogadas(P1,P2,N) :-
  minJogadas(P1,P2,1,N).

minJogadas(P1,P2,Curr,N) :-
  podeMoverEmN(P1,Curr,Pos),
  member(P2,Pos),
  N is Curr,!.

minJogadas(P1,P2,Curr,N) :-
  N1 is Curr +1,
  minJogadas(P1,P2,N1,N).