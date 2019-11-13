misterio([],[]) :-!.
misterio([X],[X]) :-!.
misterio([X,Y|L],[X,censurado|M]):- misterio(L,M).
