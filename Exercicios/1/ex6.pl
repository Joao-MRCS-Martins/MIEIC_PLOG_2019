passaro('Tweety').
peixe('Goldie').
minhoca('Molie').
gato('Silvester').
gosta_de(Animal1,Animal2):- (passaro(Animal1),minhoca(Animal2));
                            (gato(Animal1),peixe(Animal2));
                            (gato(Animal1),passaro(Animal2));
                            (Animal1 == 'Eu', Animal2 == 'Silvester');
                            (Animal1 == 'Silvester', Animal2 == 'Eu').
amigos(Animal1,Animal2):- gosta_de(Animal1,Animal2),gosta_de(Animal2,Animal1).
/*A*/
silvester_come(Animal):- gosta_de('Silvester',Animal),
                        \+amigos('Silvester',Animal). %added condition to make sense