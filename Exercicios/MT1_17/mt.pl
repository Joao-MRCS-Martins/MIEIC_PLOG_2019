:- dynamic
    played/4.

%player(Name,UserName,Age)
player('Danny','Best Player Ever',27).
player('Annie','Worst Player Ever',24).
player('Harry','A-Star Player',26).
player('Manny','The Player',14).
player('Jonny','A Player',16).

%game(Name,Categories,MinAge).
game('5 ATG',[action,adventure,open-world,multiplayer],18).
game('Carrier Shift: Game Over',[action,fps,multiplayer,shooter],16).
game('Duas Botas',[action,free,strategy,moba],12).

%played(Player,Game,HoursPlayed,PercentUnlocked)
played('Best Player Ever','5 ATG',3,83).
played('Worst Player Ever','5 ATG',52,9).
played('The Player','Carrier Shift: Game Over',44,22).
played('A Player','Carrier Shift: Game Over',48,24).
played('A-Star Player','Duas Botas',37,16).
played('Best Player Ever','Duas Botas',33,22).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
achievedALot(Player) :-
  played(Player,_,_,Per),
  Per >= 80.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
isAgeAppropriate(Name,Game) :-
  player(Name,_,Age),
  game(Game,_,Min),
  Min =< Age.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
timePlayingGames(_,[],[],0).
timePlayingGames(Player,[G1|Gs],[L1|Ls],ST) :-
  played(Player,G1,T,_),!,
  L1 is T,
  timePlayingGames(Player,Gs,Ls,S1),
  ST is T + S1.

timePlayingGames(Player,[_|Gs],[L1|LT],ST) :-
  L1 is 0,
  timePlayingGames(Player,Gs,LT,ST).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
listGamesOfCategory(Cat) :-
  game(N,CatList,Age),
  member(Cat,CatList),
  print(N),print(' '), print('('),print(Age),print(')'),nl,
  fail.

listGamesOfCategory(_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
updatePlayer(Player,Game,Hours,Perc) :-
  retract(played(Player,Game,CHours,CPerc)),!,
  NewHours is CHours + Hours,
  NewPerc is CPerc + Perc,
  assert(played(Player,Game,NewHours,NewPerc)).

updatePlayer(Player,Game,Hours,Perc) :-
  assert(played(Player,Game,Hours,Perc)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fewHours(Player,Games) :-
  fewHours(Player,[],Games).

fewHours(Player,AuxGames,Games) :-
  played(Player,Game,H,_),
  H < 10,
  \+(member(Game,AuxGames)),!,
  fewHours(Player,[Game|AuxGames],Games).

fewHours(_,Games,Games).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX 7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ageRange(MinAge,MaxAge,Players) :-
  findall(P,(player(P,_,Age),MinAge =< Age,MaxAge >= Age),Players).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX 8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
averageAge(Game,Avg) :-
  findall(Age,(played(X,Game,_,_),player(_,X,Age)),Ages),
  sumHours(Ages,Sum),
  length(Ages,N),
  Avg is Sum/N.

sumHours([],0).
sumHours([T|Ts],Sum) :-
  sumHours(Ts,Sum1),
  Sum is T + Sum1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX 9 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mostEffectivePlayers(Game,Players) :-
  findall(Rate-Player,(played(Player,Game,H,P),Rate is P/H),Ranks),
  sort(Ranks,SortedRanks),
  reverse(SortedRanks,TopRanks),!,
  getTopPlayers(TopRanks,Players).

getTopPlayers([Rate-Player|Rs],[Player|Ps]) :-
  getTopPlayers(Rs,Rate,Ps).

getTopPlayers([],_,[]) :- !.
getTopPlayers([Rate-Player|Rs],Rate,[Player|Ps]) :- !,getTopPlayers(Rs,Rate,Ps).
getTopPlayers(_,_,[]).
 
reverse(L,R) :-
  reverse(L,[],R).

reverse([],R,R).
reverse([L1|Ls],Raux,R) :-
  append([L1],Raux,Raux2),
  reverse(Ls,Raux2,R).

%%%%%%%%%%%%%%%%%%%% EX 14 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ex13(D) :-
  Dendo = [1,
            [2,
              [3,
                [5,
                  [8,
                    australia,
                    [9,
                      [10,
                        stahelena,
                        anguila],
                      georgiadosul]],
                reinounido],
              [6,
                servia,
                franca]],
            [4,
              [7,
                niger,
                india],
              irlanda]],
            brasil],2
distance(brasil,niger,Dendo,D).
%TO CONTINUE
