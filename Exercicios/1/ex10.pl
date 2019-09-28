comprou(joao, honda).
ano(honda, 1997).
comprou(joao, uno).
ano(uno, 1998).
valor(honda, 20000).
valor(uno, 7000).

pode_vender(Pessoa,Carro,AnoV):- comprou(Pessoa,Carro),
                                ano(Carro,AnoC),
                                AnoV-AnoC < 10,
                                valor(Carro,Value),
                                Value < 10000.