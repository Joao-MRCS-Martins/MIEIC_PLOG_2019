airport('Aeroporto Franciso Sá Carneiro','LPPR','Portugal').
airport('Aeroporto Humberto Delgado','LPPT','Portugal').
airport('Aeropuerto Adolfo Suárez Madrid-Barajas','LEMD','Spain').
airport('Aéroport de Paris-Charles-de-Gaulle Roissy Airport','LFPG','France').
airport('Aeroporto Internazionale di Roma-Fiumicino - Leonardo da Vinci','LIRF','Italy').

company('TAP','TAP Air Portugal',1945,'Portugal').
company('RYR','Ryanair',1984,'Ireland').
company('AFR','Société Air France, S.A.',1933,'France').
company('BAW','British Airways',1974,'United Kingdom').

flight('TP1923','LPPR','LPPT',1115,55,'TAP').
flight('TP1968','LPPT','LPPR',2235,55,'TAP').
flight('TP842','LPPT','LIRF',1450,195,'TAP').
flight('TP843','LIRF','LPPT',1935,195,'TAP').
flight('FR5483','LPPR','LEMD',630,105,'RYR').
flight('FR5484','LEMD','LPPR',1935,105,'RYR').
flight('AF1024','LFPG','LPPT',940,155,'AFR').
flight('AF1025','LPPT','LFPG',1310,155,'AFR').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX 1 %%%%%%%%%%%%%%%%%%%%%%%%%
short(Flight) :-
  flight(Flight,_,_,_,Dur,_),
  Dur < 90.

%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%
shorter(F1,F2,SF) :-
  flight(F1,_,_,_,T1,_),
  flight(F2,_,_,_,T2,_),
  ((T1 < T2,SF = F1) ; (T2 < T1,SF = F2)).

%%%%%%%%%%%%%%%%%%%%%%%%%%% EX 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%
arrivalTime(Flight,ArrivalTime) :-
  flight(Flight,_,_,Depar,Dur,_),
  AuxMins is Depar mod 100,
  AuxHrs is Depar - AuxMins,
  TotMin is AuxMins+Dur,
  Hours is TotMin//60,
  Minutes is TotMin mod 60,
  ArrivalTime is AuxHrs + Hours*100+Minutes.

%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
countries(Company,List) :-
  country(Company,[],List).

country(Company,Aux,List) :-
  airport(_,_,Country),
  operates(Company,Country),
  \+(member(Country,Aux)),
  append(Aux,[Country],Aux2),!,
  country(Company,Aux2,List).
country(_,List,List) :-!.

operates(Company,Country):-
  company(Company,_,_,_),
  flight(_,ID,_,_,_,Company),
  airport(_,ID,Country).

operates(Company,Country) :-
  company(Company,_,_,_),
  flight(_,_,ID,_,_,Company),
  airport(_,ID,Country).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pairableFlights :-
  flight(F1,_,Dest,_,_,_),
  flight(F2,Dest,_,Depar2,_,_),
  arrivalTime(F1,A),
  getDiffTime(A,Depar2,Diff),
  Diff >= 30, Diff =< 90,
  write(Dest),write(' - '),write(F1),write(' \\ '),write(F2),nl,
  fail.
  
pairableFlights.

getDiffTime(T1,T2,Diff) :-
  T2M is T2 mod 100,
  T2H is T2 - T2M,
  T1M is T1 mod 100,
  T1H is T2 - T1M,
  DiffH is T2H-T1H,
  Diff is DiffH//60 + (T2M - T1M).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX 7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
avgFlightLengthFromAirport(ID,Avg) :-
  findall(Duration,flight(_,ID,_,_,Duration,_),Times),
  timesSum(Times, Sum),
  length(Times,N),
  Avg is Sum /N.
  
timesSum([],0).
timesSum([T|Ts],Sum) :-
  timesSum(Ts,Sum1),
  Sum is T + Sum1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX 8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mostInternational(Companies) :-
  findall(N-Company,(company(Company,_,_,_),countries(Company,List),length(List,N)),Ranked),
  sort(Ranked,SRanked),
  reverse(SRanked, MostInter),
  getBest(MostInter,Companies).

reverse(L,R) :-
  reverse(L,[],R).

reverse([],R,R).
reverse([L1|Ls],Raux,R) :-
  append([L1],Raux,Raux2),
  reverse(Ls,Raux2,R).

getBest([N-Company|Ls],[Company|Cs]) :-
  getBest(Ls,N,Cs).

getBest([],_,[]) :- !.
getBest([N-Company|Ls],N,[Company|Cs]) :- !,getBest(Ls,N,Cs).
getBest(_,_,[]).

%%%%%%%%%%%%%%%%%%%%%%%%% EX 9  // EX 10 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dif_max_2(X,Y) :- X < Y, X >= Y-2.

make_pairs(L,P,S) :-
  findall(N1-N2,(member(N1,L),member(N2,L),N1 \= N2,M =.. [P,N1,N2],M),Pairs),
  filterMatched(Pairs,[],S).

filterMatched([],_,[]).
filterMatched([N1-N2|Ps],Aux,[S1-S2|Ss]) :-
  \+member(N1,Aux),\+member(N2,Aux),
  S1 is N1,S2 is N2,
  append([N1,N2],Aux,Aux2),% add !, if ex not 11
  filterMatched(Ps,Aux2,Ss).

filterMatched([_|Ps],Aux,S) :-
  filterMatched(Ps,Aux,S).

%%%%%%%%%%%%%%%%%%%%%%%%%%% EX 11 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

make_pairs_2(L,P,S) :-
  findall(N1-N2,(member(N1,L),member(N2,L),N1 \= N2,M =.. [P,N1,N2],M),Pairs),
  setof(N-F,(filterMatched(Pairs,[],F),length(F,N)),Max),
  reverse(Max,[_-S|_]).

make_max_pairs(L,P,S) :-
  make_pairs_2(L,P,S).