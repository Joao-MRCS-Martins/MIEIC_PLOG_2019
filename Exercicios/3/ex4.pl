myinverter(L1,L2):- inv(L1,[],L2).
inv([],I1,I1).
inv([H|T],I2,I1) :- inv(T,[H|I2],I1).