%participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

%performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% P1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
madeItThrough(P) :-
    performance(P,L),
    check_perf(L).

check_perf([]) :- fail.
check_perf([E|Rest]) :-
    E == 120; check_perf(Rest).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% P2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
juriTimes(Parts,JMem,Times,Tot) :-
    juriTimes(Parts,JMem,Times,0,Tot).

juriTimes([],_,[],Tot,Tot).
juriTimes([E|Parts],Mem,[T|Ts],Curr,Tot) :-
    getJuryTime(E,Mem,T),
    Curr1 is Curr+T,
    juriTimes(Parts,Mem, Ts,Curr1,Tot).

getJuryTime(E,Mem,T) :-
    performance(E,L),
    getTime(L,Mem,T).

getTime([T|_],1,T).
getTime([_|Rest],N,T):-
    N1 is N-1,
    getTime(Rest,N1,T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% P3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%patientJuri(M) :-
%    getJuryTimes(M,[],L),
%    countPatience(L,0,C),
%    C > 1.
%
%getJuryTimes(M,Aux,L) :-
%    !,performance(E,L),
%    getJuryTime(E,M,T),
%    append(Aux,[T],Aux2),
%    getJuryTimes(M,Aux2,L).
%
%getJuryTimes(_,L,L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% P4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bestParticipant(P1,P2,P):-
    performance(P1,L1),
    performance(P2,L2),    
    getTotalPts(L1,0,Pt1),
    getTotalPts(L2,0,Pt2),
    ((Pt1 > Pt2, P is P1);
    (Pt2 > Pt1, P is P2)).

getTotalPts([],Pts,Pts):-!.
getTotalPts([Pt|Ps],PtA,Pts) :-
    PtAux is Pt + PtA,
    getTotalPts(Ps,PtAux,Pts).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% P5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
allPerfs :-
    participant(ID,_,Perf),performance(ID,L),
    print(ID),print(':'),print(Perf),print(':'),print(L),nl,
    fail.

allPerfs :- true.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% P6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nSuccessfulParticipants(T):-
    findall(X,(performance(X,L),successful(L)),Bag),
    length(Bag,T).

successful([]) :- true.
successful([T|Ts]) :- (T == 120,successful(Ts));fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% P7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
juriFans(L) :-
    findall(E-J,(!,performance(E,L),gotJuriVote(L,1,J)),L).

gotJuriVote([],_,[]):-!.
gotJuriVote([T|Ts],N,J):- T \=120, N1 is N+1,!,gotJuriVote(Ts,N1,J).
gotJuriVote([_|Ts],N,[J|Js]) :- J is N, N1 is N+1, !,gotJuriVote(Ts,N1,Js).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% P8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- use_module(library(lists)).

eligibleOutcome(Id,Perf,TT) :-
    performance(Id,Times),
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumlist(Times,TT).

nextPhase(N,P) :-
    setof(T-ID-Perf,eligibleOutcome(ID,Perf,T),Set),
    length(Set,Size),Size >= N, N1 is Size-N,
    getNBest(N1,Set,P).

getNBest(0,Set,Ls) :- inverte(Set,[],Ls).
getNBest(N,[_|Set],Ls) :- N1 is N-1,getNBest(N1,Set,Ls).

inverte([],L,L).
inverte([S|Set],Aux,L):-
    append([S],Aux,Aux2),
    inverte(Set,Aux2,L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% P9 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%O predicado predX/3 percorre uma lista de ID de participantes, R, e guarda numa lista P, 
%todas as performances cujos participantes tem uma idade menor ou igual a Q. O cut utilizado 
%neste caso é verde, pois apenas evita explorar espaço de pesquisa onde é impossivel estar 
%uma solução.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% P10 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%O seguinte predicado recebe como argumento um numero e X e uma sequencia de numeros L, e 
%verifica se a condição acima indicada, existe. Ou seja, se há uma sub-sequencia, começada e
%terminada em X, cujo tamanho de intervalo entre os dois numeros é também X.
%O length(Mid,X) confirma se o comprimento do intervalo é X; append(L1,[X|_],L) vai obter a 
%subsequencia do inicio até antes do segundo X, L1; append(_[X|Mid],L1), vai obter a 
%sequencia do meio dos numeros X, a partir de L1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% P11 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
impoe(X,L) :-
    length(Mid,X),
    append(L1,[X|_],L), append(_,[X|Mid],L1).

impoe(X,L) :-
    length(Mid,X),
    append(L1,[X|_],L),!, append(_,[X|Mid],L1).

langford(N,L) :-
    S is 2*N,
    length(L,S),
    impoe_list(N,L).

impoe_list(0,_).
impoe_list(N,L) :-
    N1 is N-1,
    impoe(N,L),
    impoe_list(N1,L).


























