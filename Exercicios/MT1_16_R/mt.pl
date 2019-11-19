:- dynamic film/4, user/3, vote/2.

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ex1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

raro(Movie) :-
  film(Movie,_,Dur,_),
  Dur < 60.

raro(Movie) :-
  film(Movie,_,Dur,_),
  Dur > 120.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ex2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

happierGuy(U1,U2,U1) :-
  vote(U1,Votes1),
  sumVote(Votes1,Sum1),
  length(Votes1,N1),
  Avg1 is Sum1/N1,
  vote(U2,Votes2),
  sumVote(Votes2,Sum2),
  length(Votes2,N2),
  Avg2 is Sum2/N2,
  Avg1 > Avg2,!.

happierGuy(_,U2,U2).

sumVote([],0).
sumVote([_-S|Vs],Sum) :-
  sumVote(Vs,S1),
  Sum is S + S1.
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ex3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

likedBetter(U1,U2) :-
  vote(U1,V1),
  vote(U2,V2),
  member(F-S1,V1),
  member(F-S2,V2),
  S1 > S2,!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ex4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

recommends(User,Movie) :-
  vote(User,V1),
  vote(_U2,V2),
  checkAll(V1,V2),!,
  getOther(V1,V2,Movies),
  Movies = [Movie|_].

checkAll([],_).
checkAll([F-_|Fs],M2) :-
  member(F-_,M2),
  checkAll(Fs,M2).

getOther(_,[],[]).
getOther(M1,[F1-_|Ms],[F1|Ls]) :-
  \+(member(F1-_,M1)),!,
  getOther(M1,Ms,Ls).

getOther(M1,[_|Ms],L) :-
  !,getOther(M1,Ms,L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ex5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

invert(Pred,Arity) :-
  invert(Pred,Arity,[],Facts),
  assertFacts(Facts).

invert(Pred,Arity,Aux,Facts) :-
  functor(Fact, Pred, Arity),
  retract(Fact),
  append([Fact],Aux,Aux2),
  invert(Pred,Arity,Aux2,Facts).

invert(_,_,Facts,Facts).

assertFacts([]).
assertFacts([Fact|Fs]) :-
  assert(Fact),
  assertFacts(Fs).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ex6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

onlyOne(U1,U2,OnlyOneList) :-
  findall(F, (vote(U1,L),member(F-_,L),vote(U2,L1),\+member(F-_,L1)),Only1),
  findall(F,(vote(U2,L),member(F-_,L),vote(U1,L1),\+member(F-_,L1)),Only2),
  append(Only1,Only2,OnlyOneList).
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ex7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filmVoting :-
  film(F,_,_,_),
  findall(U-V,(vote(U,L),member(F-V,L)),Votes),
  assert(filmUsersVotes(F,Votes)),
  fail.

filmVoting.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ex8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dumpDataBase(FileName) :-
  tell(FileName),
  listing,
  told.
  
  







































