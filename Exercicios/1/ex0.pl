male(phil).
male(luke).
female(claire).
parent(phil, luke).

father(x,y):- parent(x,y), male(x).
